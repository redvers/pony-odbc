use "debug"
use "ffi"

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
    .> set_odbc3()
  ```
  """
  let odbcenv: ODBCHandleEnv tag
  var strict: Bool = true
  var _err: _SQLReturn val = SQLSuccess

  new create() => None
    """
    Creates a new ODBC Environment
    """
    var envwrapper: EnvWrapper = EnvWrapper
    ODBCFFI.pSQLAllocHandle_env(envwrapper)
    odbcenv = envwrapper.value

  fun dbc(): ODBCDbc ? =>
    """
    Used to create an ODBCDbc object from this ODBCEnv.
    """
    ODBCDbc(odbcenv)?

  fun sqlstates(): Array[(String val, String val)] val =>
    _from_env(odbcenv)

  fun ref set_odbc3(): Bool ? =>
    """
    Enables ODBC Versiion 3 support (you should do this)
    """
    _err = ODBCEnvFFI.set_odbc3(odbcenv)
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

  fun \nodoc\ ref get_attr(a: _SqlEnvAttr, v: CBoxedI32) ? =>
    """
    This is a primitive getter function used to retrieve i32 attributes
    from the ODBC Handle. 
    """
    _err = ODBCEnvFFI.get_env_attr(odbcenv, a, v)
    _check_valid()?

  fun _final() =>
    ODBCEnvFFI.free(odbcenv)

