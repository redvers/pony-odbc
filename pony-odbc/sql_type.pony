use "ffi"
use "debug"

trait SQLType
  """
  The most portable implementation of ODBC when reading and writing across
  the various database vendors has been as textual data via a buffer.

  Given this, we have implemented our SQL Datatypes in two halves - a
  "front-end" class, and this back-end SQLType.

  This class is responsible for allocating, binding, reallocating,
  reading, and writing the buffers with the database.

  The front-end class is responsible for translating the data to and
  from the native pony datatype.

  You should only need to refer to this trait if you are implementing
  a missing SQL datatype.

  ## Implemented ODBC Types:

  * SQLBigInteger
  * SQLFloat
  * SQLInteger
  * SQLReal
  * SQLSmallInteger
  * SQLVarchar
  """

  fun \nodoc\ ref get_boxed_array(): CBoxedArray
  fun \nodoc\ ref set_boxed_array(v: CBoxedArray)

  fun \nodoc\ ref get_err(): SQLReturn val
  fun \nodoc\ ref set_err(err: SQLReturn val)

  fun \nodoc\ ref alloc(size: USize): Bool =>
    get_boxed_array().alloc(size)

  fun \nodoc\ ref null() =>
    get_boxed_array().null()

  fun \nodoc\ ref reset(): Bool =>
    """
    Zeros the buffer and resets the field that defines the length of
    data written.
    """
    get_boxed_array().reset()

  fun \nodoc\ ref string(): String iso^ =>
    """
    Returns the written contents of the buffer as a string
    """
    get_boxed_array().string()

  fun \nodoc\ ref array(): Array[U8] iso^ =>
    """
    Returns the written contents of the buffer as an array.
    """
    get_boxed_array().array()

  fun \nodoc\ ref _write(str: String val): Bool =>
    """
    Writes the string into the provided buffer. If the string is
    larger than the buffer then it will FAIL, not re-allocate.

    (We can't reallocate, just in case this buffer is already bound
    to a query already)
    """
    if (not get_boxed_array().write(str)) then return false end
    if (str != get_boxed_array().string()) then return false end
    true

  fun \nodoc\ ref _write_array(arr: Array[U8] val): Bool =>
    """
    Writes the string into the provided buffer. If the string is
    larger than the buffer then it will FAIL, not re-allocate.

    (We can't reallocate, just in case this buffer is already bound
    to a query already)
    """
    if (not get_boxed_array().write_array(arr)) then return false end
    true

  fun \nodoc\ ref bind_parameter(h: ODBCHandleStmt tag, col: U16): SQLReturn val =>
    if (not _bind_parameter(h, col)) then
      return get_err()
    end
    get_err()

  fun \nodoc\ ref _bind_parameter(h: ODBCHandleStmt tag, col: U16): Bool =>
    var ba: CBoxedArray = get_boxed_array()
    set_err(
      ODBCFFI.resolve(
        ODBCFFI.pSQLBindParameter_varchar(
          h,
          col,
          1,
          1,
          -1,
          ba.alloc_size.u64(),
          0,
          ba.ptr,
          ba.alloc_size.i64(),
          ba.written_size)
      )
    )
    is_success()

  fun \nodoc\ ref is_success(): Bool =>
    match get_err()
    | let x: SQLSuccess => true
    else
      false
    end

  fun \nodoc\ ref realloc_column(h: ODBCHandleStmt tag, size: USize, col: U16): SQLReturn val =>
    """
    Reallocates the buffer to be populated by the database when data
    is fetched and rebinds the new buffer to the column.
    """
    set_boxed_array(CBoxedArray .> alloc(size))
    bind_column(h, col)

  fun \nodoc\ ref bind_column(h: ODBCHandleStmt tag, col: U16): SQLReturn val =>
    if (not _bind_column(h, col)) then
      return get_err()
    end
    get_err()

  fun \nodoc\ ref _bind_column(h: ODBCHandleStmt tag, col: U16): Bool =>
    var ba: CBoxedArray = get_boxed_array()
    set_err(
      ODBCFFI.resolve(
        ODBCFFI.pSQLBindCol_varchar(h, col, 1, ba.ptr, ba.alloc_size.i64(), ba.written_size)))
    is_success()

  fun \nodoc\ ref is_null(): Bool =>
    get_boxed_array().is_null()
