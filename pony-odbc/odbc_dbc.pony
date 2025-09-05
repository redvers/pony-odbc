use "debug"
use "dbc"
use "ctypes"
use "attributes"
use "instrumentation"

class ODBCDbc
  let dbc: ODBCHandleDbc tag
  let henv: ODBCEnv
  var err: SQLReturn val
  var valid: Bool = true

  new create(henv': ODBCEnv) =>
    """
    Creates a new PostgresSQL Database Object.
    """
    henv = henv'

    (err, dbc) = ODBCDbcFFI.alloc(henv.odbcenv)
    _set_valid(err)

  fun ref set_application_name(appname: String val): Bool =>
    """
    Notifies the database of your application's name. (It does not
    appear in pg_settings, is this a bug? if so where?
    """
    err = ODBCDbcFFI.set_application_name(dbc, appname)
    _set_valid(err)
    valid

  fun ref connect(dsn: String val): Bool =>
    """
    Initiates the database connection to the PostgreSQL database
    defined by the DSN.
    """
    err = ODBCDbcFFI.connect(dbc, dsn)
    _set_valid(err)
    valid

  fun \nodoc\ is_valid(): Bool => valid

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => valid = true ; return true
    | let x: SQLSuccessWithInfo val => valid = true ; return true
    else
      valid = false ; return false
    end

  fun _final() =>
    ODBCDbcFFI.free(dbc)

