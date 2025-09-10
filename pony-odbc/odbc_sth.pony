use "debug"
use "dbc"
use "stmt"
use "ctypes"
use "attributes"
use "instrumentation"


class ODBCSth
  let stmt: ODBCHandleStmt tag
  let tablemodel: ODBCQueryModel
  var err: SQLReturn val
  var valid: Bool = false
  /*
   * We store a PgDbc tag to ensure we don't have the PgDbc GC
   * before this PgSth.  That would be "bad"™
   */
  let dbc: ODBCDbc tag

  new create(dbc': ODBCDbc, qm: ODBCQueryModel iso = ODBCQueryModelNull) =>
    dbc = dbc'
    (err, stmt) = ODBCStmtFFI.alloc(dbc'.dbc)
    tablemodel = consume qm
    _set_valid(err)

  fun ref exec_direct(query: String val): Bool =>
    err = ODBCStmtFFI.exec_direct(stmt, query)
    if (not _set_valid(err)) then return false end
    true

  fun ref prepare(): Bool =>
    """
    Prepares your SQL statement for the database
    """
    match tablemodel.sql()
    | let x: String val => err = ODBCStmtFFI.prepare(stmt, x)
    | let x: SQLReturn val => err = x
    end
    if (not _set_valid(err)) then return false end
    if (not _bind_params()) then return false end
    if (not _bind_columns()) then return false end
    true

  fun \nodoc\ ref _bind_params(): Bool =>
    """
    Binds the provided parameters to your query
    """
    err = tablemodel.bind_params(stmt)
    _set_valid(err)

  fun \nodoc\ ref _bind_columns(): Bool =>
    """
    Binds the columns to your parameters
    """
    err = tablemodel.bind_columns(stmt)
    _set_valid(err)

  fun ref execute[A: Any val](i: A): Bool =>
    """
    Executes your query
    """
    err = tablemodel.execute[A](stmt, i)
    if (not _set_valid(err)) then return false end
    err = ODBCStmtFFI.execute(stmt)
    if (not _set_valid(err)) then return false end
    true

  fun ref fetch(): (Bool, ODBCResultOut) =>
    """
    Attempts to fetch a row of data and populate the provided
    buffers
    """
    (err, var r: ODBCResultOut) = tablemodel.fetch(stmt)
    (_set_valid(err), r)

  fun ref result_count(): (Bool, USize) =>
    """
    Returns the number of rows for the current executed query.
    
    NOTE - The standard says drivers are allowed to lie
    """
    var cnt: CBoxedI64 = CBoxedI64
    err = ODBCStmtFFI.result_count(stmt, cnt)
    (_set_valid(err), cnt.value.usize())

  fun ref finish(): Bool =>
    """
    Closes the active cursor on a query so it can be reexecuted
    with potentially new parameters.
    """
    err = ODBCStmtFFI.close_cursor(stmt)
    _set_valid(err)


  fun \nodoc\ is_valid(): Bool => valid

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => valid = true ; return true
    | let x: SQLSuccessWithInfo val => valid = true ; return true
    else
      valid = false ; return false
    end

  fun _final() =>
    ODBCStmtFFI.free(stmt)

