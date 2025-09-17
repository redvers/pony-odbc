use @SQLGetDiagRec[I16](HandleType: I16, Handle: Pointer[None] tag, RecNumber: I16, _Sqlstate: Pointer[U8] tag, NativeError: Pointer[I32] tag, MessageText: Pointer[U8] tag, BufferLength: I16, TextLength: Pointer[I16] tag)

use "debug"

class \nodoc\ SQLDiagFrame
  var handle_type: I16 = 0
  var handle: Pointer[None] = Pointer[None]
  var recnum: I16 = 0
  var sqlstate: String ref = ".".mul(5)
  var nativeerrptr: I32 = 0
  var msgbuff: String ref = ".".mul(4096)
  var textlen: I16 = 0

  fun rec_tuple(): (I16, String val, String val) =>
    (recnum, sqlstate.clone(), msgbuff.clone())

  fun recstring(): String val =>
    "[" +
    match handle_type
    | 1 => "ENV"
    | 2 => "DBC"
    | 3 => "STM"
    else
      "Unknown:" + handle_type.string()
    end
    + "]["
    + sqlstate
    + "]: "
    + msgbuff

    /*
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

    if (s != 0) then error end
    */

  new create_penv(htype: ODBCHandleEnv tag, num: I16)? =>
    let s: I16 = @SQLGetDiagRec(
          1,
          NullablePointer[ODBCHandleEnv tag](htype),
          num,
          sqlstate.cstring(),
          addressof nativeerrptr,
          msgbuff.cstring(),
          msgbuff.size().i16(),
          addressof textlen)

    handle_type = 1
    msgbuff.recalc()

    if (s != 0) then error end

  new create_pdbc(htype: ODBCHandleDbc tag, num: I16)? =>
    let s: I16 = @SQLGetDiagRec(
          2,
          NullablePointer[ODBCHandleDbc tag](htype),
          num,
          sqlstate.cstring(),
          addressof nativeerrptr,
          msgbuff.cstring(),
          msgbuff.size().i16(),
          addressof textlen)

    handle_type = 2
    msgbuff.recalc()

    if (s != 0) then error end

  new create_pstmt(htype: ODBCHandleStmt tag, num: I16)? =>
    let s: I16 = @SQLGetDiagRec(
          3,
          NullablePointer[ODBCHandleStmt tag](htype),
          num,
          sqlstate.cstring(),
          addressof nativeerrptr,
          msgbuff.cstring(),
          msgbuff.size().i16(),
          addressof textlen)

    handle_type = 3
    msgbuff.recalc()

    if (s != 0) then error end

