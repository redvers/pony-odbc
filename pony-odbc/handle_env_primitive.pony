use @SQLSetEnvAttr[I16](henv: Pointer[None] tag, attr: I32, v: I32, sl: I32)
use @SQLGetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)


struct ODBCHandleEnv
  fun set_odbc2(): SQLReturn => ODBCHandleEnvs.set_odbc2(this)
  fun set_odbc3(inputstatus: SQLReturn val): SQLReturn val =>
    match inputstatus
    | let x: SQLSuccess => return ODBCHandleEnvs.set_odbc3(this)
    else
      return inputstatus
    end

  fun dispose() =>
    @SQLFreeHandle(1, NullablePointer[ODBCHandleEnv tag](this))

primitive ODBCHandleEnvs
  fun alloc(): (SQLReturn val, ODBCHandleEnv) =>
    var rv: ODBCHandleEnv = ODBCHandleEnv
    match @SQLAllocHandle(1, Pointer[None], addressof rv)
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_penv(rv) end, rv)
    | -1 => return (recover val SQLError.create_penv(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (PonyDriverError, rv)
    end

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



