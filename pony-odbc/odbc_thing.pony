use "dbc"
use "stmt"
use "ctypes"
use "attributes"
use "instrumentation"
class ODBCThing
  var dbc: ODBCDbc
  var sth: ODBCHandleStmt tag
  var err: SQLReturn val
  var parameters: (Array[SQLVarchar] | None) = None
  var columns:    (Array[SQLVarchar] | None) = None

  new create(dbc': ODBCDbc) =>
    (err, sth) = ODBCStmtFFI.alloc(dbc'.dbc)
    dbc = dbc'

  fun ref prepare(str: String val)? =>
    err = ODBCStmtFFI.prepare(sth, str)
    match err
    | let x: SQLSuccess val => None
    else
      error
    end

//  fun ref bind_parameters(params: Array[SQLVarchar]): SQLReturn =>
//    SQLSuccess
  fun ref execute()? =>
    err = ODBCStmtFFI.execute(sth)
    match err
    | let x: SQLSuccess val => None
    else
      error
    end

  fun ref finish()? =>
    err = ODBCStmtFFI.close_cursor(sth)
    match err
    | let x: SQLSuccess val => None
    else
      error
    end

  fun ref bind_parameter(i: SQLType, col: U16)? =>
    i.bind_parameter(sth, col)
    err = i.get_err()
    match err
    | let x: SQLSuccess val => None
    else
      error
    end

  fun ref bind_column(i: SQLType, col: U16)? =>
    i.bind_column(sth, col)
    err = i.get_err()
    match err
    | let x: SQLSuccess val => None
    else
      error
    end

  fun ref rowcount(): I64 ? =>
    var rv: CBoxedI64 = CBoxedI64
    err = ODBCStmtFFI.result_count(sth, rv)
    match err
    | let x: SQLSuccess val => return rv.value
    else
      error
    end

  fun ref fetch() ? =>
    err = ODBCStmtFFI.fetch(sth)
    match err
    | let x: SQLSuccess val => None
    else
      error
    end












interface SQLType
  fun ref bind_parameter(h: ODBCHandleStmt tag, col: U16): SQLReturn val
  fun ref bind_column(h: ODBCHandleStmt tag, col: U16, colname: String val = ""): SQLReturn val
  fun get_err(): SQLReturn val
