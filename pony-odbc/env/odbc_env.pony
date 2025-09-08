use @SQLSetEnvAttr[I16](henv: Pointer[None] tag, attr: I32, v: I32, sl: I32)
use @SQLGetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: CBoxedI32 tag)
use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[ODBCHandleEnv tag] tag)
use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)

use "../ctypes"
use "../attributes"
use "../instrumentation"

struct \nodoc\ ODBCHandleEnv

primitive \nodoc\ ODBCEnvFFI
  fun alloc(): (SQLReturn val, ODBCHandleEnv tag) =>
    """
    Returns an ODBCHandleEnv, used by the ODBC FFI calls to represent
    your environment.
    """
    ODBCEnvFFI.sql_alloc_handle()

  fun set_odbc2(h: ODBCHandleEnv tag): SQLReturn val =>
    """
    Sets the Environment to version ODBC2.  I should probably remove this
    since I've not implemented any of those functionsi (yet).
    """
    var rv: I16 = @SQLSetEnvAttr(NullablePointer[ODBCHandleEnv tag](h), SQLAttrOdbcVersion(), SQLAttrOvOdbc2(), SQLIsInteger())
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_penv(h) end
    | -1 => return recover val SQLError.create_penv(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCEnvFFI.set_odbc2() got invalid return code: " + rv.string()) end
    end

  fun set_odbc3(h: ODBCHandleEnv tag): SQLReturn val =>
    """
    Sets the Environment to version ODBC3.  You should always call
    this, since version 3 is the only one implemented thus far.
    """
    var rv: I16 = @SQLSetEnvAttr(NullablePointer[ODBCHandleEnv tag](h), SQLAttrOdbcVersion(), SQLAttrOvOdbc3(), SQLIsInteger())
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_penv(h) end
    | -1 => return recover val SQLError.create_penv(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCEnvFFI.set_odbc3() got invalid return code: " + rv.string()) end
    end

  fun sql_alloc_handle(): (SQLReturn val, ODBCHandleEnv tag) =>
    var rv: ODBCHandleEnv tag = ODBCHandleEnv
    var rvv: I16 = @SQLAllocHandle(1, Pointer[None], addressof rv)
    match rvv
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_penv(rv) end, rv)
    | -1 => return (recover val SQLError.create_penv(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (recover val PonyDriverError("ODBCEnvFFI.set_odbc2() got invalid return code: " + rvv.string()) end, rv)
    end

  fun free(h: ODBCHandleEnv tag) => @SQLFreeHandle(1, NullablePointer[ODBCHandleEnv tag](h))

