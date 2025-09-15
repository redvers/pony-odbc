"""
# pony-odbc

Pony wrappers and simple API for iODBC or unixODBC.

## Status

"In Motion"™

Please feel free to test it and provide feedback on the design and API.

See [https://github.com/redvers/pony-odbc](https://github.com/redvers/pony-odbc)
for installation instructions, dependencies, and initial configuration.

## What is ODBC?¹

The Microsoft Open Database Connectivity (ODBC) interface is a C programming
language interface that makes it possible for applications to access data
from various database management systems (DBMSs). ODBC is a low-level,
high-performance interface that is designed specifically for relational data
stores.

The ODBC interface allows maximum interoperability-an application can access
data in diverse DBMSs through a single interface. Moreover, that application
is independent of any DBMS from which it accesses data. Users of the
application can add software components called drivers, which interface
between an application and a specific DBMS.

## What is `pony-odbc`?

`pony-odbc` consists of two APIs.

1. The raw FFI API (you hopefully never need this)
2. The safer "simpler"™ API provided by ODBCEnv, ODBCDbc, and ODBCStmt

## The ODBC / `pony-odbc` model

Users of ODBC operates on three types of handles, "Environment", "Database",
and "Statement".  In `pony-odbc`, these are represented by `ODBCEnv`,
`ODBCDbc`, and `ODBCStmt` respectively.

### ODBC Environment Handle / `ODBCEnv`

This is the global context which is global in nature, such as being able to
list all of the connections or available database drivers.

An Environment is needed to create a Database Environment `ODBCDbc`.

### ODBC Database Handle / `ODBCDbc`

This is the object that represents a single database connection. On this object
you can query and set parameters such as whether this connection autocommits
after every statement, whether the connection is read-only / read-write.

Once you have created and configured your `ODBCDbc` object, you can connect
to the database using the `.connect(dsn)` function.

### ODBC Statement Handle / `ODBCStmt`

This is the main "simplified"™ API which you used to prepare your SQL
statements, populate your parameters and arguments, and execute
your queries.

## Where to start

Take a look in the examples/ directory for a simple example to start you off.

[ODBCEnv](https://redvers.github.io/pony-odbc/pony-odbc-ODBCEnv/) for
information on configuring the global environment.

[ODBCDbc](https://redvers.github.io/pony-odbc/pony-odbc-ODBCDbc/) for
information on configuring a database connection.

[ODBCStmt](https://redvers.github.io/pony-odbc/pony-odbc-ODBCStmt/) for
information on preparing and executing queries.

## Citations:

[¹][Microsoft ODBC Specifications](https://github.com/MicrosoftDocs/sql-docs/blob/live/docs/odbc/microsoft-open-database-connectivity-odbc.md)
"""
