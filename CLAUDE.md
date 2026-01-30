# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`pony-odbc` is a Pony language wrapper for iODBC/unixODBC, providing database-agnostic access to RDBMS systems. The library consists of two layers: raw FFI bindings and a safer "simpler" API exposed through ODBCEnv, ODBCDbc, and ODBCStmt.

### Quick Example

```pony
use "pony-odbc"
use "lib:odbc"

actor Main
  new create(env: Env) =>
    try
      let oenv = ODBCEnv
      let dbc = oenv.dbc()?
      dbc.connect("mydsn")?

      let stmt = dbc.stmt()?
      stmt.prepare("SELECT id, name FROM users WHERE id > ?")?

      let input_id = SQLInteger
      let output_id = SQLInteger
      let output_name = SQLVarchar(100)

      stmt.bind_parameter(input_id)?
      stmt.bind_column(output_id)?
      stmt.bind_column(output_name)?

      input_id.write(5)
      while stmt.fetch_scroll()? do
        env.out.print(output_id.read()?.string() + ": " + output_name.read()?)
      end
    end
```

See `examples/new_api/main.pony` for a complete working example.

## Build System

This project uses Make with corral (Pony's package manager) for dependency management.

### Essential Commands

```bash
# Fetch dependencies (required before first build)
corral fetch

# Run unit tests (default: debug build)
make test

# Run unit tests with specific config
make unit-tests config=debug
make unit-tests config=release

# Build and run examples
make examples

# Clean build artifacts
make clean          # Clean build directory
make realclean      # Clean all build artifacts

# Generate documentation
make docs           # Outputs to build/pony-odbc-docs
```

### Running Individual Tests

The test suite is in `pony-odbc/tests/`. To run tests:

```bash
# Build test binary
corral run -- ponyc -o build/debug pony-odbc/tests -b pony-odbc

# Run all tests
./build/debug/pony-odbc

# Run specific test class
./build/debug/pony-odbc --only=TestClassName
```

### Database Configuration for Tests

Tests require ODBC DSNs configured in `/etc/odbc.ini` or `~/.odbc.ini`. Example configurations are in README.md for PostgreSQL, MariaDB, and SQLite.

The CI uses a custom container image (`ghcr.io/redvers/pony-dependency-builder:latest`) with PostgreSQL and MariaDB services.

## Architecture

### Three-Level Handle Hierarchy

ODBC operates on a strict handle hierarchy that must be created in order:

1. **ODBCEnv** (Environment Handle) - Global context, creates database connections
2. **ODBCDbc** (Database Connection Handle) - Represents a single database connection, creates statements
3. **ODBCStmt** (Statement Handle) - Executes SQL queries and manages result sets

Each level must be created from its parent using factory methods:
- `ODBCEnv.create()` → `env.dbc()?` → `dbc.stmt()?`

Handles are automatically freed via `_final()` methods when garbage collected.

### SQL Type System

The library uses a unified `SQLType` trait implemented by concrete types:
- `SQLInteger` (I32)
- `SQLBigInt` (I64)
- `SQLSmallInt` (I16)
- `SQLReal` (F32)
- `SQLFloat` (F64)
- `SQLVarchar` (variable-length strings)
- `SQLVarbinary` (binary data)

Each SQL type wraps a `CBoxedArray` for FFI interop and manages NULL values via indicator fields. Types implement `bind_parameter()` and `bind_column()` for prepared statements.

**Critical**: Variable-length types like `SQLVarchar` and `SQLVarbinary` must be allocated with sufficient buffer size upfront. `SQLVarchar(40)` creates a 40-byte buffer - writing longer strings will fail. For output columns, undersized buffers are auto-expanded during fetch, but input parameters require proper sizing.

### FFI Layer (`pony-odbc/ffi/`)

Two files provide raw ODBC bindings:
- `f.pony` - Function declarations (128KB of FFI signatures)
- `u.pony` - Utility constants and enumerations

The `ODBCFFI` primitive wraps all C function calls and handles error code resolution through `ODBCFFI.resolve()`.

### Error Handling

All public API methods are partial (`?`) and throw on ODBC errors. Each handle class implements:
- `strict: Bool` - When `true` (default), only `SQLSuccess` is accepted; when `false`, `SQLSuccessWithInfo` warnings are also treated as success
- `_check_valid()?` - Validates SQL return codes against strict mode
- `sqlstates()` - Returns diagnostic information as `Array[(String, String)]` (SQLSTATE code and message)

The `SQLReturn` hierarchy models ODBC return codes: `SQLSuccess`, `SQLSuccessWithInfo`, `SQLError`, `SQLNoData`, etc.

### Statement Execution Flow

1. **Prepare**: `stmt.prepare("SQL with ? placeholders")?`
2. **Bind Parameters**: Create `SQLType` objects, bind in order with `stmt.bind_parameter(param)?`
3. **Bind Columns** (for queries): Create output buffers, bind with `stmt.bind_column(col)?`
4. **Execute**: `stmt.execute()?` or `stmt.direct_exec(sql)?`
5. **Fetch Results**: Use `fetch()` or `fetch_scroll()` in a loop - returns `true` while rows remain, `false` when done
6. **Cleanup**: `stmt.finish()?` to close cursor and free statement resources for reuse

Parameters and columns are tracked in `_parameters: Array[SQLType]` and `_columns: Array[SQLType]` arrays, cleared on each `prepare()` or `finish()`.

### Auto-Expanding Column Buffers

`ODBCStmt._check_and_expand_column_buffers()` automatically resizes VARCHAR/VARBINARY buffers if truncation occurs during fetch, using `SQLGetData()` to retrieve full values. This allows undersized initial buffers while maintaining correctness.

### Transaction Management

Transactions are controlled at the `ODBCDbc` level:
- `set_autocommit(false)?` - Disable autocommit (must be set before `connect()`)
- `commit()?` - Commit current transaction
- `rollback()?` - Rollback current transaction

## Important Implementation Notes

### Statement Reuse

ODBCStmt instances can be reused across multiple prepare/execute cycles. The `prepare()` method clears previous bindings. However, be aware that some drivers may have issues with handle reuse (see PR #45 for a recent bug fix).

### NULL Handling

SQL NULL values are represented via indicator variables in each `SQLType`:
- `sqltype.null()` - Mark parameter as NULL before execute
- `sqltype.is_null()` - Check if fetched column is NULL
- Attempting `read()` on NULL values throws an error

### Memory Management

- C types (`CBoxedArray`, `CBoxedI32`, etc.) provide FFI-safe wrappers
- Wrapper classes (`EnvWrapper`, `DbcWrapper`, `StmtWrapper`) safely pass handles between FFI boundaries
- All ODBC handles use `_final()` to call `SQLFreeHandle` variants

### Library Linking

Users must include the package and link against an ODBC library:
```pony
use "pony-odbc"  // Import the pony-odbc package
use "lib:odbc"   // Link unixODBC (or use "lib:iodbc" for iODBC)
```

## Testing Strategy

The test suite (pony-odbc/tests/README.md) validates:
- Handle lifecycle and connection management
- SQL execution (prepare, execute, direct exec)
- Data type round-trips across multiple databases
- NULL value handling
- Transaction commit/rollback
- Error conditions and diagnostics
- Metadata queries (SQLGetTypeInfo, SQLTables, SQLColumns)

Tests run against PostgreSQL, MariaDB, and SQLite in CI to ensure cross-database compatibility.

## Key Files

- `pony-odbc/pony_odbc.pony` - Package documentation and overview
- `pony-odbc/odbc_env.pony` - Environment handle implementation
- `pony-odbc/odbc_dbc.pony` - Database connection handle
- `pony-odbc/odbc_stmt.pony` - Statement handle (primary API)
- `pony-odbc/sql_varchar.pony` - String type implementation (representative of other SQL types)
- `pony-odbc/ffi/f.pony` - FFI function declarations
- `examples/new_api/main.pony` - Canonical usage example

## Development Notes

- This is a synchronous API; an async version is planned
- Current ODBC version: 3.0 only
- Status: "In Motion" - API may change, feedback welcome
- Documentation site: https://redvers.github.io/pony-odbc
