use @SQLBindParam[I16](StatementHandle: Pointer[None] tag, ParameterNumber: U16, ValueType: I16, ParameterType: I16, LengthPrecision: U64, ParameterScale: I16, ParameterValue: Pointer[None] tag, StrLenorInd: Pointer[I64] tag)
use @SQLExecDirect[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLPrepare[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLExecute[I16](StatementHandle: Pointer[None] tag)

use "debug"

class HandleSTMT
  var hdbc: HandleDBC
  var hstmt: Pointer[None] = Pointer[None]
  fun ht(): I16 => 3
  fun ref h(): Pointer[None] => hstmt

  fun apply(): I16 => 3

  new create(dbc: HandleDBC) ? =>
    hdbc = dbc
    if (@SQLAllocHandle(3, hdbc.hdbc, addressof hstmt) != SQLSuccess()) then error end

//  fun ref bind_parameter(

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



