use "debug"
use "stmt"
use "ctypes"
use "attributes"
use "instrumentation"

class SQLSmallInt
  var v: CBoxedArray = CBoxedArray.>alloc(32)
  var is_null: Bool = false
  var err: SQLReturn val = SQLSuccess
  new create(a: I16 = 0) =>
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

  fun read(): I16 ? =>
    v.string().i16()?

  fun is_success(): Bool =>
    match err
    | let x: SQLSuccess => true
    else
      false
    end

  fun ref bind_column(h: ODBCHandleStmt tag, col: U16, colname: String val): SQLReturn val => SQLSuccess
    var desc: SQLDescribeColOut = SQLDescribeColOut(col)
    if (not _bind_column(h, desc)) then
      return err
    end
    err

  fun ref _bind_column(h: ODBCHandleStmt tag, desc: SQLDescribeColOut): Bool =>
    err = ODBCStmtFFI.bind_column_varchar(h, desc, v)
    is_success()
    true

  fun ref write(a: I16) =>
    v.write(a.string())













