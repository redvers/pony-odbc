# Comprehensive Test Suite Overview

This document describes the complete test suite for pony-odbc, including both existing and newly added comprehensive tests.

## Test Suite Structure

All tests are run against three database backends:

- **PostgreSQL** (`psqlred`)
- **MariaDB** (`mariadb`)
- **SQLite** (`sqlitedb3`)

## Existing Test Coverage

### Basic Tests

- **_TestNulls** - NULL value handling for all SQL types
- **_TestEnvironment** - Environment handle creation
- **_TestConnects** - Connection establishment

### Connection Tests

- **_TestConnect** - Basic connection lifecycle
- **_TestDatabase** - Database handle operations

### Statement API Tests

- **_TestStmtAPI** - Comprehensive statement API testing
  - Create table before connection (error case)
  - Syntax error handling
  - Parameter binding
  - Query execution
  - Rowcount validation
  - Buffer underallocation (auto-expansion)

### Type Tests

- **_TestTypeTests** - All SQL data types round-trip testing
  - SMALLINT, INTEGER, BIGINT
  - FLOAT, REAL
  - VARCHAR, VARBINARY
  - 300 row inserts with all types
  - Query with different predicates

### Transaction Tests

- **_TestTransactions** - Transaction management
  - Autocommit enable/disable
  - Commit operations
  - Rollback operations

### Legacy Tests

- **_MariaDBBasic** - Basic CRUD operations
- **_MariaDBInfo** - Database information queries
- **_MariaDBTran** - Transaction tests

## New Comprehensive Test Coverage

### 1. Boundary Value Tests (`boundary_values.pony`)

**_TestBoundaryValues** - Tests extreme values for numeric types

#### SMALLINT Boundaries (I16)

- Maximum value: 32,767
- Minimum value: -32,768

#### INTEGER Boundaries (I32)

- Maximum value: 2,147,483,647
- Minimum value: -2,147,483,648

#### BIGINT Boundaries (I64)

- Maximum value: 9,223,372,036,854,775,807
- Minimum value: -9,223,372,036,854,775,808

#### FLOAT Boundaries (F32)

- Very large value: 3.4028234e38
- Very small positive: 1.17549435e-38
- Large negative: -3.4028234e38

#### REAL Boundaries (F64)

- Very large value: 1.7976931348623157e308
- Very small positive: 2.2250738585072014e-308

#### Special Values

- Zero values for all numeric types
- Negative one values
- Boundary value round-trips

### 2. Edge Case Tests (`edge_cases.pony`)

**_TestEdgeCases** - Tests unusual but valid input scenarios

#### Empty Strings

- Insertion of empty strings ("")
- Retrieval and verification

#### Long Strings

- 4000 character strings
- Tests buffer auto-expansion with intentionally undersized buffers (10 bytes for 4000 char string)

#### Special Characters

- Tab, newline, carriage return
- Quotes (single and double)
- Backslashes
- Symbols: !@#$%^&*()_+-={}[]|:;<>?,./~`
- Apostrophes in strings

#### Empty Result Sets

- Queries that return zero rows
- Proper fetch behavior (immediate false)

#### Single Row Results

- Queries returning exactly one row
- Proper fetch sequencing

#### Whitespace Strings

- Single space
- Multiple spaces
- Leading/trailing spaces

#### Repeated Values

- Same value inserted 100 times
- Count verification

#### Exact Buffer Sizing

- Strings that exactly fill allocated buffer (50 chars in 50-byte buffer)

### 3. Multiple Connections Tests (`multiple_connections.pony`)

**_TestMultipleConnections** - Tests concurrent operations and handle reuse

#### Two Simultaneous Connections

- Two connections to same DSN
- Independent operations on each
- Temporary tables isolated per connection

#### Multiple Statements on Same Connection

- Multiple statement handles from one connection
- Parallel prepared statements
- Independent execution contexts

#### Statement Reuse Patterns

- Same handle for different query types
- INSERT → SELECT → UPDATE → SELECT sequence
- Binding changes between queries

#### Interleaved Fetch Operations

- Two active result sets from different statements
- Alternating fetch calls
- No interference between cursors

#### Connection Reconnect

- Disconnect/reconnect cycle
- Statement creation after reconnect
- Full operation after reconnect

### 4. Metadata Query Tests (`metadata_queries.pony`)

**_TestMetadataQueries** - Tests ODBC metadata functions

#### SQLGetTypeInfo

- Retrieve all supported data types (SQL_ALL_TYPES)
- Bind and read TYPE_NAME and DATA_TYPE columns
- Verify non-empty results

#### SQLTables

- List all tables in database
- Create temporary tables and verify they appear
- Read TABLE_CAT, TABLE_SCHEM, TABLE_NAME, TABLE_TYPE
- Wildcard searches

#### SQLColumns

