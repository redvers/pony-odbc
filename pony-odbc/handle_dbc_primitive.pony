struct ODBCHandleDbc
  fun set_application_name(s: String val): SQLReturn val =>
    ODBCHandleDbcs.set_application_name(this, s)
  fun connect(dsn: String val): SQLReturn val =>
    ODBCHandleDbcs.connect(this, dsn)


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


