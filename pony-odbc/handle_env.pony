use @SQLSetEnvAttr[I16](henv: Pointer[None] tag, attr: I32, v: I32, sl: I32)
use @SQLGetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)

use "debug"
class HandleENV
  var henv: Pointer[None] = Pointer[None]
  fun ht(): I16 => 1
  fun ref h(): Pointer[None] => henv

  fun apply(): I16 => 1

  new create() ? =>
    if (@SQLAllocHandle(1, Pointer[None], addressof henv) != SQLSuccess()) then error end
  fun set_odbc2() ? =>
    if (@SQLSetEnvAttr(henv, SQLAttrOdbcVersion(), SQLAttrOvOdbc2(), SQLIsInteger()) != SQLSuccess()) then error end
  fun set_odbc3() ? =>
    if (@SQLSetEnvAttr(henv, SQLAttrOdbcVersion(), SQLAttrOvOdbc3(), SQLIsInteger()) != SQLSuccess()) then error end

  fun dispose() =>
    @SQLFreeHandle(1, henv)

  fun _final() =>
    @SQLFreeHandle(1, henv)