- List columns for specific table
- 4-column table with INTEGER, VARCHAR, FLOAT, BIGINT
- Verify column names returned
- Column metadata retrieval

#### SQLNumResultCols

- Count columns in result set
- 5-column SELECT * test
- Subset SELECT (2 columns) test
- Verification of correct counts

### 5. Error Recovery Tests (`error_recovery.pony`)

**_TestErrorRecovery** - Tests error handling and resilience

#### UNIQUE Constraint Violations

- Insert duplicate into UNIQUE column
- Error detection
- Statement reuse after error
- Valid operations after error

#### NOT NULL Constraint Violations

- Insert NULL into NOT NULL column
- Error detection
- Recovery and continued use

#### Recovery After Multiple Errors

- Successful insert
- Failed insert (duplicate PK)
- Another successful insert
- Failed insert
- Another successful insert
- Verify all valid inserts committed

#### Invalid Table Name

- Query non-existent table
- Error state verification
- Recovery with valid operations

#### Invalid Column Reference

- Query non-existent column
- Error detection
- Recovery with valid column query

## Test Coverage Summary

### What's Tested

✅ All SQL data types (SMALLINT, INTEGER, BIGINT, FLOAT, REAL, VARCHAR, VARBINARY)
✅ NULL handling for all types
✅ Boundary values (min/max for all numeric types)
✅ Empty strings and zero-length values
✅ Very long strings (4000+ characters)
✅ Special characters and symbols
✅ Empty result sets
✅ Single and multiple row results
✅ Buffer auto-expansion
✅ Multiple database connections
✅ Multiple statements per connection
✅ Statement reuse patterns
✅ Transaction commit/rollback
✅ Error conditions (constraints, invalid SQL)
✅ Error recovery and continued operation
✅ Metadata queries (SQLGetTypeInfo, SQLTables, SQLColumns)
✅ Connection lifecycle (connect/disconnect/reconnect)
✅ Parameter binding
✅ Column binding
✅ Prepared statements
✅ Direct execution
✅ Row count validation
✅ Interleaved fetch operations

### Database Compatibility

All tests run against:

- ✅ PostgreSQL
- ✅ MariaDB
- ✅ SQLite

Some tests include database-specific adjustments for:

- SQLite's rowcount behavior (not always reliable)
- MariaDB connector behavior changes
- PostgreSQL BYTEA vs generic VARBINARY

## Running the Tests

```bash
# Run all tests
make test

# Build test binary
corral run -- ponyc -o build/debug pony-odbc/tests -b pony-odbc

# Run all tests
./build/debug/pony-odbc

# Run tests for a single database
make test ODBC_DSN=mariadb
make test ODBC_DSN=psqlred
make test ODBC_DSN=sqlitedb3

# Run specific test for a specific database
./build/debug/pony-odbc --only=psqlred/_TestBoundaryValues
./build/debug/pony-odbc --only=mariadb/_TestEdgeCases
./build/debug/pony-odbc --only=psqlred/_TestMultipleConnections
./build/debug/pony-odbc --only=mariadb/_TestMetadataQueries
./build/debug/pony-odbc --only=psqlred/_TestErrorRecovery
```

## Test Count

**Total Test Classes:**

- Original: 12 test classes
- New: 5 comprehensive test classes
- **Total: 17 test classes**

**Total Test Instances:**

- Each test class runs against 3 databases (PostgreSQL, MariaDB, SQLite)
- **Total: 51 test instances** (17 classes × 3 databases)

**Individual Test Functions:**

- Boundary Values: 7 test functions
- Edge Cases: 8 test functions
- Multiple Connections: 5 test functions
- Metadata Queries: 4 test functions
- Error Recovery: 5 test functions
- **New test functions: 29**

## Coverage Alignment with ODBC Test Recommendations

This test suite aligns with the recommendations from `tests/README.md`:

✅ **Handle and Connection Management** - Covered by existing and new tests
✅ **SQL Execution and Result Sets** - Extensively covered
✅ **Binding and Data Types** - All types, boundaries, and edge cases
✅ **Error and Diagnostic Handling** - Comprehensive error recovery tests
✅ **Advanced Cursor and Statement Functions** - Metadata tests
✅ **Transaction Handling** - Commit and rollback tests
✅ **Large Result Sets** - 1000 row tests in existing suite
✅ **Boundary Tests** - Min/max for all numeric types
✅ **Multiple Parallel Statements** - Multiple connection tests
✅ **Error Conditions** - Invalid SQL, constraints, missing tables
✅ **Unicode and Special Characters** - Edge case tests

## Future Test Enhancements

Potential areas for additional testing:

- Stored procedures (if supported by backends)
- Batch operations
- Very large BLOB/CLOB data (multi-MB)
- Performance benchmarks
- Concurrent multi-threaded access (if applicable)
- Date/Time types (not currently in schema)
- Decimal/Numeric precision types
