# pony-odbc

Pony wrappers and simple API for iODBC or unixODBC.

## Status

"In Motion"™

Please feel free to test it and provide feedback on the design and API.
Please don't assume that this current API is stable.

## Installation

* Install [corral](https://github.com/ponylang/corral)
* `corral add github.com/redvers/pony-odbc.git --version 0.2.0`
* `corral fetch` to fetch your dependencies
* `use "pony-odbc"` to include it in your application
* `use "lib:odbc"` or `use "lib:iodbc"` for unixODBC or iODBC respectively
* `corral run -- ponyc` to compile your application

## Dependencies

ODBC is an API designed to abstract access to databases, much like DBI or
jdbc. Conceptually, it looks like this:

`pony-odbc` → `unixODBC|iODBC` → `ODBC Database Driver`

So, if you are using this database to connect to postgresql, you require
either unixODBC or iODBC, *and* the ODBC driver for postgresql.

`pony-odbc` will happily connect to any number of different types of
databases, as long as you have the backend ODBC driver for all the
databases you need installed.

For example, in our github workflows, we have postgres, mariadb, and
sqlite3 ODBC backends installed and we test on all of them concurrently.

## Configuring access

ODBC data-sources are specified via "Data Source Name"s (DSNs). They
can either be defined directly in your application as a string or
configured scoped to a system/user via /etc/odbc.ini or ~/.odbc.ini

Please check your documentation for unixODBC/iODBC and your ODBC
database driver for more details.

Here are some example configurations that we use in our test
workflows:

```quote
[psqlred]
Driver=/usr/lib/x86_64-linux-gnu/odbc/psqlodbca.so
Description=A test database
Servername=127.0.0.1
Driver=PostgreSQL
Database=pony
UserName=pony
Password=pony

[mariadb]
Driver=/usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so
Description=A test database
Servername=127.0.0.1
Database=pony
User=pony
Password=pony

[sqlitedb3]
Driver=/usr/lib/x86_64-linux-gnu/odbc/libsqlite3odbc.so
Description=A test database
Database=/tmp/testdba.db
```

Both unixODBC and iODBC provide tools to test the validity of your
configuration independently of this library.

## Documentation

More thorough documentation can be found at [https://redvers.github.io/pony-odbc](https://redvers.github.io/pony-odbc)
