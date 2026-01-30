use "debug"

class SQLSmallInteger is SQLType
  """
  The internal class which represents an Integer (I16)
  """
  var _v: CBoxedArray = CBoxedArray
  var _err: SQLReturn val = SQLSuccess

  new create() => _v.alloc(8)

  fun \nodoc\ ref get_boxed_array(): CBoxedArray => _v
  fun \nodoc\ ref set_boxed_array(v': CBoxedArray) => _v = v'

  fun \nodoc\ ref get_err(): SQLReturn val => _err
  fun \nodoc\ ref set_err(err': SQLReturn val) => _err = err'

  fun ref write(i16: I16): Bool =>
    """
    Write an I16 to this buffer as a string. The string will fit
    as we defined the buffer to be characters on initialization.

    Will return true if written and verification succeeds.

    Will return false if the string is too long for the buffer or
    the readback doesn't match for some other reason.
    """
    _write(i16.string())

  fun ref read(): I16 ? =>
    """
    Read the value of the buffer and convert it into an I16.
    
    This function is partial just in case the string version
    that comes from the database is not within the I16 range.

    NOTE: SQLite does not enforce type limits, so if you use
    that specific ODBC driver, this is something that must be
    verified.
    """
    _v.string()?.i16()?
