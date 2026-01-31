use "ffi"
use "debug"
use "collections"

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

  ## Error Handling

  ODBCDbc maintains an error chain that records all errors during connection
  operations. You can also access errors from all child statements via
  `all_errors()`:

  ```pony
  // Get just this connection's errors
  for err in dbc.error_chain().values() do
    env.err.print(err.string())
  end

  // Get all errors including child statements, sorted by sequence
  for err in dbc.all_errors().values() do
    env.err.print(err.string())
  end
  ```
  """
  var dbc: ODBCHandleDbc tag = ODBCHandleDbc
  let _henv: ODBCHandleEnv tag
  let _env: ODBCEnv
  var _err: SQLReturn val = SQLSuccess
  var strict: Bool = true
  var _connected: Bool = false
  var _connection_epoch: USize = 0

  var _call_location: SourceLoc val = __loc
  var _error_chain: ODBCErrorChain = ODBCErrorChain
  var _statements: Array[ODBCStmt] = Array[ODBCStmt]

  new \nodoc\ create(env': ODBCEnv, sl: SourceLoc val = __loc) =>
    _env = env'
    _henv = env'.odbcenv
    _call_location = sl

  fun \nodoc\ ref alloc(): SQLReturn val =>
    var dbcwrapper: DbcWrapper = DbcWrapper
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLAllocHandle_dbc(_henv, dbcwrapper))
    dbc = dbcwrapper.value
    _err

  fun ref stmt(sl: SourceLoc val = __loc): ODBCStmt ? =>
    """
    Used to create an ODBCStmt object from this ODBCDbc connection.
    """
    _call_location = sl
    var sth: ODBCStmt = ODBCStmt.create(this)
    _err = sth.alloc()
    _check_valid("stmt")?
    _statements.push(sth)
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
    _call_location = sl
    var value: CBoxedI32 = CBoxedI32
    _err = ODBCFFI.resolve(ODBCFFI.pSQLGetConnectAttr_i32(dbc, _SqlAttrAutoCommit(), value, 4, CBoxedI32))
    _check_valid("get_autocommit")?
    if (value.value == _SqlAutoCommitOn()) then return true end
    if (value.value == _SqlAutoCommitOff()) then return false end
    error

  fun ref set_autocommit(setting: Bool, sl: SourceLoc = __loc): Bool ? =>
    """
    Enables or disables autocommit. Many RDBMSs require that this be configured
    before you initiate the actual connection with connect()?
    """
    _call_location = sl
    if (setting) then
      _err = ODBCFFI.resolve(
        ODBCFFI.pSQLSetConnectAttr_i32(dbc, _SqlAttrAutoCommit(), _SqlAutoCommitOn(), 9))
    else
      _err = ODBCFFI.resolve(
        ODBCFFI.pSQLSetConnectAttr_i32(dbc, _SqlAttrAutoCommit(), _SqlAutoCommitOff(), 9))
    end
    _check_valid("set_autocommit")?

  fun ref commit(sl: SourceLoc val = __loc): Bool ? =>
    """
    Instructs the database to commit your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLEndTran_dbc(2, dbc, 0))
    _check_valid("commit")?

  fun ref rollback(sl: SourceLoc val = __loc): Bool ? =>
    """
    Instructs the database to rollback your transaction and open a new one.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLEndTran_dbc(2, dbc, 1))
    _check_valid("rollback")?

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
    _check_valid("get_info_varchar")?

  fun ref connect(dsn: String val, sl: SourceLoc val = __loc): Bool ? =>
    """
    Initiates the database connection to the database as defined by the DSN.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLConnect(dbc, dsn, dsn.size().i16(), "", 0, "", 0))
    _check_valid("connect")?
    _connected = true
    _connection_epoch = _connection_epoch + 1
    true

  fun ref _capture_error(operation: String val) =>
    """
    Capture the current error state into the error chain.
    Called before throwing an error.
    """
    let diags = sqlstates()
    let frame = ODBCErrorFrame(
      operation,
      _call_location,
      _err,
      diags,
      _error_chain.next_sequence(),
      None,
      "dbc",
      false
    )
    _error_chain.push(frame)

  fun ref _record_success(operation: String val) =>
    """
    Record a successful operation if log_success is enabled.
    """
    if _error_chain.log_success() then
      let frame = ODBCErrorFrame(
        operation,
        _call_location,
        _err,
        recover val Array[(String val, String val)] end,
        _error_chain.next_sequence(),
        None,
        "dbc",
        true
      )
      _error_chain.push(frame)
    end

  fun \nodoc\ ref _check_valid(operation: String val = ""): Bool ? =>
    if strict then
      match _err
      | let x: SQLSuccess val =>
        _record_success(operation)
        return true
      else
        _capture_error(operation)
        error
      end
    else
      match _err
      | let x: SQLSuccess val =>
        _record_success(operation)
        return true
      | let x: SQLSuccessWithInfo val =>
        _record_success(operation)
        return true
      else
        _capture_error(operation)
        error
      end
    end

  fun error_chain(): ODBCErrorChain box =>
    """
    Access the error chain for inspection.
    """
    _error_chain

  fun last_error(): (ODBCErrorFrame val | None) =>
    """
    Convenience method: get the most recent error frame.
    """
    _error_chain.last()

  fun ref configure_error_chain(
    max_frames: USize = 100,
    auto_clear: Bool = true,
    log_success: Bool = false
  ) =>
    """
    Configure error chain behavior.

    - max_frames: Maximum number of frames to store (default: 100)
    - auto_clear: Clear chain on prepare()/finish() (default: true)
    - log_success: Also record successful operations (default: false)
    """
    _error_chain.set_max_frames(max_frames)
    _error_chain.set_auto_clear(auto_clear)
    _error_chain.set_log_success(log_success)

  fun all_errors(): Array[ODBCErrorFrame val] val =>
    """
    Returns this connection's errors plus all statement errors, sorted by sequence.
    """
    let result: Array[ODBCErrorFrame val] ref = Array[ODBCErrorFrame val]
    // Add own errors
    for e in _error_chain.values() do
      result.push(e)
    end
    // Add statement errors
    for s in _statements.values() do
      for e in s.error_chain().values() do
        result.push(e)
      end
    end
    // Sort by sequence number
    let sorted = Sort[Array[ODBCErrorFrame val], ODBCErrorFrame val](result)
    // Convert to val
    let out: Array[ODBCErrorFrame val] trn = recover trn Array[ODBCErrorFrame val] end
    for e in sorted.values() do
      out.push(e)
    end
    consume out

  fun ref disconnect(sl: SourceLoc val = __loc): Bool ? =>
    """
    Disconnects the database connection from the database.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLDisconnect(dbc))
    _check_valid("disconnect")?
    _connected = false
    true

  fun is_connected(): Bool =>
    """
    Returns true if the connection is currently connected to a database.
    """
    _connected

  fun connection_epoch(): USize =>
    """
    Returns the connection epoch. This increments each time connect() is called.
    Used internally to track statement validity across reconnections.
    """
    _connection_epoch


  fun _final() =>
    ODBCFFI.pSQLFreeHandle_dbc(dbc)

  // Present only for introspection during tests
  fun \nodoc\ get_err(): SQLReturn val => _err
