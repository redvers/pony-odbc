use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[ODBCHandleStmt tag] tag)
//use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)

use ".."
use "../instrumentation"

primitive \nodoc\ ODBCStmtFFI
  fun alloc(h: ODBCHandleDbc tag): (SQLReturn val, ODBCHandleStmt tag) =>
    var rv: ODBCHandleStmt tag = ODBCHandleStmt
    match @SQLAllocHandle(3, NullablePointer[ODBCHandleDbc tag](h), addressof rv)
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_pstmt(rv) end, rv)
    | -1 => return (recover val SQLError.create_pstmt(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (PonyDriverError, rv)
    end


