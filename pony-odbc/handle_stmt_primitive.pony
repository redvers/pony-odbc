use "debug"

struct ODBCHandleStmt
  fun prepare(str: String val, prev: SQLReturn val): SQLReturn val =>
    var rv: SQLReturn val = ODBCHandleStmts.prepare(this, str, prev)
    Debug.out("ODBCHandleStmt.prepare: [" + prev.string() + "|" + rv.string() + "]")
    rv

  fun bind_col_i32(colnum: U16, target: CBoxedI32 tag, prev: SQLReturn val): SQLReturn val =>
    var rv: SQLReturn val = ODBCHandleStmts.bind_col_i32(this, colnum, target, prev)
    Debug.out("ODBCHandleStmt.bind_col_i32: [" + prev.string() + "|" + rv.string() + "]")
    rv

  fun fetch(prev: SQLReturn val): SQLReturn val =>
    var rv: SQLReturn val = ODBCHandleStmts.fetch(this,  prev)
    Debug.out("ODBCHandleStmt.fetch: [" + prev.string() + "|" + rv.string() + "]")
    rv

  fun execute(prev: SQLReturn val): SQLReturn val =>
    var rv: SQLReturn val = ODBCHandleStmts.execute(this,  prev)
    Debug.out("ODBCHandleStmt.execute: [" + prev.string() + "|" + rv.string() + "]")
    rv

primitive ODBCHandleStmts
  fun alloc(h: ODBCHandleDbc tag): (SQLReturn val, ODBCHandleStmt iso^) =>
    var rv: ODBCHandleStmt iso = ODBCHandleStmt
    match @SQLAllocHandle(3, h, addressof rv)
    | 0 => return (SQLSuccess, consume rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_pstmt(rv) end, consume rv)
    | -1 => return (recover val SQLError.create_pstmt(rv) end, consume rv)
    | -2 => return (SQLInvalidHandle, consume rv)
    else
      (PonyDriverError, consume rv)
    end

  fun prepare(h: ODBCHandleStmt tag, str: String val, prev: SQLReturn val): SQLReturn val =>
    Debug.out("CFFI: SQLPrepare")
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

  fun bind_col_i32(h: ODBCHandleStmt tag, colnum: U16, target: CBoxedI32 tag, prev: SQLReturn val): SQLReturn val =>
    match prev
    | let x: SQLSuccess val => _bind_col_i32(h, colnum, target)
    | let x: SQLSuccessWithInfo val => _bind_col_i32(h, colnum, target)
    else
      prev
    end

  fun _bind_col_i32(h: ODBCHandleStmt tag, colnum: U16, target: CBoxedI32 tag): SQLReturn val =>
    var boxedsize: SQLCSBigInt = SQLCSBigInt
    Debug.out("CFFI: SQLBindCol")
    match @SQLBindCol(NullablePointer[ODBCHandleStmt tag](h), colnum, SQLInteger()+SQLSignedOffset(), target, I64(4), boxedsize)
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    PonyDriverError

  fun execute(h: ODBCHandleStmt tag, prev: SQLReturn val): SQLReturn val =>
    match prev
    | let x: SQLSuccess val => _execute(h)
    | let x: SQLSuccessWithInfo val => _execute(h)
    else
      prev
    end

  fun _execute(h: ODBCHandleStmt tag): SQLReturn val =>
    """
    SQL_SUCCESS
    SQL_SUCCESS_WITH_INFO
    SQL_STILL_EXECUTING
    SQL_ERROR
    SQL_INVALID_HANDLE
    SQL_NEED_DATA
    SQL_NO_DATA
    SQL_PARAM_DATA_AVAILABLE. // Not present in our impementation?
    """
    Debug.out("CFFI: SQLExecute")
    match @SQLExecute(NullablePointer[ODBCHandleStmt tag](h))
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    PonyDriverError


  fun fetch(h: ODBCHandleStmt tag, prev: SQLReturn val): SQLReturn val =>
    match prev
    | let x: SQLSuccess val => _fetch(h)
    | let x: SQLSuccessWithInfo val => _fetch(h)
    else
      prev
    end

  fun _fetch(h: ODBCHandleStmt tag): SQLReturn val =>
    """
    SQL_SUCCESS
    SQL_SUCCESS_WITH_INFO
    SQL_STILL_EXECUTING
    SQL_ERROR
    SQL_INVALID_HANDLE
    SQL_NO_DATA
    """
    Debug.out("CFFI: SQLFetch")
    match @SQLFetch(NullablePointer[ODBCHandleStmt tag](h))
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    PonyDriverError


