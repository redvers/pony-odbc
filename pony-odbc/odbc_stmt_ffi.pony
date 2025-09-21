use @SQLBindParameter[I16](hstmt: Pointer[None] tag, ipar: U16, fParamType: I16, fCType: I16, fSqlType: I16, cbColDef: U64, ibScale: I16, ...) //rgbValue: Pointer[None] tag, cbValueMax: I64, pcbValue: CBoxedI64 tag)
use @SQLExecDirect[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLPrepare[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLExecute[I16](StatementHandle: Pointer[None] tag)
use @SQLNumResultCols[I16](StatementHandle: Pointer[None] tag, ColumnCount: CBoxedI16 tag)
use @SQLFetch[I16](StatementHandle: Pointer[None] tag)
use @SQLGetTypeInfo[I16](StatementHandle: Pointer[None] tag, DataType: I16)
use @SQLDescribeParam[I16](hstmt: Pointer[None] tag, ipar: U16, pfSqlType: CBoxedI16 tag, pcbParamDef: CBoxedU64 tag, pibScale: CBoxedI16 tag, pfNullable: CBoxedI16 tag)
use @SQLDescribeCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, ColumnName: Pointer[U8] tag, BufferLength: I16, NameLength: CBoxedI16, DataType: CBoxedI16 tag, ColumnSize: CBoxedU64 tag, DecimalDigits: CBoxedI16 tag, Nullable: CBoxedI16 tag)
use @SQLBindCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, TargetType: I16, TargetValue: Pointer[U8] tag, BufferLength: I64, StrLenorInd: CBoxedI64 tag)
use @SQLRowCount[I16](StatementHandle: Pointer[None] tag, RowCount: CBoxedI64 tag)
use @SQLCloseCursor[I16](StatementHandle: Pointer[None] tag)
use @SQLFetchScroll[I16](StatementHandle: Pointer[None] tag, FetchOrientation: I16, FetchOffset: I64)

use "debug"

struct \nodoc\ ODBCHandleStmt

