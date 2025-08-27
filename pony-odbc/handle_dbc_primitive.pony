struct ODBCHandleDbc
  fun set_application_name(s: String val): SQLReturn val =>
    ODBCHandleDbcs.set_application_name(this, s)
  fun connect(dsn: String val): SQLReturn val =>
    ODBCHandleDbcs.connect(this, dsn)
  fun dispose() =>
    @SQLFreeHandle(2, NullablePointer[ODBCHandleDbc tag](this))


primitive ODBCHandleDbcs
  fun alloc(h: ODBCHandleEnv tag): (SQLReturn val, ODBCHandleDbc) =>
    var rv: ODBCHandleDbc = ODBCHandleDbc
    match @SQLAllocHandle(2, h, addressof rv)
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_pdbc(rv) end, rv)
    | -1 => return (recover val SQLError.create_pdbc(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (PonyDriverError, rv)
    end

  fun set_application_name(h: ODBCHandleDbc tag, s: String val): SQLReturn val =>
    match @SQLSetConnectAttr[I16](NullablePointer[ODBCHandleDbc tag](h), SQLAttrApplicationName(), s.cstring(), s.size().i32())
    | 0 => return SQLSuccess
    | -1 => return recover val SQLError.create_pdbc(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end

  fun connect(h: ODBCHandleDbc tag, dsn: String val): SQLReturn val =>
    match @SQLConnect(NullablePointer[ODBCHandleDbc tag](h), dsn.cstring(), dsn.size().i16(), "".cstring(), 0, "".cstring(), 0)
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pdbc(h) end
    | -1 => return recover val SQLError.create_pdbc(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end

  fun prepare(hdbc: ODBCHandleDbc tag, sql: String val, prev: SQLReturn val): (SQLReturn val, ODBCHandleStmt tag) =>
    (var rv: SQLReturn val, var stmt: ODBCHandleStmt val) = ODBCHandleStmts.alloc(hdbc)
    match rv
    | let x: SQLSuccess val => _prepare(stmt, sql, x)
    | let x: SQLSuccessWithInfo val => _prepare(stmt, sql, x)
    | let x: SQLError val => return (x, stmt)
    | let x: SQLInvalidHandle val => return (x, stmt)
    else
      return (rv, stmt)
    end

  fun _prepare(hstmt: ODBCHandleStmt tag, sql: String val, prev: SQLReturn val): (SQLReturn val, ODBCHandleStmt tag) =>
    var rv: SQLReturn val = ODBCHandleStmts.prepare(hstmt, sql, prev)
    (rv, hstmt)








//    match @SQLPrepare(NullablePointer[ODBCHandleStmt tag](stmt), sql.cstring(), sql.size().i32())





