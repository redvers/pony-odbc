use @SQLSetEnvAttr[I16](henv: Pointer[None] tag, attr: I32, v: I32, sl: I32)
use @SQLGetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)

use "env"
use "ctypes"
use "attributes"
use "instrumentation"

struct \nodoc\ ODBCHandleEnv

primitive ODBCEnv
  fun alloc(): (SQLReturn val, ODBCHandleEnv tag) =>
    ODBCEnvFFI.sql_alloc_handle()

  fun set_odbc2(h: ODBCHandleEnv tag): SQLReturn =>
    match @SQLSetEnvAttr(NullablePointer[ODBCHandleEnv tag](h), SQLAttrOdbcVersion(), SQLAttrOvOdbc2(), SQLIsInteger())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo.create_penv(h)
    | -1 => return SQLError.create_penv(h)
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end

  fun set_odbc3(h: ODBCHandleEnv tag): SQLReturn val =>
    match @SQLSetEnvAttr(NullablePointer[ODBCHandleEnv tag](h), SQLAttrOdbcVersion(), SQLAttrOvOdbc3(), SQLIsInteger())
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_penv(h) end
    | -1 => return recover val SQLError.create_penv(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end


/*
        if (@SQLSetEnvAttr(henv, SQLAttrOdbcVersion(), SQLAttrOvOdbc2(), SQLIsInteger()) != SQLSuccess()) then error end
  fun set_odbc3() ? =>
    if (@SQLSetEnvAttr(henv, SQLAttrOdbcVersion(), SQLAttrOvOdbc3(), SQLIsInteger()) != SQLSuccess()) then error end

  fun dispose() =>
    @SQLFreeHandle(1, henv)

  fun _final() =>
    @SQLFreeHandle(1, henv)

u*/



