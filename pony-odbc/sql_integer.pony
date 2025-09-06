use "debug"
use "stmt"
use "ctypes"
use "attributes"
use "instrumentation"

class SQLInteger
  var v: CBoxedI32 = CBoxedI32
  var is_null: Bool = false
  var err: SQLReturn val = SQLSuccess
  new create(a: I32 = 0) => v.value = a

  fun ref bind_parameter(h: ODBCHandleStmt tag, col: U16): SQLReturn val => SQLSuccess
    var desc: SQLDescribeParamOut = SQLDescribeParamOut(col)
    _verify_parameter(h, desc)
    Debug.out(desc.debug())
//    if (not _verify_parameter(h, desc)) then
//      return err
//    end
    err
    if (not _bind_parameter(h, desc)) then
      return err
    end
    err

  fun ref _bind_parameter(h: ODBCHandleStmt tag, desc: SQLDescribeParamOut): Bool =>
    err = ODBCStmtFFI.bind_parameter_i32(h, desc, v)
    is_success()

  fun ref _verify_parameter(h: ODBCHandleStmt tag, desc: SQLDescribeParamOut): Bool =>
    err = ODBCStmtFFI.describe_param(h, desc)
    if (not is_success()) then
      return false
    end
    match desc.data_type_ptr.value
      // Apparently, mariadb insists on calling this a string - wut?
    | 4  => return true // _bind_parameter(h, desc)
    else
      err = PonyDriverError
      return false
    end

  fun native(): I32 => v.value

  fun is_success(): Bool =>
    match err
    | let x: SQLSuccess => true
    else
      false
    end

  fun ref bind_column(h: ODBCHandleStmt tag, col: U16, colname: String val): SQLReturn val => SQLSuccess
    var desc: SQLDescribeColOut = SQLDescribeColOut(col)
    if (not _verify_column(h, desc, colname)) then
      return err
    end
    err
    if (not _bind_column(h, desc)) then
      return err
    end
    err

  fun ref _verify_column(h: ODBCHandleStmt tag, desc: SQLDescribeColOut, colname: String val): Bool =>
    err = ODBCStmtFFI.describe_column(h, desc, colname)
    if (not is_success()) then
      return false
    end

    /* List of possible Integer types
     *  4   SQLInteger
     */
    match desc.datatype_ptr.value
    | 4  => return true
    else
      err = PonyDriverError
      return false
    end

  fun ref _bind_column(h: ODBCHandleStmt tag, desc: SQLDescribeColOut): Bool =>
    err = ODBCStmtFFI.bind_column_i32(h, desc, v)
    is_success()
    true















