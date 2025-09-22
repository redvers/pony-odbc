use "ffi"
use "debug"

class ODBCDbc is SqlState
  """
  # ODBCDbc

  The class that wraps our ODBC Database handle.

  ## Usage

  ```pony
  var env: ODBCEnv = ODBCEnv .> set_odbc3()
  var dbc: ODBCDbc = env.dbc()?

  // Disable autocommit, set application name, and connect to database
  try
    dbc
    .> set_autocommit(false)?         // Disable Autocommit
    .> set_application_name("myapp")? // Set application name
    .> connect("mydsn")?              // Connect to DSN "mydsn"
  else
    Debug.out("We failed, here's our errors:")
    Debug.out(dbc.errtext)
  end
  ```

  An example that demonstrates `.commit()` and `.rollback()` will be
  documented in ODBCStmt as that requires an appropriate context to
  make sense.
  """
  let dbc: ODBCHandleDbc tag
  let _henv: ODBCHandleEnv tag
  var _err: SQLReturn val = SQLSuccess
  var strict: Bool = true

  var _call_location: SourceLoc val = __loc

  new \nodoc\ create(henv': ODBCHandleEnv tag, sl: SourceLoc val = __loc) ? =>
    _henv = henv'
    _call_location = sl

    (_err, dbc) = ODBCDbcFFI.alloc(_henv)
    _check_valid()?

  fun ref stmt(): ODBCStmt ? =>
    """
    Used to create an ODBCStmt object from this ODBCDbc connection.
    """
    ODBCStmt.create(_henv, dbc)?

  fun sqlstates(): Array[(String val, String val)] val =>
    _from_dbc(dbc)

  fun ref get_autocommit(): Bool ? =>
    (_err, var value: I32) = ODBCDbcFFI.get_attr_i32(dbc, _SqlAttrAutoCommit)
    _check_valid()?
    if (value == _SqlAutoCommitOn()) then return true end
    if (value == _SqlAutoCommitOff()) then return false end
    error

  fun ref set_autocommit(setting: Bool) ? =>
    if (setting) then
      _err = ODBCDbcFFI.set_attr_i32(dbc, _SqlAttrAutoCommit, _SqlAutoCommitOn())
    else
      _err = ODBCDbcFFI.set_attr_i32(dbc, _SqlAttrAutoCommit, _SqlAutoCommitOff())
    end
    _check_valid()?

//  fun ref get_info(i: _SQLInfoTypes, sl: SourceLoc val = __loc): (SQLReturn val, String val) =>
//    _call_location = sl
//    ODBCDbcFFI.get_info(dbc, i)

  fun ref commit(sl: SourceLoc val = __loc): Bool ? =>
    """
    Instructs the database to commit your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCDbcFFI.commit(dbc)
    _check_valid()?

  fun ref rollback(sl: SourceLoc val = __loc): Bool ? =>
    """
    Instructs the database to rollback your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCDbcFFI.rollback(dbc)
    _check_valid()?


  fun ref set_application_name(appname: String val, sl: SourceLoc val = __loc): Bool ? =>
    """
    Notifies the database of your application's name. (It does not
    appear in pg_settings, is this a bug? if so where?
    """
    _call_location = sl
    _err = ODBCDbcFFI.set_application_name(dbc, appname)
    _check_valid()?

  fun ref connect(dsn: String val, sl: SourceLoc val = __loc): Bool ? =>
    """
    Initiates the database connection to the PostgreSQL database
    defined by the DSN.
    """
    _call_location = sl
    _err = ODBCDbcFFI.connect(dbc, dsn)
    _check_valid()?

  fun \nodoc\ ref _check_valid(): Bool ? =>
    if strict then
      match _err
      | let x: SQLSuccess val => return true
      else
        error
      end
    else
      match _err
      | let x: SQLSuccess val => return true
      | let x: SQLSuccessWithInfo val => return true
      else
        error
      end
    end

  fun ref disconnect(): Bool ? =>
    _err = ODBCDbcFFI.disconnect(dbc)
    _check_valid()?


  fun _final() =>
    ODBCDbcFFI.free(dbc)

  // Present only for introspection during tests
  fun \nodoc\ get_err(): SQLReturn val => _err
