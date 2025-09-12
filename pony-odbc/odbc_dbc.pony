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

  var errtext: String val = ""

  var call_location: SourceLoc val = __loc

  new create(henv': ODBCEnv = ODBCEnv.>set_odbc3(), sl: SourceLoc val = __loc) =>
    """
    Creates a new PostgresSQL Database Object.
    """
    henv = henv'
    call_location = sl

    (err, dbc) = ODBCDbcFFI.alloc(henv.odbcenv)
    _set_valid(err)

  fun ref get_info(i: SQLInfoTypes, sl: SourceLoc val = __loc): (SQLReturn val, String val) =>
    call_location = sl
    ODBCDbcFFI.get_info(dbc, i)


  fun ref set_application_name(appname: String val, sl: SourceLoc val = __loc): Bool =>
    """
    Notifies the database of your application's name. (It does not
    appear in pg_settings, is this a bug? if so where?
    """
    call_location = sl
    err = ODBCDbcFFI.set_application_name(dbc, appname)
    _set_valid(err)
    valid

  fun ref connect(dsn: String val, sl: SourceLoc val = __loc): Bool =>
    """
    Initiates the database connection to the PostgreSQL database
    defined by the DSN.
    """
    call_location = sl
    err = ODBCDbcFFI.connect(dbc, dsn)
    _set_valid(err)
    valid

  fun \nodoc\ is_valid(): Bool => valid

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => valid = true ; return true
    | let x: SQLSuccessWithInfo val => valid = true ; return true
    | let x: SQLError val => set_error_text(x)
                             valid = false
                             return false
    else
      valid = false ; return false
    end

  fun ref set_error_text(sqlerr: SQLError val) =>
    errtext =
      "ODBCDbc API Error:\n" +
      call_location.file() + ":" + call_location.line().string() + ": " +
      call_location.type_name() + "." + call_location.method_name() + "()\n" +
      "  " + sqlerr.get_err_strings()

  fun _final() =>
    ODBCDbcFFI.free(dbc)

