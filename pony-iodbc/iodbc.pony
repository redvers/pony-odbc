use "debug"
use "collections"

use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[Pointer[None]] tag)
use @SQLSetEnvAttr[I16](henv: Pointer[None] tag, attr: I32, v: I32, sl: I32)
use @SQLGetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)
use @SQLSetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, StringLength: I32)
use @SQLGetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)
use @SQLConnect[I16](ConnectionHandle: Pointer[None] tag, ServerName: Pointer[U8] tag, NameLength1: I16, UserName: Pointer[U8] tag, NameLength2: I16, Authentication: Pointer[U8] tag, NameLength3: I16)
use @SQLBindParam[I16](StatementHandle: Pointer[None] tag, ParameterNumber: U16, ValueType: I16, ParameterType: I16, LengthPrecision: U64, ParameterScale: I16, ParameterValue: Pointer[None] tag, StrLenorInd: Pointer[I64] tag)
use @SQLExecDirect[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLPrepare[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)
use @SQLExecute[I16](StatementHandle: Pointer[None] tag)
use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)
use @SQLGetDiagRec[I16](HandleType: I16, Handle: Pointer[None] tag, RecNumber: I16, Sqlstate: Pointer[U8] tag, NativeError: Pointer[I32] tag, MessageText: Pointer[U8] tag, BufferLength: I16, TextLength: Pointer[I16] tag)
use @SQLEndTran[I16](HandleType: I16, Handle: Pointer[None] tag, CompletionType: I16)


type ODBCHandle is (HandleENV | HandleDBC | HandleSTMT)
class HandleENV
  var henv: Pointer[None] = Pointer[None]
  fun ht(): I16 => 1
  fun ref h(): Pointer[None] => henv

  new create() ? =>
    if (@SQLAllocHandle(SQLEnum.handle_env(), Pointer[None], addressof henv) != SQLEnum.success()) then error end
  fun set_odbc2() ? =>
    if (@SQLSetEnvAttr(henv, SQLEnum.attr_odbc_version(), 2, SQLEnum.is_integer()) != SQLEnum.success()) then error end
  fun set_odbc3() ? =>
    if (@SQLSetEnvAttr(henv, SQLEnum.attr_odbc_version(), 3, SQLEnum.is_integer()) != SQLEnum.success()) then error end


class HandleDBC
  var henv: HandleENV
  var hdbc: Pointer[None] = Pointer[None]
  fun ht(): I16 => 2
  fun ref h(): Pointer[None] => hdbc

  new create(he: HandleENV) ? =>
    henv = he
    if (@SQLAllocHandle(SQLEnum.handle_dbc(), he.henv, addressof hdbc) != SQLEnum.success()) then error end

  fun set_application_name(s: String) ? =>
    if (@SQLSetConnectAttr[I16](hdbc, 1051, s.cstring(), s.size().i32()) != SQLEnum.success()) then error end

  fun ref connect(dsn: String) ? =>
    if (@SQLConnect(hdbc, dsn.cstring(), dsn.size().i16(), "".cstring(), 0, "".cstring(), 0) != SQLEnum.success()) then error end

  fun ref commit(): SQLReturn  =>
    match @SQLEndTran(SQLEnum.handle_dbc(), hdbc, SQLEnum.sql_commit())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    ODBCError


  fun ref get_commit_mode(): SQLReturn =>
    var r: I16 = 9
    match @SQLGetConnectAttr(hdbc, 102, addressof r, -6, Pointer[I32])
    | 0 => Debug.out("ssss: " + r.string()) ; return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    ODBCError

//use @SQLSetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, StringLength: I32)
/*
  fun ref set_commit_mode(cm: Bool): SQLReturn =>
    var r: I16 = 9
    var cmm: I16 = 0
    if (cm) then
      cmm = 1
    end
    match @SQLSetConnectAttr(hdbc, 102, addressof r, -6, Pointer[I32])
    | 0 => Debug.out("ssss: " + r.string()) ; return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    ODBCError

    match @SQLSetConnectAttr(hdbc, 102, addressof r, -6, Pointer[I32])
    | 0 => Debug.out("ssss: " + r.string()) ; return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    ODBCError
*/






class HandleSTMT
  var hdbc: HandleDBC
  var hstmt: Pointer[None] = Pointer[None]
  fun ht(): I16 => 3
  fun ref h(): Pointer[None] => hstmt

  new create(dbc: HandleDBC) ? =>
    hdbc = dbc
    if (@SQLAllocHandle(SQLEnum.handle_stmt(), hdbc.hdbc, addressof hstmt) != SQLEnum.success()) then error end

//  fun ref bind_parameter(

  fun ref exec_direct(str: String val): SQLReturn =>
    match @SQLExecDirect(hstmt, str.cstring(), str.size().i32())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    ODBCError

  fun ref prepare(str: String val): SQLReturn =>
    match @SQLPrepare(hstmt, str.cstring(), str.size().i32())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    ODBCError

  fun ref execute(): SQLReturn =>
    match @SQLExecute(hstmt)
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    ODBCError

  fun _final() =>
    @SQLFreeHandle(SQLEnum.handle_stmt(), hstmt)






type SQLReturn is (SQLSuccess |
                   SQLSuccessWithInfo |
                   SQLStillExecuting |
                   SQLError |
                   SQLInvalidHandle |
                   SQLNeedData |
                   SQLNoData |
                   ODBCError)

primitive SQLSuccess fun string(): String val => "SQLSuccess"
primitive SQLSuccessWithInfo fun string(): String val => "SQLSuccessWithInfo"
primitive SQLStillExecuting fun string(): String val => "SQLStillExecuting"
primitive SQLInvalidHandle fun string(): String val => "SQLInvalidHandle"
primitive SQLNeedData fun string(): String val => "SQLNeedData"
primitive SQLNoData fun string(): String val => "SQLNoData"
primitive ODBCError fun string(): String val => "ODBCError"

class SQLError
  var records: Array[(I16, SQLDiagFrame)] = Array[(I16, SQLDiagFrame)]

  fun string(): String val => "SQLError"

  new create(htype: ODBCHandle) =>
    Debug.out("Called SQLError")
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create(htype, num)?))
      else
        break
      end
    end



class SQLDiagFrame
  var handle_type: I16 = 0
  var handle: Pointer[None] = Pointer[None]
  var recnum: I16 = 0
  var sqlstate: String ref = ".".mul(5)
  var nativeerrptr: I32 = 0
  var msgbuff: String ref = ".".mul(4096)
  var textlen: I16 = 0

  new create(htype: ODBCHandle, num: I16)? =>
    if (false) then error end

    let s: I16 = @SQLGetDiagRec(
          htype.ht(),
          htype.h(),
          num,
          sqlstate.cstring(),
          addressof nativeerrptr,
          msgbuff.cstring(),
          msgbuff.size().i16(),
          addressof textlen)

    msgbuff.recalc()
    Debug.out(msgbuff)
    if (s != 0) then error end



