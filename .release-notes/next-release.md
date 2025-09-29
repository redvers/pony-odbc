## Misc bugfixes specific to mariadb.

Differences in versions required the following changes:

* SQLExecute execution returns SQLSuccess in newer versions instead of
  SQLSuccessWithInfo. We now need to validate the buffers for every both
  SQLSucess and SQLSuccessWithInfo.
* When providing syntactically invalid SQL to SQLPrepare, newer versions
  throw a SQLError on SQLPrepare, older versions on the SQLExecute (like
  all other tested connectors).
* ODBCDbc will no longer apply SQL\_AUTOCOMMIT after a connection is made
  in more recent versions.

## Add native FFI interface

This interface is 95% auto-generated and designed to follow the ODBC API
directly.

## Add support for SQLDirectExec, SQLColumns, SQLGetData, SQLFetch, SQLFreeStmt

* SQLDirectExec is mapped to ODBCStmt.direct\_exec()?
* SQLColumns is mapped to ODBCStmt.columns()?
* SQLGetData is mapped to ODBCStmt.get\_data()?
* SQLFetch is mapped to ODBCStmt.fetch()?
* SQLFreeStmt is mapped to ODBCStmt.finish()?

## Added NULL support to all types.

Before this point there was no support for SQL NULL. In order to write a NULL
you call `YourSqlType.null()`.

You can test your result for NULL by calling `YourSqlType.is_null()`.

If you call `YourSqlType.read()?` and the result is NULL, it will error.

## Defaults for simple API calls to Bool ?

Changes the default return values for the API calls to Bool ?. Typically they all either return true or error, but in some cases like fetch(), they indicate something else like "no more data in the result dataset".

Adds ODBCDbc.get\_info() to query data types.

