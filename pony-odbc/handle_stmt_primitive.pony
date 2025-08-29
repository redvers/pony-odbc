use @SQLBindParameter[I16](hstmt: Pointer[None] tag, ipar: U16, fParamType: I16, fCType: I16, fSqlType: I16, cbColDef: U64, ibScale: I16, rgbValue: Pointer[None] tag, cbValueMax: I64, pcbValue: Pointer[I64] tag)
use @SQLExecDirect[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLPrepare[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLExecute[I16](StatementHandle: Pointer[None] tag)
use @SQLNumResultCols[I16](StatementHandle: Pointer[None] tag, ColumnCount: Pointer[I16] tag)
use @SQLBindCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, TargetType: I16, ...) // TargetValue: Pointer[None] tag, BufferLength: I64, StrLenorInd: BoxedI64)
use @SQLFetch[I16](StatementHandle: Pointer[None] tag)
use @SQLGetTypeInfo[I16](StatementHandle: Pointer[None] tag, DataType: I16)
use @SQLDescribeCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, ColumnName: Pointer[U8] tag, BufferLength: I16, NameLength: CBoxedI16 tag, DataType: CBoxedI16 tag, ColumnSize: CBoxedU64 tag, DecimalDigits: CBoxedI16 tag, Nullable: CBoxedI16 tag)

use "debug"
use "ctypes"

struct ODBCHandleStmt

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

  fun describe_col(h: ODBCHandleStmt tag, col: U16, fillme: SQLDescribeColOut): SQLReturn val =>  // This needs refactoring - FIXME
    Debug("Checking col: " + col.string())
    var rv: I16 = @SQLDescribeCol[I16](NullablePointer[ODBCHandleStmt tag](h),
    col,
    fillme.column_name.buffer,
    fillme.column_name.buffersize.i16(),
    fillme.writtenlen,
    fillme.datatype,
    fillme.colsize,
    fillme.decdigits,
    fillme.nullable)
    fillme.column_name.writtensize = fillme.writtenlen.value.i64()

    fillme.column_number = col


    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end

  fun get_type_info(h: ODBCHandleStmt tag, dt: I16): SQLReturn val =>
    var rv: I16 = @SQLGetTypeInfo(NullablePointer[ODBCHandleStmt tag](h), dt)
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end

  fun prepare(h: ODBCHandleStmt tag, str: String val): SQLReturn val =>
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

  fun execute(h: ODBCHandleStmt tag): SQLReturn val =>
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

/*
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

  fun bind_col_i32(h: ODBCHandleStmt tag, colnum: U16, target: CBoxedI32 tag): SQLReturn val =>
    var boxedsize: CBoxedI64 = CBoxedI64
    Debug.out("CFFI: SQLBindCol")
    match @SQLBindCol(NullablePointer[ODBCHandleStmt tag](h), colnum, 4 - 20, target, I64(4), boxedsize)
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    PonyDriverError

    */
