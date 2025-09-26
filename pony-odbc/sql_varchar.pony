use "debug"

class SQLVarchar is SQLType
  """
  The internal class which represents a CHAR, VARCHAR, or TEXT
  """
  var _v: CBoxedArray = CBoxedArray
  var _err: SQLReturn val = SQLSuccess

  new create(size: USize) => _v.alloc(size)
    """
    Creates a SQLVarchar to be used as an input or output buffer.
    """

  fun \nodoc\ ref get_boxed_array(): CBoxedArray => _v
  fun \nodoc\ ref set_boxed_array(v': CBoxedArray) => _v = v'

  fun \nodoc\ ref get_err(): SQLReturn val => _err
  fun \nodoc\ ref set_err(err': SQLReturn val) => _err = err'

  fun ref write(str: String val): Bool =>
    """
    Write a string to this buffer.  The string MUST fit in
    the defined buffer.

    Will return true if written and verification succeeds.
    
    Will return false if the string is too long for the buffer or
    the readback doesn't match for some other reason.
    """
    _write(str)


  fun ref read(): String iso^ ? =>
    """
    Read the value of the buffer into a String iso^. This is an iso^
    copy of the data so the buffer can remain in place and reused
    without rebinding.
    """
    if (get_boxed_array().is_null()) then
      error
    else
      _v.string()
    end