primitive \nodoc\ ODBCStmtFFI
  fun alloc(h: ODBCHandleDbc tag): (_SQLReturn val, ODBCHandleStmt tag) =>
    var rv: ODBCHandleStmt tag = ODBCHandleStmt
    var rvv: I16 = @SQLAllocHandle(3, NullablePointer[ODBCHandleDbc tag](h), addressof rv)
    match rvv
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_pstmt(rv) end, rv)
    | -1 => return (recover val SQLError.create_pstmt(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (recover val PonyDriverError("ODBCStmtFFI.alloc() got invalid return code: " + rvv.string()) end, rv)
    end

  fun get_data(h: ODBCHandleStmt tag, col: U16, v: CBoxedArray): _SQLReturn val =>
    var rv: I16 = @SQLGetData[I16](
      NullablePointer[ODBCHandleStmt tag](h),
      col,
      I16(1),
      v.ptr,
      v.alloc_size.i64(),
      v.written_size)

    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 100 => return SQLNoData
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCEnvFFI.fetch_scroll() got invalid return code: " + rv.string()) end
    end

  fun fetch_scroll(h: ODBCHandleStmt tag, d: SqlFetchOrientation, offset: I64 = 0): _SQLReturn val =>
    """
    SQLFetchScroll fetches the specified rowset of data from the result set and returns data for all bound columns. Rowsets can be specified at an absolute or relative position or by bookmark.
    """
    var rv: I16 = @SQLFetchScroll(NullablePointer[ODBCHandleStmt tag](h), d(), offset)
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 100 => return SQLNoData
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCEnvFFI.fetch_scroll() got invalid return code: " + rv.string()) end
    end

  fun prepare(h: ODBCHandleStmt tag, str: String val): _SQLReturn val =>
    """
    Prepares the provided SQL Statement.
    """
    var rv: I16 = @SQLPrepare(NullablePointer[ODBCHandleStmt tag](h), str.cstring(), str.size().i32())
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCEnvFFI.prepare() got invalid return code: " + rv.string()) end
    end

// use @SQLExecDirect[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
  fun exec_direct(h: ODBCHandleStmt tag, query: String val): _SQLReturn val =>
    var rv: I16 =  @SQLExecDirect[I16](NullablePointer[ODBCHandleStmt tag](h), query.cstring(), query.size().i32())
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    recover val PonyDriverError("ODBCHandleStmt.exec_direct() get invalid return code: " + rv.string()) end



  fun execute(h: ODBCHandleStmt tag): _SQLReturn val =>
    """
    Executes the provided SQL statement.
    
    If there are parameters, or you actually want data bound to columns,
    this must be done before this point
    """
//    SQL_SUCCESS
//    SQL_SUCCESS_WITH_INFO
//    SQL_STILL_EXECUTING
//    SQL_ERROR
//    SQL_INVALID_HANDLE
//    SQL_NEED_DATA
//    SQL_NO_DATA
//    SQL_PARAM_DATA_AVAILABLE. // Not present in our impementation?
    var rv: I16 = @SQLExecute(NullablePointer[ODBCHandleStmt tag](h))
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    recover val PonyDriverError("ODBCHandleStmt.execute() get invalid return code: " + rv.string()) end
/*
  fun describe_param(h: ODBCHandleStmt tag, i: SQLDescribeParamOut): _SQLReturn val =>
    """
    Used to query the parameter provided in the prepared statement so
    the database driver can validate that the correct fields have been
    bound to the correct variable type.

    Populates provided SQLDescribeParamOut.
    """
    var rv: I16 = @SQLDescribeParam[I16](
        NullablePointer[ODBCHandleStmt tag](h),
        i.param_number,
        i.data_type_ptr,
        i.parameter_size_ptr,
        i.decimal_digits_ptr,
        i.nullable_ptr)
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCHandleStmt.describe_param() get invalid return code: " + rv.string()) end
    end

    */
  fun bind_parameter_varchar(h: ODBCHandleStmt tag, col: U16, v: CBoxedArray): _SQLReturn val => // FIXME Refactor time
    """
    Binds a varchar, or similar variable type to a parameter.
    """
    var wrlen: CBoxedI64 = CBoxedI64
    wrlen.value = ODBCVarcharConsts.sql_nts().i64()
    var rv: I16 = @SQLBindParameter[I16](
        NullablePointer[ODBCHandleStmt tag](h),
        col,
        I16(1),
        I16(1),
        I16(-1),
        v.alloc_size.u64(),
        I16(0),
        v.ptr,
        v.written_size.value,
        wrlen
      )

    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCHandleStmt.bind_parameter_varchar() get invalid return code: " + rv.string()) end
    end

/*
  fun bind_parameter_i32(h: ODBCHandleStmt tag, desc: SQLDescribeParamOut, v: CBoxedI32): _SQLReturn val => // FIXME Refactor time
    """
    Binds a varchar, or similar variable type to a parameter.
    """
    var wrlen: CBoxedI64 = CBoxedI64
    wrlen.value = 0
    var rv: I16 = @SQLBindParameter[I16](
        NullablePointer[ODBCHandleStmt tag](h),
        desc.param_number,
        I16(1),
        I16(4),
        I16(4),
        U64(0),
        I16(0),
        v,
        I64(0),
        wrlen
      )

    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCHandleStmt.bind_parameter_i32() get invalid return code: " + rv.string()) end
    end
*/
/*
  fun describe_column(h: ODBCHandleStmt tag, fillme: SQLDescribeColOut, colname: String val): _SQLReturn val =>
/*
  SQLHSTMT       StatementHandle,
  SQLUSMALLINT   ColumnNumber,
  SQLCHAR *      ColumnName,
  SQLSMALLINT    BufferLength,
  SQLSMALLINT *  NameLengthPtr,
  SQLSMALLINT *  DataTypePtr,
  SQLULEN *      ColumnSizePtr,
  SQLSMALLINT *  DecimalDigitsPtr,
  SQLSMALLINT *  NullablePtr);
*/

    var rv: I16 = @SQLDescribeCol[I16](NullablePointer[ODBCHandleStmt tag](h),
    fillme.column_number,
    fillme.column_name.ptr,
    fillme.column_name.alloc_size.i16(),
    fillme.writtenlen_ptr,
    fillme.datatype_ptr,
    fillme.colsize_ptr,
    fillme.decdigits_ptr,
    fillme.nullable_ptr)

    var cn: String val = fillme.column_name.string()

    if (colname != cn) then
      return recover val PonyDriverError("ODBCHandleStmt.describe_column(): columns don't match: " + colname + " != " + cn) end
    end

    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCHandleStmt.describe_column() get invalid return code: " + rv.string()) end
    end
*/
  fun bind_column_varchar(h: ODBCHandleStmt tag, col: U16, v: CBoxedArray): _SQLReturn val =>
/*SQLRETURN SQLBindCol(
      SQLHSTMT       StatementHandle,
      SQLUSMALLINT   ColumnNumber,
      SQLSMALLINT    TargetType,
      SQLPOINTER     TargetValuePtr,
      SQLLEN         BufferLength,
      SQLLEN *       StrLen_or_IndPtr);
*/
    var wrlen: I64 = 0
    var rv: I16 = @SQLBindCol[I16](
      NullablePointer[ODBCHandleStmt tag](h),
      col,
      I16(1),
      v.ptr,
      v.alloc_size.i64(),
      v.written_size)

    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCHandleStmt.bind_column_varchar() get invalid return code: " + rv.string()) end
    end
/*
  fun bind_column_i32(h: ODBCHandleStmt tag, desc: SQLDescribeColOut, v: CBoxedI32): _SQLReturn val =>
/*SQLRETURN SQLBindCol(
      SQLHSTMT       StatementHandle,
      SQLUSMALLINT   ColumnNumber,
      SQLSMALLINT    TargetType,
      SQLPOINTER     TargetValuePtr,
      SQLLEN         BufferLength,
      SQLLEN *       StrLen_or_IndPtr);
*/
    var wrlen: CBoxedI64 = CBoxedI64
    var rv: I16 = @SQLBindCol[I16](
      NullablePointer[ODBCHandleStmt tag](h),
      desc.column_number,
      I16(4),
      v,
      I64(0),
      wrlen)
//use @SQLBindCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, TargetType: I16, TargetValue: Pointer[U8] tag, BufferLength: I64, StrLenorInd: Pointer[I64] tag)

    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCHandleStmt.bind_column_i32() get invalid return code: " + rv.string()) end
    end
*/
    /*
  fun bind_column_i32(h: ODBCHandleStmt tag, desc: SQLDescribeColOut, v: CBoxedI32): _SQLReturn val =>

/*SQLRETURN SQLBindCol(
      SQLHSTMT       StatementHandle,
      SQLUSMALLINT   ColumnNumber,
      SQLSMALLINT    TargetType,
      SQLPOINTER     TargetValuePtr,
      SQLLEN         BufferLength,
      SQLLEN *       StrLen_or_IndPtr);
*/

    var wrlen: I64 = 0
    var rv: I16 = @SQLBindCol[I16](
      NullablePointer[ODBCHandleStmt tag](h),
      desc.column_number,
      I16(4),
      v,
      v.sizeof(),
      addressof wrlen)

    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      PonyDriverError
    end


*/



  fun get_type_info(h: ODBCHandleStmt tag, dt: I16): _SQLReturn val =>
    var rv: I16 = @SQLGetTypeInfo(NullablePointer[ODBCHandleStmt tag](h), dt)
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCHandleStmt.get_type_info() get invalid return code: " + rv.string()) end
    end


  fun fetch(h: ODBCHandleStmt tag): _SQLReturn val =>
    """
    SQL_SUCCESS
    SQL_SUCCESS_WITH_INFO
    SQL_STILL_EXECUTING
    SQL_ERROR
    SQL_INVALID_HANDLE
    SQL_NO_DATA
    """
    var rv: I16 = @SQLFetch(NullablePointer[ODBCHandleStmt tag](h))
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    recover val PonyDriverError("ODBCHandleStmt.fetch() get invalid return code: " + rv.string()) end

//use @SQLNumResultCols[I16](StatementHandle: Pointer[None] tag, ColumnCount: CBoxedI16 tag)
  fun result_count(h: ODBCHandleStmt tag, colcnt: CBoxedI64): _SQLReturn val =>
    var rv: I16 = @SQLRowCount[I16](NullablePointer[ODBCHandleStmt tag](h), colcnt)
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    recover val PonyDriverError("ODBCHandleStmt.result_count() get invalid return code: " + rv.string()) end

    // use @SQLCloseCursor[I16](StatementHandle: Pointer[None] tag)
  fun close_cursor(h: ODBCHandleStmt tag): _SQLReturn val =>
    var rv: I16 = @SQLCloseCursor(NullablePointer[ODBCHandleStmt tag](h))
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_pstmt(h) end
    | 2 => return SQLStillExecuting
    | -1 => return recover val SQLError.create_pstmt(h) end
    | -2 => return SQLInvalidHandle
    | 100 => return SQLNoData
    end
    recover val PonyDriverError("ODBCHandleStmt.close_cursor() get invalid return code: " + rv.string()) end

  fun free(h: ODBCHandleStmt tag) => @SQLFreeHandle(3, NullablePointer[ODBCHandleStmt tag](h))

