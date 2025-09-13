use "dbc"
use "stmt"
use "debug"

class ODBCStmt
  """
  A simple API for performing SQL queries using ODBC for maximum portability.

  **THIS API WILL CHANGE**

  This is a *synchronous* API so its use should bear that in mind. An
  asynchronous API will follow later.

  ## Prerequisites

  This API handles queries.  Before you can execute a query, you need to
  connect to a database.  Before you can connect to a database, you need an
  optional Environment.

  See the documentation of ODBCDbc and ODBCEnv for more detail one what
  these two objects are and how they are used.  The example below is
  barebones for those objects.

  ## Usage

  ```pony
  use "pony-odbc"
  use "lib:odbc"

  actor Main
    let env: Env
    var inb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(100))
    var outb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(100))

    new create(env': Env) =>
      env = env'

      var dbc: ODBCDbc = ODBCDbc
      if (not dbc.connect("psqlred")) then
        env.out.print(dbc.errtext)
      else
        var stm: ODBCStmt = ODBCStmt(dbc)
        try
          // Create a demo table
          stm
          .> prepare("create temporary table hello_world (i integer unique, s varchar(40))")?
          .> execute()?

          // Prepare your statement to insert values
          stm .> prepare("insert into hello_world (i, s) values (?, ?)")?
            .> bind_parameter(inb._1)?
            .> bind_parameter(inb._2)?

          // Insert two rows
          inb._1.write(1); if (inb._2.write("First Row"))  then stm.execute()? end
          inb._1.write(2); if (inb._2.write("Second Row")) then stm.execute()? end
          try
            inb._1.write(2); if (inb._2.write("Not Unique")) then stm.execute()? end
          end
          try
            inb._1.write(3); if (inb._2.write("TooLong: " + ("x"*100))) then stm.execute()? end
          end

          // Query our database
          stm .> prepare("select * from hello_world")?
            .> bind_column(outb._1)?
            .> bind_column(outb._2)?
            .> execute()?

          var i: I32 = 0 ; var s: String val = "" ; var moredata: Bool = true
          while (stm.fetch_scroll(SqlFetchNext)?) do
            i = outb._1.read()?
            s = outb._2.read()
            env.out.print("Integer: " + i.string() + ", s: " + s)
          end
        else
          env.out.print("An error was raised: ")
          env.out.print(dbc.errtext)
          env.out.print(stm.errtext)
        end
      end
  ```

  In general, please ignore the `sl: SourceLoc val` argument to all the
  functions. They are automatically populated with the call site from
  your application in order to enrich error reporting.

  """

  var _dbc: ODBCDbc
  var _sth: ODBCHandleStmt tag
  var _err: SQLReturn val
  var _parameters: Array[SQLType] = Array[SQLType]
  var _columns:    Array[SQLType] = Array[SQLType]

  var errtext: String val = ""

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
    | let x: SQLSuccessWithInfo val => _check_columns()? ; true
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

  fun ref _check_columns(sl: SourceLoc val = __loc) ? =>
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
    errtext =
      "ODBCStmt API Error:\n" +
      _call_location.file() + ":" + _call_location.line().string() + ": " +
      _call_location.type_name() + "." + _call_location.method_name() + "()\n" +
      "  " + sqlerr.get_err_strings()

  // Used to do introspection during testing
  fun \nodoc\ get_err(): SQLReturn val => _err

