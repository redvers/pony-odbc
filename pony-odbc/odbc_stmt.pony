use "ffi"
use "debug"

struct \nodoc\ ODBCHandleStmt

class ODBCStmt is SqlState
  """
  A simple API for performing SQL queries using ODBC for maximum portability.

  This is a *synchronous* API so its use should bear that in mind. An
  asynchronous API will follow later.

  ## Prerequisites

  This API handles queries. Before you can execute a query, you need to
  connect to a database. Before you can connect to a database, you need an
  Environment.

  See the documentation of ODBCDbc and ODBCEnv for more detail one what
  these two objects are and how they are used. The example below is
  barebones for those objects.

  ## Usage

  The simplest case is when your query doesn't take any parameters or
  return a data set.  For example, a table creation.  In this case,
  we can simply prepare the statement and directly execute it:

  ```pony
  var stm: ODBCStmt = dbc.stmt()?

  stm
    .> prepare("create table demotable (myint integer unique, mystr varchar(400))")?
    .> execute()?
  ```

  ### Inserting Data

  In order to insert data into this table we prepare the `insert into` SQL
  statement and provide the values (parameters) to be inserted into the
  columns, later. In our statement, we use `?` as placeholders for these
  values:

  ```pony
  stm
    .> prepare("insert into demotable (myint, mystr) values (?,?)")?
  ```

  A prepared statement can be executed any number of times, but each
  execution will likely have different values to be populated for each row.

  So before we can pass values to our prepared statement, we have to
  create pony objects to represent them. In our table above we have
  a SQLInteger (I32), and a SQLVarchar(400). For some types we have to
  specify the size of the buffer, for others such as SQLInteger, we
  don't as their sizes are known.

  ```pony
  var myint: SQLInteger = SQLInteger
  var mystr: SQLVarchar = SQLVarchar(400)
  ```

  NOTE: If your buffer is too small, your statement will fail.

  Once defined we bind them to the correct parameter by adding them
  in order:

  ```pony
  stm.bind_parameter(myint)?
  stm.bind_parameter(mystr)?
  ```

  The prepared statement can now be executed any number of times. In this
  example we'll execute it ten times:

  ```
  for cnt in Range[I32](1,10) do
    myint.write(cnt)
    mystr.write("This is a string with a number: " + cnt.string())

    stm.execute()?
  end
  ```

  ### Querying Data

  In order to query data, we `prepare` and `bind_parameters` as before:

  ```pony
  var intin: SQLInteger = SQLInteger
  stm
    .> prepare("select myint, mystr from demotable where myint > ?")?
    .> bind_parameter(intin)?
  ```

  But we also need to provide buffers for output:

  ```pony
  var intout: SQLInteger = SQLInteger
  var strout: SQLVarchar = SQLVarchar(400)

  stm
    .> bind_column(intout)?
    .> bind_column(strout)?
  ```

  Once these buffers are all allocated, we can execute our query:

  ```pony
  intin.write(8)
  while (stm.fetch_scroll(SqlFetchNext)?) do
    Debug.out("myint: " + intout.read()?.string() +
              "mystr: " + strout.read())
  end
  ```

  ## Handling Errors

  In this API, we use partial functions in all our functions to indicate
  if a call failed. If a call failed, we can determine why by examining
  the contents of the field errtext.

  ## Notes

  Some rough edges:
    - This is a synchronous API. This could cause you problems. It is however
      a prerequisite for an asynchronous API which is better suited to pony.
    - The API is likely to change.
  """

  let _dbc: ODBCDbc
  let _created_epoch: USize
  var _sth: ODBCHandleStmt tag = ODBCHandleStmt
  var _err: SQLReturn val = SQLSuccess
  var _parameters: Array[SQLType] = Array[SQLType]
  var _columns:    Array[SQLType] = Array[SQLType]
  var strict: Bool = true

  var _call_location: SourceLoc val = __loc
  var _error_chain: ODBCErrorChain = ODBCErrorChain
  var _last_sql: (String val | None) = None

  new \nodoc\ create(dbc': ODBCDbc, sl: SourceLoc val = __loc) =>
    _dbc = dbc'
    _created_epoch = dbc'.connection_epoch()
    _call_location = sl

  fun ref alloc(): SQLReturn val =>
    var sthwrapper: StmtWrapper = StmtWrapper
    _err = ODBCFFI.resolve(ODBCFFI.pSQLAllocHandle_stmt(_dbc.dbc, sthwrapper))
    _sth = sthwrapper.value
    _err

  fun sqlstates(): Array[(String val, String val)] val =>
    """
    Returns an array of SQL States.
    """
    _from_stmt(_sth)

  fun ref prepare(str: String val, sl: SourceLoc val = __loc): Bool ? =>
    """
    Used to 'prepare' a SQL statement.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _parameters.clear()
    _columns.clear()
    if _error_chain.auto_clear() then
      _error_chain.clear()
    end
    _last_sql = str
    _err = ODBCFFI.resolve(ODBCFFI.pSQLPrepare(_sth, str, str.size().i32()))
    _check_valid("prepare", str)?

  fun ref bind_parameter(i: SQLType, sl: SourceLoc val = __loc): Bool ? =>
    """
    Used to bind a parameter to a prepared query.

    All parameters in this API are passed via SQLType objects. This object
    represents a textual buffer.  You must allocate sufficient space in this
    buffer *before* you bind it to a column.

    Parameters must be bound in order.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _parameters.push(i)
    i.bind_parameter(_sth, _parameters.size().u16())
    _err = i.get_err()
    _check_valid("bind_parameter")?

  fun ref bind_column(i: SQLType, sl: SourceLoc val = __loc): Bool ? =>
    """
    Used to bind a column in a result-set for the prepared query.

    All columns in this API are received via SQLType objects. This object
    represents a textual buffer. For efficiency reasons you should allocate
    sufficient space in this buffer *before* you bind it to a column.

    "Should", because this API will resize a buffer if it determines that
    the buffer was insufficiently sized.

    Columns must be bound in order.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _columns.push(i)
    i.bind_column(_sth, _columns.size().u16())
    _err = i.get_err()
    _check_valid("bind_column")?

  fun ref execute(sl: SourceLoc val = __loc): Bool ? =>
    """
    Before executing your prepared command you should populate your
    parameters with the necessary data.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(ODBCFFI.pSQLExecute(_sth))
    _check_valid("execute", _last_sql)?

  fun ref direct_exec(statement: String val, sl: SourceLoc val = __loc): Bool ? =>
    """
    Directly executes the provided statement.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _last_sql = statement
    _err = ODBCFFI.resolve(ODBCFFI.pSQLExecDirect(_sth, statement, statement.size().i32()))
    _check_valid("direct_exec", statement)?

  fun ref rowcount(sl: SourceLoc val = __loc): I64 ? =>
    """
    *Warning*: The ODBC standard does not mandate this function's correctness.

    This call should return the number of affected rows.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    var rv: CBoxedI64 = CBoxedI64
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLRowCount(_sth, rv))
    _check_valid("rowcount")?
    rv.value

  fun ref num_result_cols(rv: CBoxedI16, sl: SourceLoc val = __loc): Bool ? =>
    """
    *Warning*: The ODBC standard does not mandate this function's correctness.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLNumResultCols(_sth, rv))
    _check_valid("num_result_cols")?

  fun ref get_type_info(sqltype: I16 = 0 ,sl: SourceLoc = __loc): Bool ? => // SQL_ALL_TYPES
    """
    Calls the ODBC API SQLGetTypeInfo. If you don't provide a type ID
    it will default to SQL_ALL_TYPES.

    After executing this you will need to bind columns and use fetch
    to fetch the data.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLGetTypeInfo(_sth, sqltype)
    )
    _check_valid("get_type_info")?

  fun ref columns(catalog: String val = "", schema: String val = "", table: String val = "", column: String val = "", sl: SourceLoc = __loc): Bool ? =>
    """
    See the ODBC API documentation for SQLColumns for a full description.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLColumns(
        _sth,
        if (catalog == "") then Pointer[U8] else catalog.cstring() end,
        -3,
        if (schema == "") then Pointer[U8] else schema.cstring() end,
        -3,
        if (table == "") then Pointer[U8] else table.cstring() end,
        -3,
        if (column == "") then Pointer[U8] else column.cstring() end,
        -3
        )
      )
    _check_valid("columns")?

  fun ref tables(catalog: String val = "", schema: String val = "", table: String val = "", tabletype: String val = "", sl: SourceLoc = __loc): Bool ? =>
    """
    See the ODBC API documentation for SQLTables for a full description.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLTables(
        _sth,
        if (catalog == "") then Pointer[U8] else catalog.cstring() end,
        -3,
        if (schema == "") then Pointer[U8] else schema.cstring() end,
        -3,
        if (table == "") then Pointer[U8] else table.cstring() end,
        -3,
        if (tabletype == "") then Pointer[U8] else tabletype.cstring() end,
        -3
        )
      )
    _check_valid("tables")?

  fun ref get_data(column: U16, sqltype: SQLType, sl: SourceLoc val = __loc): Bool ? =>
    """
    See SQLGetData for more information.

    This is used if you decide to read data directly as opposed to
    binding columns and populating buffers automatically. The main
    reason to choose this approach is for huge columns or if you
    need more direct control.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLGetData(
        _sth,
        column,
        ODBCVarcharConsts.sql_c_char(),
        sqltype.get_boxed_array().ptr,
        sqltype.get_boxed_array().alloc_size.i64(),
        sqltype.get_boxed_array().written_size
      )
    )
    _check_valid("get_data")?

  fun ref fetch(sl: SourceLoc val = __loc): Bool ? =>
    """
    Fetches a row of data from the result set.

    This function returns `true` is there are more rows, `false` if this
    was the last row in the set.
    """
    fetch_scroll(SqlFetchNext, 0, sl)?

  fun ref fetch_scroll(d: SqlFetchOrientation = SqlFetchNext, offset: I64 = 0, sl: SourceLoc val = __loc): Bool ? =>
    """
    This function causes the ODBC driver to populate your buffers with the
    specified row of your result set. The default behaviour SqlFetchNext,
    the next row in your result set.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.

    This function returns `true` is there are more rows, `false` if this
    was the last row in the set.
    """
    _call_location = sl
    _err = ODBCFFI.resolve(
      ODBCFFI.pSQLFetchScroll(_sth, d(), offset))

    match _err
    | let x: SQLSuccess val =>
      _record_success("fetch_scroll")
      _check_and_expand_column_buffers()?
      true
    | let x: SQLSuccessWithInfo val =>
      _record_success("fetch_scroll")
      _check_and_expand_column_buffers()?
      true
    | let x: SQLNoData val => false
    else
      _capture_error("fetch_scroll")
      error
    end


  fun ref finish(sl: SourceLoc val = __loc): Bool ? =>
    """
    Closes the result-set using SQLFreeStmt.
    """
    _call_location = sl
    _parameters.clear()
    _columns.clear()
    if _error_chain.auto_clear() then
      _error_chain.clear()
    end
    _last_sql = None
    _err = ODBCFFI.resolve(ODBCFFI.pSQLFreeStmt(_sth, 0))
    _check_valid("finish")?

  fun \nodoc\ ref _check_and_expand_column_buffers(sl: SourceLoc val = __loc) ? =>
    _call_location = sl
    for (colindex, vc) in _columns.pairs() do
      let ws = vc.get_boxed_array().written_size.value
      if (ws > 0) and (ws.usize() > vc.get_boxed_array().alloc_size) then
        _err = vc.realloc_column(_sth, vc.get_boxed_array().written_size.value.usize() + 10, colindex.u16() + 1)
        _check_valid("realloc_column")?

        var ba: CBoxedArray = vc.get_boxed_array()
        _err = ODBCFFI.resolve(
          ODBCFFI.pSQLGetData(_sth, colindex.u16() + 1, 1, ba.ptr, ba.alloc_size.i64(), ba.written_size))
        _check_valid("get_data")?
      end
    end

  // Used to do introspection during testing
  fun \nodoc\ get_err(): SQLReturn val => _err

  fun ref _capture_error(operation: String val, sql: (String val | None) = None) =>
    """
    Capture the current error state into the error chain.
    Called before throwing an error.
    """
    let diags = sqlstates()
    let frame = ODBCErrorFrame(
      operation,
      _call_location,
      _err,
      diags,
      _error_chain.next_sequence(),
      sql,
      "stmt",
      false
    )
    _error_chain.push(frame)

  fun ref _record_success(operation: String val, sql: (String val | None) = None) =>
    """
    Record a successful operation if log_success is enabled.
    """
    if _error_chain.log_success() then
      let frame = ODBCErrorFrame(
        operation,
        _call_location,
        _err,
        recover val Array[(String val, String val)] end,
        _error_chain.next_sequence(),
        sql,
        "stmt",
        true
      )
      _error_chain.push(frame)
    end

  fun \nodoc\ ref _check_valid(operation: String val = "", sql: (String val | None) = None): Bool ? =>
    if strict then
      match _err
      | let x: SQLSuccess val =>
        _record_success(operation, sql)
        return true
      else
        _capture_error(operation, sql)
        error
      end
    else
      match _err
      | let x: SQLSuccess val =>
        _record_success(operation, sql)
        return true
      | let x: SQLSuccessWithInfo val =>
        _record_success(operation, sql)
        return true
      else
        _capture_error(operation, sql)
        error
      end
    end

  fun error_chain(): ODBCErrorChain box =>
    """
    Access the error chain for inspection.
    """
    _error_chain

  fun last_error(): (ODBCErrorFrame val | None) =>
    """
    Convenience method: get the most recent error frame.
    """
    _error_chain.last()

  fun ref configure_error_chain(
    max_frames: USize = 100,
    auto_clear: Bool = true,
    log_success: Bool = false
  ) =>
    """
    Configure error chain behavior.

    - max_frames: Maximum number of frames to store (default: 100)
    - auto_clear: Clear chain on prepare()/finish() (default: true)
    - log_success: Also record successful operations (default: false)
    """
    _error_chain.set_max_frames(max_frames)
    _error_chain.set_auto_clear(auto_clear)
    _error_chain.set_log_success(log_success)

  fun get_sth(): ODBCHandleStmt tag => _sth

  fun _final() =>
    // Only free the statement handle if:
    // 1. The connection is still connected, AND
    // 2. The connection hasn't been reconnected since this statement was created
    // If either condition is false, the statement handle is already invalid.
    if _dbc.is_connected() and (_dbc.connection_epoch() == _created_epoch) then
      ODBCFFI.pSQLFreeHandle_stmt(_sth)
    end
