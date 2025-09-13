use "env"

class ODBCEnv is ENVTrait
  var odbcenv: ODBCHandleEnv tag
  var _err: SQLReturn val
  var _valid: Bool = false

  fun ref get_odbcenv(): ODBCHandleEnv tag => odbcenv
  fun ref set_odbcenv(h: ODBCHandleEnv tag) => odbcenv = h
  fun ref get_err(): SQLReturn val => _err
  fun ref set_err(err: SQLReturn val) => _err = err
  fun ref get_valid(): Bool => _valid
  fun ref set_valid(valid: Bool) => _valid = valid



  new create() =>
    """
    Creates a new PostgreSQL Environment
    """
    (_err, odbcenv) = ODBCEnvFFI.alloc()
    _set_valid(_err)

  fun _final() =>
    ODBCEnvFFI.free(odbcenv)

