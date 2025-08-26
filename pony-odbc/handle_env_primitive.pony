struct ODBCHandleEnv
  fun set_odbc2(): SQLReturn => ODBCHandleEnvs.set_odbc2(this)
  fun set_odbc3(): SQLReturn => ODBCHandleEnvs.set_odbc3(this)

primitive ODBCHandleEnvs
  fun alloc(): (SQLReturn, ODBCHandleEnv) =>
    var rv: ODBCHandleEnv = ODBCHandleEnv
    match @SQLAllocHandle(1, Pointer[None], addressof rv)
    | 0 => return (SQLSuccess, rv)
    | 1 => return (SQLSuccessWithInfo.create_penv(rv), rv)
    | -1 => return (SQLError.create_penv(rv), rv)
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

  fun set_odbc3(h: ODBCHandleEnv tag): SQLReturn =>
    match @SQLSetEnvAttr(NullablePointer[ODBCHandleEnv tag](h), SQLAttrOdbcVersion(), SQLAttrOvOdbc3(), SQLIsInteger())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo.create_penv(h)
    | -1 => return SQLError.create_penv(h)
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



