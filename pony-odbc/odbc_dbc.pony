use "debug"
use "dbc"

class ODBCDbc
  let dbc: ODBCHandleDbc tag
  let _henv: ODBCEnv
  var _err: SQLReturn val
  var _valid: Bool = true

  var errtext: String val = ""

  var _call_location: SourceLoc val = __loc

  new create(henv': ODBCEnv = ODBCEnv.>set_odbc3(), sl: SourceLoc val = __loc) =>
    """
    Creates a new PostgresSQL Database Object.
    """
    _henv = henv'
    _call_location = sl

    (_err, dbc) = ODBCDbcFFI.alloc(_henv.odbcenv)
    _set_valid(_err)

  fun ref get_autocommit(): Bool ? =>
    (_err, var value: I32) = ODBCDbcFFI.get_attr_i32(dbc, SqlAttrAutoCommit)
    _set_valid(_err)
    if (value == SqlAutoCommitOn()) then return true end
    if (value == SqlAutoCommitOff()) then return false end
    error

  fun ref set_autocommit(setting: Bool) =>
    if (setting) then
      _err = ODBCDbcFFI.set_attr_i32(dbc, SqlAttrAutoCommit, SqlAutoCommitOn())
    else
      _err = ODBCDbcFFI.set_attr_i32(dbc, SqlAttrAutoCommit, SqlAutoCommitOff())
    end
    _set_valid(_err)

  fun ref get_info(i: SQLInfoTypes, sl: SourceLoc val = __loc): (SQLReturn val, String val) =>
    _call_location = sl
    ODBCDbcFFI.get_info(dbc, i)

  fun ref commit(sl: SourceLoc val = __loc): Bool =>
    """
    Instructs the database to commit your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCDbcFFI.commit(dbc)
    _set_valid(_err)
    _valid

  fun ref rollback(sl: SourceLoc val = __loc): Bool =>
    """
    Instructs the database to rollback your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCDbcFFI.rollback(dbc)
    _set_valid(_err)
    _valid


  fun ref set_application_name(appname: String val, sl: SourceLoc val = __loc): Bool =>
    """
    Notifies the database of your application's name. (It does not
    appear in pg_settings, is this a bug? if so where?
    """
    _call_location = sl
    _err = ODBCDbcFFI.set_application_name(dbc, appname)
    _set_valid(_err)
    _valid

  fun ref connect(dsn: String val, sl: SourceLoc val = __loc): Bool =>
    """
    Initiates the database connection to the PostgreSQL database
    defined by the DSN.
    """
    _call_location = sl
    _err = ODBCDbcFFI.connect(dbc, dsn)
    _set_valid(_err)
    _valid

  fun \nodoc\ is_valid(): Bool => _valid

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => _valid = true ; return true
    | let x: SQLSuccessWithInfo val => _valid = true ; return true
    | let x: SQLError val => set_error_text(x)
                             _valid = false
                             return false
    else
      _valid = false ; return false
    end

  fun \nodoc\ ref set_error_text(sqlerr: SQLError val) =>
    errtext =
      "ODBCDbc API Error:\n" +
      _call_location.file() + ":" + _call_location.line().string() + ": " +
      _call_location.type_name() + "." + _call_location.method_name() + "()\n" +
      "  " + sqlerr.get_err_strings()

  fun _final() =>
    ODBCDbcFFI.free(dbc)

  // Present only for introspection during tests
  fun \nodoc\ get_err(): SQLReturn val => _err
