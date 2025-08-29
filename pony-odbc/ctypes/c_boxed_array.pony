use "debug"
use ".."

use @memcpy[Pointer[U8] ref](dest: Pointer[U8] tag, src: Pointer[U8] tag, size: USize)
use @pony_ctx[Pointer[None]]()
use @pony_alloc[Pointer[U8] ref](ctx: Pointer[None], size: USize)

struct CBoxedArray
  var buffer: Pointer[U8] ref
  var buffersize: USize
  var writtensize: I64   = 0

  new create(buffersize': USize = 4096) =>
    buffersize = buffersize'
    buffer = @pony_alloc(@pony_ctx(), buffersize)

  fun string(): String iso^ ? =>
    Debug.out("Written: " + writtensize.string() + ", Buffer: " + buffersize.string())
    if (writtensize.usize() <= buffersize) then
      let rv: String iso = recover iso "!".mul(writtensize.usize()) end
      @memcpy(rv.cpointer(), buffer, writtensize.usize())
      rv.recalc()
      return consume rv
    end
    error

  fun array(): Array[U8] iso^ ? =>
    if (writtensize.usize() <= buffersize) then
      let rv: Array[U8] iso = recover iso Array[U8].init(0, writtensize.usize()) end
      @memcpy(rv.cpointer(), buffer, writtensize.usize())
      rv.truncate(writtensize.usize())
      return consume rv
    end
    error

  fun string_or_null(): (String iso^ | SQLNullData) ? =>
    if (writtensize == SQLNullData()) then return SQLNullData end // SQL_NULL_DATA
      Debug.out("Written: " + writtensize.string() + ", Vuffer: " + buffersize.string())
    if (writtensize.usize() <= buffersize) then
      let rv: String iso = recover iso "!".mul(writtensize.usize()) end
      @memcpy(rv.cpointer(), buffer, writtensize.usize())
      rv.recalc()
      return consume rv
    end
    error

  fun array_or_null(): (Array[U8] iso^ | SQLNullData) ? =>
    if (writtensize == SQLNullData()) then return SQLNullData end // SQL_NULL_DATA
    if (writtensize.usize() <= buffersize) then
      let rv: Array[U8] iso = recover iso Array[U8].init(0, writtensize.usize()) end
      @memcpy(rv.cpointer(), buffer, writtensize.usize())
      rv.truncate(writtensize.usize())
      return consume rv
    end
    error

  fun sizeof(): I64 =>
    """
    In every other CBoxed struct, it's the size of the struct.
    This is a special case as this is the size of the allocated buffer.
    """
    buffersize.i64()

