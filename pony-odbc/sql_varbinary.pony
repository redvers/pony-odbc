use "debug"

class SQLVarbinary is SQLType
  """
  The internal class which represents a binary blob
  """
  var _v: CBoxedArray = CBoxedArray
  var _err: _SQLReturn val = SQLSuccess

  new create(size: USize) => _v.alloc(size)
    """
    Creates a SQLVarbinary to be used as an input or output buffer.
    """

  fun \nodoc\ ref get_boxed_array(): CBoxedArray => _v
  fun \nodoc\ ref set_boxed_array(v': CBoxedArray) => _v = v'

  fun \nodoc\ ref get_err(): _SQLReturn val => _err
  fun \nodoc\ ref set_err(err': _SQLReturn val) => _err = err'

  fun ref write(str: Array[U8] val): Bool =>
    """
    Write a string to this buffer.  The string MUST fit in
    the defined buffer.

    Will return true if written and verification succeeds.
    
    Will return false if the string is too long for the buffer or
    the readback doesn't match for some other reason.
    """
    _write_array(str)


  fun ref read(): Array[U8] iso^ =>
    """
    Read the value of the buffer into a String iso^. This is an iso^
    copy of the data so the buffer can remain in place and reused
    without rebinding.
    """
    _v.array()
