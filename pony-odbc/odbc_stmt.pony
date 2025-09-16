use "debug"

class ODBCStmt
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
  var stm: ODBCStmt = ODBCStmt(dbc)

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

  var _dbc: ODBCDbc
  var _sth: ODBCHandleStmt tag
  var _err: _SQLReturn val
  var _parameters: Array[SQLType] = Array[SQLType]
  var _columns:    Array[SQLType] = Array[SQLType]

  var errtext: String val = ""
  var latest_sqlstate: String val = ""

  var _call_location: SourceLoc val = __loc

  new create(dbc': ODBCDbc, sl: SourceLoc val = __loc) =>
    """
    This constructor creates a new ODBCStmt instance which represents in the
    ODBC API an abstraction of an ODBC Statement Handle.

    These handles can be recycled.
    """
    _call_location = sl
    (_err, _sth) = ODBCStmtFFI.alloc(dbc'.dbc)
    _dbc = dbc'

  fun ref prepare(str: String val, sl: SourceLoc val = __loc)? =>
    """
    Used to 'prepare' a SQL statement.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _parameters.clear()
    _columns.clear()
    _err = ODBCStmtFFI.prepare(_sth, str)
    match _err
    | let x: SQLSuccess val => None
    | let x: SQLError val => _set_error_text(x) ; error
    else
      error
    end

  fun ref bind_parameter(i: SQLType, sl: SourceLoc val = __loc)? =>
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
    match _err
    | let x: SQLSuccess val => None
    | let x: SQLError val => _set_error_text(x) ; error
    else
      error
    end

  fun ref bind_column(i: SQLType, sl: SourceLoc val = __loc)? =>
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
    match _err
    | let x: SQLSuccess val => None
    else
      error
    end

  fun ref execute(sl: SourceLoc val = __loc)? =>
    """
    Before executing your prepared command you should populate your
    parameters with the necessary data.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    _err = ODBCStmtFFI.execute(_sth)
    match _err
    | let x: SQLSuccess val => None
    | let x: SQLError val => _set_error_text(x) ; error
    else
      error
    end

  fun ref rowcount(sl: SourceLoc val = __loc): I64 ? =>
    """
    *Warning*: The ODBC standard does not mandate this function's correctness.

    This call should return the number of affected rows.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    _call_location = sl
    var rv: CBoxedI64 = CBoxedI64
    _err = ODBCStmtFFI.result_count(_sth, rv)
    match _err
    | let x: SQLSuccess val => return rv.value
    | let x: SQLError val => _set_error_text(x) ; error
    else
      error
    end

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
    _err = ODBCStmtFFI.fetch_scroll(_sth, d, offset)
    match _err
    | let x: SQLSuccess val => true
    | let x: SQLSuccessWithInfo val => _check_and_expand_column_buffers()?; true
    | let x: SQLNoData val => false
    | let x: SQLError val => _set_error_text(x) ; error
    else
      error
    end


  fun ref finish(sl: SourceLoc val = __loc)? =>
    """
    Closes the cursor on a result-set.

    Whether it should be used is database dependent
    """
    _call_location = sl
    _err = ODBCStmtFFI.close_cursor(_sth)
    match _err
    | let x: SQLSuccess val => None
    | let x: SQLError val => _set_error_text(x) ; error
    else
      error
    end

  fun ref _check_and_expand_column_buffers(sl: SourceLoc val = __loc) ? =>
    _call_location = sl
    for (colindex, vc) in _columns.pairs() do
      if (vc.get_boxed_array().written_size.value.usize() > vc.get_boxed_array().alloc_size) then
        _err = vc.realloc_column(_sth, vc.get_boxed_array().written_size.value.usize() + 10, colindex.u16() + 1)
        match _err
        | let x: SQLSuccess val => None
        | let x: SQLError val => _set_error_text(x) ; error
        else
          error
        end

        _err = ODBCStmtFFI.get_data(_sth, colindex.u16() + 1, vc.get_boxed_array())
        match _err
        | let x: SQLSuccess val => None
        | let x: SQLError val => _set_error_text(x) ; error
        else
          error
        end
      end
    end

  fun ref _set_error_text(sqlerr: SQLError val) =>
    latest_sqlstate = sqlerr.latest_sqlstate()
    errtext =
      "ODBCStmt API Error:\n" +
      _call_location.file() + ":" + _call_location.line().string() + ": " +
      _call_location.type_name() + "." + _call_location.method_name() + "()\n" +
      "  " + sqlerr.get_err_strings()

  // Used to do introspection during testing
  fun \nodoc\ get_err(): _SQLReturn val => _err

