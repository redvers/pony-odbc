use "ffi"
use "debug"

struct \nodoc\ ODBCHandleDbc

class ODBCDbc is SqlState
  """
  # ODBCDbc

  The class that wraps our ODBC Database handle.

  ## Usage

  ```pony
  var env: ODBCEnv = ODBCEnv
  var dbc: ODBCDbc = env.dbc()?

  // Disable autocommit, set application name, and connect to database
  try
    dbc
    .> set_autocommit(false)?         // Disable Autocommit
    .> connect("mydsn")?              // Connect to DSN "mydsn"
  else
    Debug.out("We failed.")
  end
  ```

  An example that demonstrates `.commit()` and `.rollback()` will be
  documented in ODBCStmt as that requires an appropriate context to
  make sense.
  """
  var dbc: ODBCHandleDbc tag = ODBCHandleDbc
  let _henv: ODBCHandleEnv tag
  var _err: SQLReturn val = SQLSuccess
  var strict: Bool = true

  var _call_location: SourceLoc val = __loc

  new \nodoc\ create(henv': ODBCHandleEnv tag, sl: SourceLoc val = __loc) =>
    _henv = henv'
    _call_location = sl

  fun \nodoc\ ref alloc(): SQLReturn val =>
    var dbcwrapper: DbcWrapper = DbcWrapper
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLAllocHandle_dbc(_henv, dbcwrapper))
    dbc = dbcwrapper.value
    _err

  fun ref stmt(): ODBCStmt ? =>
    """
    Used to create an ODBCStmt object from this ODBCDbc connection.
    """
    var sth: ODBCStmt = ODBCStmt.create(_henv, dbc)
    _err = sth.alloc()
    _check_valid()?
    sth

  fun sqlstates(): Array[(String val, String val)] val =>
    """
    Returns an array of SQL States
    """
    _from_dbc(dbc)

  fun ref get_autocommit(sl: SourceLoc = __loc): Bool ? =>
    """
    Returns whether autocommit is enabled or disabled.
    """
    var value: CBoxedI32 = CBoxedI32
    _err = ODBCFFI.resolve(ODBCFFI.pSQLGetConnectAttr_i32(dbc, _SqlAttrAutoCommit(), value, 4, CBoxedI32))
    _check_valid()?
    if (value.value == _SqlAutoCommitOn()) then return true end
    if (value.value == _SqlAutoCommitOff()) then return false end
    error

  fun ref set_autocommit(setting: Bool, sl: SourceLoc = __loc): Bool ? =>
    """
    Enables or disables autocommit. Many RDBMSs require that this be configured
    before you initiate the actual connection with connect()?
    """
    if (setting) then
      _err = ODBCFFI.resolve(
        ODBCFFI.pSQLSetConnectAttr_i32(dbc, _SqlAttrAutoCommit(), _SqlAutoCommitOn(), 9))
    else
      _err = ODBCFFI.resolve(
        ODBCFFI.pSQLSetConnectAttr_i32(dbc, _SqlAttrAutoCommit(), _SqlAutoCommitOff(), 9))
    end
    _check_valid()?

  fun ref commit(sl: SourceLoc val = __loc): Bool ? =>
    """
    Instructs the database to commit your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLEndTran_dbc(2, dbc, 0))
    _check_valid()?

  fun ref rollback(sl: SourceLoc val = __loc): Bool ? =>
    """
    Instructs the database to rollback your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLEndTran_dbc(2, dbc, 1))
    _check_valid()?

  fun ref get_info_varchar(infotype: U16, buf: SQLType, sl: SourceLoc = __loc): Bool ? =>
    """
    SQLGetInfo returns general information about the driver and data
    source associated with a connection.
    """
    _call_location = sl
    var string_length: CBoxedI16 = CBoxedI16
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLGetInfo_varchar(dbc,
                         infotype,
                         buf.get_boxed_array().ptr,
                         buf.get_boxed_array().alloc_size.i16(),
                         string_length)
    )
    buf.get_boxed_array().written_size.value = string_length.value.i64()
    _check_valid()?

  fun ref connect(dsn: String val, sl: SourceLoc val = __loc): Bool ? =>
    """
    Initiates the database connection to the database as defined by the DSN.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLConnect(dbc, dsn, dsn.size().i16(), "", 0, "", 0))
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
    """
    Disconnects the database connection from the database.
    """
    _err = ODBCFFI.resolve(ODBCFFI.pSQLDisconnect(dbc))
    _check_valid()?


  fun _final() =>
    ODBCFFI.pSQLFreeHandle_dbc(dbc)

  // Present only for introspection during tests
  fun \nodoc\ get_err(): SQLReturn val => _err
