use "debug"
use "ffi"
use "collections"

struct \nodoc\ ODBCHandleEnv

class ODBCEnv is SqlState
  """
  # ODBCEnv

  The class that wraps our ODBC Environment handle.

  ## Usage

  It is currently very simple as very few of the attributes are implemented
  as of yet.

  Currently, we only support ODBC version 3.0.

  ```pony
  var oenv: ODBCEnv = ODBCEnv
  ```

  ## Error Handling

  ODBCEnv maintains an error chain that can aggregate errors from all
  child connections and their statements via `all_errors()`:

  ```pony
  // Get all errors across entire handle hierarchy, sorted by sequence
  for err in env.all_errors().values() do
    env.err.print(err.string())
  end
  ```
  """
  let odbcenv: ODBCHandleEnv tag
  var strict: Bool = true
  var _err: SQLReturn val
  var _call_location: SourceLoc val = __loc
  var _error_chain: ODBCErrorChain = ODBCErrorChain
  var _connections: Array[ODBCDbc] = Array[ODBCDbc]

  new create() => None
    """
    Creates a new ODBC Environment
    """
    var envwrapper: EnvWrapper = EnvWrapper
    _err = ODBCFFI.resolve(ODBCFFI.pSQLAllocHandle_env(envwrapper))
    odbcenv = envwrapper.value
    ODBCFFI.pSQLSetEnvAttr(odbcenv, _SqlAttrODBCVersion(), _SqlODBC3(), _SQLIsInteger())

  fun ref dbc(sl: SourceLoc val = __loc): ODBCDbc ? =>
    """
    Used to create an ODBCDbc object from this ODBCEnv.
    """
    _call_location = sl
    var dbh: ODBCDbc = ODBCDbc(this)
    _err = dbh.alloc()
    _check_valid("dbc")?
    _connections.push(dbh)
    dbh

  fun sqlstates(): Array[(String val, String val)] val =>
    """
    Returns an array of SQL States
    """
    _from_env(odbcenv)

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
      "env",
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
        "env",
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
    Returns all errors across the entire handle hierarchy, sorted by sequence.
    """
    let result: Array[ODBCErrorFrame val] ref = Array[ODBCErrorFrame val]
    // Add own errors
    for e in _error_chain.values() do
      result.push(e)
    end
    // Add connection errors (which includes statement errors)
    for conn in _connections.values() do
      for e in conn.all_errors().values() do
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

  fun \nodoc\ ref get_attr_i32(a: _SqlEnvAttr, v: CBoxedI32, sl: SourceLoc val = __loc): Bool ? =>
    """
    This is a primitive getter function used to retrieve i32 attributes
    from the ODBC Handle.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLGetEnvAttr_i32(odbcenv, a(), v, 0, CBoxedI32))
    _check_valid("get_attr_i32")?

  fun _final() =>
    ODBCFFI.pSQLFreeHandle_env(odbcenv)

