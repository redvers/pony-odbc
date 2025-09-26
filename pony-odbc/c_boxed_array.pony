use "debug"

use @memcpy[Pointer[U8] ref](dest: Pointer[U8] tag, src: Pointer[U8] tag, size: USize)
use @pony_ctx[Pointer[None]]()
use @pony_alloc[Pointer[U8] ref](ctx: Pointer[None], size: USize)
use @explicit_bzero[None](ptr: Pointer[U8] tag, size: USize)


primitive \nodoc\ ODBCVarcharConsts
  fun sql_nts():         I64 => -3
  fun sql_param_input(): I16 => 1
  fun sql_c_char():      I16 => 1
  fun sql_varchar():     I16 => 12
  fun sql_null_data():   I64 => -1

class \nodoc\ CBoxedArray
  var ptr: Pointer[U8] = Pointer[U8]
  var alloc_size: USize = 0
  var written_size: CBoxedI64 = CBoxedI64

  fun ref alloc(size: USize): Bool =>
    if (not ptr.is_null()) then return false end
    ptr = @pony_alloc(@pony_ctx(), size)
    alloc_size = size
    written_size.value = size.i64()
    @explicit_bzero(ptr, size)
    true

  fun ref null() =>
    written_size.value = ODBCVarcharConsts.sql_null_data()

  fun ref is_null(): Bool =>
    if (written_size.value == ODBCVarcharConsts.sql_null_data()) then
      true
    else
      false
    end

  fun ref reset(): Bool =>
    if (ptr.is_null()) then return false end
    @explicit_bzero(ptr, alloc_size)
    written_size.value = alloc_size.i64()
    true

  fun string(): String iso^ =>
    String.copy_cstring(ptr).clone()

  fun ref write(str: String val): Bool =>
    if (ptr.is_null()) then return false end
    if (str.size() > alloc_size) then
      return false
    end
    reset()
    @memcpy(ptr, str.cpointer(), str.size())
    written_size.value = str.size().i64()
    true

  fun ref write_array(arr: Array[U8] val): Bool =>
    if (ptr.is_null()) then return false end
    if (arr.size() > alloc_size) then
      return false
    end
    reset()
    @memcpy(ptr, arr.cpointer(), arr.size())
    written_size.value = arr.size().i64()
    true

  fun array(): Array[U8] iso^ =>
    let written_s: USize = written_size.value.usize()
    let rv: Array[U8] iso = recover iso Array[U8](written_s) end
    @memcpy(rv.cpointer(), ptr, written_size.value.usize())
    consume rv

