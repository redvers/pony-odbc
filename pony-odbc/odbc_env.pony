use "env"
use "ctypes"
use "attributes"
use "instrumentation"

class ODBCEnv
  let odbcenv: ODBCHandleEnv tag
  var err: SQLReturn val
  var valid: Bool = false

  new create() =>
    """
    Creates a new PostgreSQL Environment
    """
    (err, odbcenv) = ODBCEnvFFI.alloc()
    _set_valid(err)

  fun ref set_odbc3(): Bool =>
    """
    Enables ODBC Versiion 3 support (you should do this)
    """
    err = ODBCEnvFFI.set_odbc3(odbcenv)
    _set_valid(err)
    valid

  fun \nodoc\ is_valid(): Bool =>
    valid

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => valid = true ; return true
    | let x: SQLSuccessWithInfo val => valid = true ; return true
    else
      valid = false ; return false
    end

  fun get_attr(a: SqlEnvAttr): (SQLReturn val, I32) =>
    ODBCEnvFFI.get_env_attr(odbcenv, a)

  fun _final() =>
    ODBCEnvFFI.free(odbcenv)
