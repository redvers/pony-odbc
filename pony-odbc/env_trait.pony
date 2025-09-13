use "env"

trait ENVTrait
  fun ref get_odbcenv(): ODBCHandleEnv tag
  fun ref set_odbcenv(h: ODBCHandleEnv tag)
  fun ref get_err(): SQLReturn val
  fun ref set_err(err: SQLReturn val)
  fun ref get_valid(): Bool
  fun ref set_valid(valid: Bool)


  fun ref set_odbc3(): Bool =>
    """
    Enables ODBC Versiion 3 support (you should do this)
    """
    set_err(ODBCEnvFFI.set_odbc3(get_odbcenv()))
    _set_valid(get_err())
    get_valid()

  fun \nodoc\ ref is_valid(): Bool =>
    get_valid()

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => set_valid(true) ; return true
    | let x: SQLSuccessWithInfo val => set_valid(true) ; return true
    else
      set_valid(false) ; return false
    end

  fun ref get_attr(a: SqlEnvAttr): (SQLReturn val, I32) =>
    ODBCEnvFFI.get_env_attr(get_odbcenv(), a)

