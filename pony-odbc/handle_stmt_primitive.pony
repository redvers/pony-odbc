struct ODBCHandleStmt
  fun prepare(str: String val): SQLReturn val =>
    ODBCHandleStmts.prepare(this, str)

primitive ODBCHandleStmts
  fun alloc(h: ODBCHandleDbc tag): (SQLReturn val, ODBCHandleStmt) =>
    var rv: ODBCHandleStmt = ODBCHandleStmt
    match @SQLAllocHandle(3, h, addressof rv)
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_pstmt(rv) end, rv)
    | -1 => return (recover val SQLError.create_pstmt(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (PonyDriverError, rv)
    end

  fun prepare(h: ODBCHandleStmt tag, str: String val): SQLReturn val =>
    var rv: I16 = @SQLPrepare(NullablePointer[ODBCHandleStmt tag](h), str.cstring(), str.size().i32())
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end
//      SQL_SUCCESS, SQL_SUCCESS_WITH_INFO, SQL_STILL_EXECUTING, SQL_ERROR, or SQL_INVALID_HANDLE.
