use @SQLGetDiagRec[I16](HandleType: I16, Handle: Pointer[None] tag, RecNumber: I16, Sqlstate: Pointer[U8] tag, NativeError: Pointer[I32] tag, MessageText: Pointer[U8] tag, BufferLength: I16, TextLength: Pointer[I16] tag)

use "debug"

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


