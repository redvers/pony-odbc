use "debug"
use "stmt"
use "ctypes"
use "attributes"
use "instrumentation"

use @memcpy[Pointer[U8] ref](dest: Pointer[U8] tag, src: Pointer[U8] tag, size: USize)
use @pony_ctx[Pointer[None]]()
use @pony_alloc[Pointer[U8] ref](ctx: Pointer[None], size: USize)
use @explicit_bzero[None](ptr: Pointer[U8] tag, size: USize)


primitive SQLVarcharConsts
  fun sql_nts():         I16 => -3
  fun sql_param_input(): I16 => 1
  fun sql_c_char():      I16 => 1
  fun sql_varchar():     I16 => -1

class SQLVarchar
  """
  The internal class which represents an PostgreSQL text,
  char, varchar, longvarchar etc etc
  """
  var v: CBoxedArray = CBoxedArray
  var err: SQLReturn val = SQLSuccess

  fun ref init(str: String val): Bool =>
    """
    Used almost exclusively for parameters.  Creates a buffer and
    populates it with the provided string
    """
    v.init(str)

  fun ref alloc(size: USize): Bool =>
    """
    Allocates the buffer to be populated by the database when data
    is fetched
    """
    v.alloc(size)

  fun ref reset(): Bool =>
    """
    Zeros the buffer and resets the field that defines the length of
    data written.
    """
    v.reset()

  fun ref string(): String iso^ =>
    """
    Returns the written contents of the buffer as a string
    """
    v.string()

  fun ref native(): String iso^ =>
    """
    Returns the pony-native type.
    """
    v.string()

  fun ref write(str: String val): Bool =>
    """
    Writes the string into the provided buffer. If the string is
    larger than the buffer then it will FAIL, not re-allocate.

    (We can't reallocate, just in case this buffer is already bound
    to a query already)
    """
    if (not v.write(str)) then return false end
    if (str != v.string()) then return false end
    true

  fun \nodoc\ ref bind_parameter(h: ODBCHandleStmt tag, col: U16): SQLReturn val =>
    var desc: SQLDescribeParamOut = SQLDescribeParamOut(col)
    if (not _verify_parameter(h, desc)) then
      return err
    end
    err
    if (not _bind_parameter(h, desc)) then
      return err
    end
    err

  fun \nodoc\ ref _verify_parameter(h: ODBCHandleStmt tag, desc: SQLDescribeParamOut): Bool =>
    err = ODBCStmtFFI.describe_param(h, desc)
    if (not is_success()) then
      return false
    end
    /* List of possible VarChar / Char based types:
     *  1   SQLChar
     *  12  SQLVarchar
     *  -1  SQLLongVarChar
     *  -2  SQLBinary
     *  -3  SQLVarBinary
     *  -4  SQLLongVarBinary
     */

    var dt: I16 = desc.data_type_ptr.value
    match dt
    | 1  => true
    | 12 => true
    | -1 => true
    | -2 => true
    | -3 => true
    | -4 => true
    else
      err = recover val PonyDriverError("SQLVarchar._verify_parameter: Wanted [1,12,-1,-2,-3,-4], got: " + dt.string()) end
      return false
    end

  fun \nodoc\ ref _bind_parameter(h: ODBCHandleStmt tag, desc: SQLDescribeParamOut): Bool =>
    err = ODBCStmtFFI.bind_parameter_varchar(h, desc, v)
    is_success()

  fun \nodoc\ ref bind_column(h: ODBCHandleStmt tag, col: U16, colname: String val): SQLReturn val =>
    var desc: SQLDescribeColOut = SQLDescribeColOut(col)
    if (not _verify_column(h, desc, colname)) then
      return err
    end
    err
    if (not _bind_column(h, desc)) then
      return err
    end
    err

  fun \nodoc\ ref _verify_column(h: ODBCHandleStmt tag, desc: SQLDescribeColOut, colname: String val): Bool =>
    err = ODBCStmtFFI.describe_column(h, desc, colname)
    if (not is_success()) then
      return false
    end

    /* List of possible VarChar / Char based types:
     *  1   SQLChar
     *  12  SQLVarchar
     *  -1  SQLLongVarChar
     *  -2  SQLBinary
     *  -3  SQLVarBinary
     *  -4  SQLLongVarBinary
     */
    var dt: I16 = desc.datatype_ptr.value
    match dt
    | 1  => v.alloc(desc.colsize_ptr.value.usize()); return true
    | 12 => v.alloc(desc.colsize_ptr.value.usize()); return true
    | -1 => v.alloc(desc.colsize_ptr.value.usize()); return true
    | -2 => v.alloc(desc.colsize_ptr.value.usize()); return true
    | -3 => v.alloc(desc.colsize_ptr.value.usize()); return true
    | -4 => v.alloc(desc.colsize_ptr.value.usize()); return true
    else
      err = recover val PonyDriverError("SQLVarchar._verify_column: Wanted [1,12,-1,-2,-3,-4], got: " + dt.string()) end
      return false
    end

  fun \nodoc\ ref _bind_column(h: ODBCHandleStmt tag, desc: SQLDescribeColOut): Bool =>
    err = ODBCStmtFFI.bind_column_varchar(h, desc, v)
    is_success()


  fun \nodoc\ is_success(): Bool =>
    match err
    | let x: SQLSuccess => true
    else
      false
    end
