use "debug"

class SQLReal is SQLType
  """
  The internal class which represents an Integer (F32)
  """
  var _v: CBoxedArray = CBoxedArray
  var _err: SQLReturn val = SQLSuccess

  new create() => _v.alloc(30)

  fun \nodoc\ ref get_boxed_array(): CBoxedArray => _v
  fun \nodoc\ ref set_boxed_array(v': CBoxedArray) => _v = v'

  fun \nodoc\ ref get_err(): SQLReturn val => _err
  fun \nodoc\ ref set_err(err': SQLReturn val) => _err = err'

  fun ref write(f64: F64): Bool =>
    """
    Write an F64 to this buffer as a string. The string will fit
    as we defined the buffer to be characters on initialization.

    Will return true if written and verification succeeds.

    Will return false if the string is too long for the buffer or
    the readback doesn't match for some other reason.
    """
    _write(f64.string())

  fun ref read(): F64 ? =>
    """
    Read the value of the buffer and convert it into an F64.
    
    This function is partial just in case the string version
    that comes from the database is not within the F64 range.

    NOTE: SQLite does not enforce type limits, so if you use
    that specific ODBC driver, this is something that must be
    verified.
    """
    _v.string().f64()?
