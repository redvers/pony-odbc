use "debug"
use "ffi"

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
    .> set_odbc3()
  ```
  """
  let odbcenv: ODBCHandleEnv tag
  var strict: Bool = true
  var _err: SQLReturn val

  new create() => None
    """
    Creates a new ODBC Environment
    """
    var envwrapper: EnvWrapper = EnvWrapper
    _err = ODBCFFI.resolve(ODBCFFI.pSQLAllocHandle_env(envwrapper))
    odbcenv = envwrapper.value
    ODBCFFI.pSQLSetEnvAttr(odbcenv, _SqlAttrODBCVersion(), _SqlODBC3(), _SQLIsInteger())

  fun ref dbc(): ODBCDbc ? =>
    """
    Used to create an ODBCDbc object from this ODBCEnv.
    """
    var dbh: ODBCDbc = ODBCDbc(odbcenv)
    _err = dbh.alloc()
    _check_valid()?
    dbh

  fun sqlstates(): Array[(String val, String val)] val =>
    _from_env(odbcenv)

  fun ref set_odbc3(): Bool ? =>
    """
    Enables ODBC Versiion 3 support (you should do this)
    """
    _err = ODBCFFI.resolve(ODBCFFI.pSQLSetEnvAttr(odbcenv, _SqlAttrODBCVersion(), _SqlODBC3(), _SQLIsInteger()))
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
    _err = ODBCFFI.resolve(ODBCFFI.pSQLGetEnvAttr(odbcenv, a(), v, 0, CBoxedI32))
    _check_valid()?

//  fun _final() =>
//    ODBCEnvFFI.free(odbcenv)

