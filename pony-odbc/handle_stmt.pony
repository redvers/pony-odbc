use @SQLBindParam[I16](StatementHandle: Pointer[None] tag, ParameterNumber: U16, ValueType: I16, ParameterType: I16, LengthPrecision: U64, ParameterScale: I16, ParameterValue: Pointer[None] tag, StrLenorInd: Pointer[I64] tag)
use @SQLExecDirect[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLPrepare[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLExecute[I16](StatementHandle: Pointer[None] tag)
use @SQLNumResultCols[I16](StatementHandle: Pointer[None] tag, ColumnCount: Pointer[I16] tag)
use @SQLBindCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, TargetType: I16, ...) // TargetValue: Pointer[None] tag, BufferLength: I64, StrLenorInd: BoxedI64)
use @SQLFetch[I16](StatementHandle: Pointer[None] tag)


use "debug"

class HandleSTMT
  var hdbc: HandleDBC
  var hstmt: Pointer[None] = Pointer[None]
  var numresultcols: I16 = 0



  fun ht(): I16 => 3
  fun ref h(): Pointer[None] => hstmt


  fun apply(): I16 => 3

  new create(dbc: HandleDBC) ? =>
    hdbc = dbc
    if (@SQLAllocHandle(3, hdbc.hdbc, addressof hstmt) != SQLSuccess()) then error end

  fun ref fetch(): SQLReturn =>
    match @SQLFetch(hstmt)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

    /* postgresql driver native types:
     *
     * bool, int2, int4, int8, float4, float8, date, time, abstime
     * datetime, timestamp, char, varchar, text
     */

  fun ref bind_col_f32(colnum: U16, target: BoxedF32 tag): SQLReturn =>
    var boxedsize: BoxedI64 = BoxedI64
    match @SQLBindCol(hstmt, colnum, SQLReal(), target, I64(4), boxedsize)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)







  fun ref bind_col_i16(colnum: U16, target: BoxedI16 tag): SQLReturn =>
    var boxedsize: BoxedI64 = BoxedI64
    match @SQLBindCol(hstmt, colnum, SQLSmallInt()+SQLSignedOffset(), target, I64(2), boxedsize)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

  fun ref bind_col_i32(colnum: U16, target: BoxedI32 tag): SQLReturn =>
    var boxedsize: BoxedI64 = BoxedI64
    match @SQLBindCol(hstmt, colnum, SQLInteger()+SQLSignedOffset(), target, I64(4), boxedsize)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

  fun ref bind_col_i64(colnum: U16, target: BoxedI64 tag): SQLReturn =>
    var boxedsize: BoxedI64 = BoxedI64
    match @SQLBindCol(hstmt, colnum, SQLBigInt()+SQLSignedOffset(), target, I64(8), boxedsize)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

  fun ref num_result_cols(): SQLReturn =>
    match @SQLNumResultCols(hstmt, addressof numresultcols)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

  fun ref exec_direct(str: String val): SQLReturn =>
    match @SQLExecDirect(hstmt, str.cstring(), str.size().i32())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

  fun ref prepare(str: String val): SQLReturn =>
    match @SQLPrepare(hstmt, str.cstring(), str.size().i32())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

  fun ref execute(): SQLReturn =>
    match @SQLExecute(hstmt)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo(this)
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)

  fun _final() =>
    @SQLFreeHandle(3, hstmt)



