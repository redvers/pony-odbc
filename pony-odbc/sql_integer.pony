use "debug"
use "stmt"
use "ctypes"
use "attributes"
use "instrumentation"

class SQLInteger
  var v: CBoxedArray = CBoxedArray.>alloc(32)
  var is_null: Bool = false
  var err: SQLReturn val = SQLSuccess
  new create(a: I32 = 0) =>
    v.write(a.string())

  fun ref bind_parameter(h: ODBCHandleStmt tag, col: U16): SQLReturn val => SQLSuccess
    var desc: SQLDescribeParamOut = SQLDescribeParamOut(col)
    if (not _bind_parameter(h, desc)) then
      return err
    end
    err

  fun ref _bind_parameter(h: ODBCHandleStmt tag, desc: SQLDescribeParamOut): Bool =>
    err = ODBCStmtFFI.bind_parameter_varchar(h, desc, v)
    is_success()

  fun read(): I32 ? =>
    v.string().i32()?

  fun is_success(): Bool =>
    match err
    | let x: SQLSuccess => true
    else
      false
    end

  fun ref bind_column(h: ODBCHandleStmt tag, col: U16, colname: String val = ""): SQLReturn val => SQLSuccess
    if (not _bind_column(h, col)) then
      return err
    end
    err

  fun ref _bind_column(h: ODBCHandleStmt tag, col: U16): Bool =>
    err = ODBCStmtFFI.bind_column_varchar(h, col, v)
    is_success()
    true

  fun ref write(a: I32) =>
    v.write(a.string())

  fun get_err(): SQLReturn val => err











