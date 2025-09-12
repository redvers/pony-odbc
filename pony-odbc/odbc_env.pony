use "env"

class ODBCEnv
  let odbcenv: ODBCHandleEnv tag
  var _err: SQLReturn val
  var _valid: Bool = false

  new create() =>
    """
    Creates a new PostgreSQL Environment
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

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => _valid = true ; return true
    | let x: SQLSuccessWithInfo val => _valid = true ; return true
    else
      _valid = false ; return false
    end

  fun get_attr(a: SqlEnvAttr): (SQLReturn val, I32) =>
    ODBCEnvFFI.get_env_attr(odbcenv, a)

  fun _final() =>
    ODBCEnvFFI.free(odbcenv)

