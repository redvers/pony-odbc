use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[ODBCHandleDbc tag] tag)
//use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)

use ".."
use "../instrumentation"

primitive \nodoc\ ODBCDbcFFI
  fun sql_alloc_handle(h: ODBCHandleEnv tag): (SQLReturn val, ODBCHandleDbc tag) =>
    var rv: ODBCHandleDbc tag = ODBCHandleDbc
    match @SQLAllocHandle(2, NullablePointer[ODBCHandleEnv tag](h), addressof rv)
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_pdbc(rv) end, rv)
    | -1 => return (recover val SQLError.create_pdbc(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (PonyDriverError, rv)
    end


