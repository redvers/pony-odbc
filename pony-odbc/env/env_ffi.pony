use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[ODBCHandleEnv tag] tag)
//use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)

use ".."
use "../instrumentation"

primitive \nodoc\ ODBCEnvFFI
  fun sql_alloc_handle(): (SQLReturn val, ODBCHandleEnv tag) =>
    var rv: ODBCHandleEnv tag = ODBCHandleEnv
    match @SQLAllocHandle(1, Pointer[None], addressof rv)
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_penv(rv) end, rv)
    | -1 => return (recover val SQLError.create_penv(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (PonyDriverError, rv)
    end


