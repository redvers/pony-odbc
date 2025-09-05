use @SQLConnect[I16](ConnectionHandle: Pointer[None] tag, ServerName: Pointer[U8] tag, NameLength1: I16, UserName: Pointer[U8] tag, NameLength2: I16, Authentication: Pointer[U8] tag, NameLength3: I16)
use @SQLSetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, StringLength: I32)
//use @SQLGetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength
use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[ODBCHandleDbc tag] tag)
use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)

use "../env"
use "../attributes"
use "../instrumentation"

struct \nodoc\ ODBCHandleDbc


primitive \nodoc\ ODBCDbcFFI
  fun alloc(h: ODBCHandleEnv tag): (SQLReturn val, ODBCHandleDbc tag) =>
    """
    Returns an ODBCHandleEnv, used by the ODBC FFI calls to represent a
    database connection.
    """
    ODBCDbcFFI.sql_alloc_handle(h)

  fun set_application_name(h: ODBCHandleDbc tag, s: String val): SQLReturn val =>
    """
    Tells the ODBC driver your application name.  I'm not sure if it passes
    it to the database for all database drivers.
    """
    match @SQLSetConnectAttr[I16](NullablePointer[ODBCHandleDbc tag](h), SQLAttrApplicationName(), s.cstring(), s.size().i32())
    | 0 => return SQLSuccess
    | -1 => return recover val SQLError.create_pdbc(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end

  fun connect(h: ODBCHandleDbc tag, dsn: String val): SQLReturn val =>
    """
    Opens the connection to the database on the provided DSN.
    """
    match @SQLConnect(NullablePointer[ODBCHandleDbc tag](h), dsn.cstring(), dsn.size().i16(), "".cstring(), 0, "".cstring(), 0)
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pdbc(h) end
    | -1 => return recover val SQLError.create_pdbc(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end

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

  fun free(h: ODBCHandleDbc tag) => @SQLFreeHandle(2, NullablePointer[ODBCHandleDbc tag](h))
