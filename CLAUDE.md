# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

pony-odbc is a Pony language library providing ODBC (Open Database Connectivity) wrappers supporting both iODBC and unixODBC. The API is synchronous and currently unstable ("In Motion"). It enables Pony programs to interact with PostgreSQL, MariaDB, SQLite, and other databases through a standard ODBC interface.

## Build Commands

```bash
make test                    # Build and run all unit tests (debug mode)
make test ODBC_DSN=mariadb   # Run only mariadb tests
make test ODBC_DSN=psqlred   # Run only PostgreSQL tests
make test ODBC_DSN=sqlitedb3 # Run only SQLite tests
make unit-tests              # Same as test
make examples                # Build example applications
make ci                      # Run unit-tests, examples, and stress-tests
make clean                   # Clean build artifacts (keep dependencies)
make realclean               # Clean everything including dependencies
make docs                    # Generate public API documentation
```

Build configuration options: `config=debug|release`, `static=true|false`, `ssl=<version>`.

The test binary is built at `build/debug/pony-odbc`. To run a single test:
```bash
./build/debug/pony-odbc --only=mariadb/_TestTypeTests
```

## Architecture

### Three-Tier ODBC Handle Hierarchy

The core design follows the ODBC handle model:

```
ODBCEnv (odbc_env.pony) → Environment handle, one per application
  └── ODBCDbc (odbc_dbc.pony) → Database connection, multiple per env
        └── ODBCStmt (odbc_stmt.pony) → Statement handle, multiple per connection
```

All three implement the `SqlState` trait for consistent diagnostic access. Each level tracks its children and provides `all_errors()` to aggregate errors up the hierarchy.

### Statement Lifecycle

```
dbc.stmt()? → prepare(sql)? → bind_parameter()/bind_column() → execute()? → fetch() loop → finish()?
```

Statements can be reused by calling `prepare()` again after `finish()`. Parameters and columns are bound positionally (in order of `?` placeholders).

### SQL Type System

`SQLType` trait (`sql_type.pony`) is the base for all type wrappers. Each type manages a `CBoxedArray` buffer for C interop. Concrete types: `SQLVarchar`, `SQLInteger`, `SQLBigInt`, `SQLSmallInt`, `SQLFloat`, `SQLReal`, `SQLVarbinary`. Use `write(value)` to set, `read()` to get, `is_null()`/`null()` for NULL handling.

`SQLVarchar` requires a size parameter; numeric types have fixed sizes. Buffers auto-expand when fetch results exceed the allocated size.

**Design decision: all types use C string buffers, not ODBC native C types.** Every SQL type binds to ODBC as `SQL_C_CHAR` and values are serialized to/from their string representation (e.g., `i32.string()` on write, `string()?.i32()?` on read). This is intentional — ODBC native datatypes (`SQL_C_LONG`, `SQL_C_DOUBLE`, etc.) behave inconsistently across drivers (PostgreSQL, MariaDB, SQLite each have different edge-case behavior around overflow, NULL handling, and truncation). SQLite's dynamic typing makes native C types especially problematic. The string path is the one all drivers reliably agree on. The performance cost (string conversion) is negligible compared to I/O. Do not change this to use native ODBC C types.

### FFI Layer

`ffi/f.pony` contains ~2000+ lines of raw ODBC C bindings via the `ODBCFFI` primitive. `ffi/u.pony` provides wrapper utilities. The `meta/` directory contains XML-based code generation tools for these FFI definitions.

### Error Handling

`ODBCErrorChain` maintains a circular buffer of `ODBCErrorFrame` records. The chain auto-clears on `prepare()`/`finish()` by default. `SQLReturn` is a union type including `SQLSuccess`, `SQLError`, `SQLSuccessWithInfo`, etc. In strict mode (default), only `SQLSuccess` is treated as success; in lenient mode, `SQLSuccessWithInfo` also passes.

### Connection Epoch Pattern

`ODBCDbc` tracks a connection epoch (incremented on each connect). `ODBCStmt` captures the epoch on creation and only frees its handle in `_final()` if the epoch still matches, preventing invalid handle access after reconnection.

## Testing

Tests require running PostgreSQL, MariaDB, and SQLite with ODBC drivers configured. DSNs used: `psqlred`, `mariadb`, `sqlitedb3`. Docker helper targets exist:
```bash
make start-pg-container      # Start PostgreSQL on port 5432
make start-mariadb-container # Start MariaDB on port 3306
```

Some tests are database-specific (e.g., SQLite doesn't support multiple connections; PostgreSQL requires transaction cleanup after errors). Check `_test.pony` for which tests are enabled per database.

Test classes are parameterized by DSN name, so `_TestTypeTests("psqlred")` runs type tests against PostgreSQL.

## CI

GitHub Actions (`.github/workflows/pr.yml`) runs on push using the `ghcr.io/redvers/pony-dependency-builder:latest` container image with PostgreSQL and MariaDB services. SQLite is available in the container. CI runs `make unit-tests config=debug ssl=0.9.0`.

## Pony Language Notes

- `use "lib:odbc"` links against unixODBC; `use "lib:iodbc"` for iODBC
- `\nodoc\` annotation hides items from generated documentation
- `?` suffix denotes partial functions (can error); callers must use `try`/`else`
- `.>` is the chaining operator (calls method, returns receiver)
- `_final()` is the destructor, called by GC
- Builds use `corral run -- ponyc` to resolve package dependencies
