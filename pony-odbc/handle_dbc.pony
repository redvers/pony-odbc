use @SQLConnect[I16](ConnectionHandle: Pointer[None] tag, ServerName: Pointer[U8] tag, NameLength1: I16, UserName: Pointer[U8] tag, NameLength2: I16, Authentication: Pointer[U8] tag, NameLength3: I16)
use @SQLSetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, StringLength: I32)
use @SQLGetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength
: Pointer[I32] tag)

use "debug"

class HandleDBC
  var henv: HandleENV
  var hdbc: Pointer[None] = Pointer[None]
  fun ht(): I16 => 2
  fun ref h(): Pointer[None] => hdbc

  fun apply(): I16 => 2

  new create(he: HandleENV) ? =>
    henv = he
    if (@SQLAllocHandle(2, he.henv, addressof hdbc) != SQLSuccess()) then error end

  fun set_application_name(s: String) ? =>
    if (@SQLSetConnectAttr[I16](hdbc, SQLAttrApplicationName(), s.cstring(), s.size().i32()) != SQLSuccess()) then error end

  fun ref connect(dsn: String) ? =>
    if (@SQLConnect(hdbc, dsn.cstring(), dsn.size().i16(), "".cstring(), 0, "".cstring(), 0) != SQLSuccess()) then error end

  fun ref commit(): SQLReturn  =>
    match @SQLEndTran(2, hdbc, SQLCommit())
    | 0 => return SQLSuccess
    | 1 => return SQLSuccessWithInfo
    | 2 => return SQLStillExecuting
    | -1 => return SQLError(this)
    | -2 => return SQLInvalidHandle
    | 99 => return SQLNeedData
    | 100 => return SQLNoData
    end
    SQLError(this)


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
    SQLError(this)

