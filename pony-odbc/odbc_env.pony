class ODBCEnv
  """
  # ODBCEnv

  The class that wraps our ODBC Environment handle.

  ## Usage

  It is currently very simple as very few of the attributes are implemented
  as of yet.
  
  Currently, we only support ODBC version 3.0.

  ```pony
  var oenv: ODBCEnv = ODBCEnv
    .> set_odbc3()
  ```
  """
  let odbcenv: ODBCHandleEnv tag
  var _err: _SQLReturn val
  var _valid: Bool = false

  new create() =>
    """
    Creates a new ODBC Environment
    """
    (_err, odbcenv) = ODBCEnvFFI.alloc()
    _set_valid(_err)

  fun ref set_odbc3(): Bool =>
    """
    Enables ODBC Versiion 3 support (you should do this)
    """
    _err = ODBCEnvFFI.set_odbc3(odbcenv)
    _set_valid(_err)
    _valid

  fun \nodoc\ is_valid(): Bool =>
    _valid

  fun \nodoc\ ref _set_valid(sqlr: _SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => _valid = true ; return true
    | let x: SQLSuccessWithInfo val => _valid = true ; return true
    else
      _valid = false ; return false
    end

  fun \nodoc\ get_attr(a: _SqlEnvAttr): (_SQLReturn val, I32) =>
    """
    This is a primitive getter function used to retrieve i32 attributes
    from the ODBC Handle. 
    """
    ODBCEnvFFI.get_env_attr(odbcenv, a)

  fun _final() =>
    ODBCEnvFFI.free(odbcenv)

