use "dbc"
use "stmt"
use "debug"

trait STMTTrait
  fun ref get_dbc(): ODBCDbc
  fun ref set_dbc(dbc: ODBCDbc)
  fun ref get_sth(): ODBCHandleStmt tag
  fun ref set_sth(h: ODBCHandleStmt tag)
  fun ref get_err(): SQLReturn val
  fun ref set_err(sqlerr: SQLReturn val)
  fun ref get_parameters(): Array[SQLType]
  fun ref set_parameters(pin: Array[SQLType])
  fun ref get_columns(): Array[SQLType]
  fun ref set_columns(pout: Array[SQLType])

  fun ref get_errtext(): String val
  fun ref set_errtext(str: String val)

  fun ref get_call_location(): SourceLoc val
  fun ref set_call_location(sl: SourceLoc val)


  fun ref prepare(str: String val, sl: SourceLoc val = __loc)? =>
    """
    Used to 'prepare' a SQL statement.

    Any response from the ODBC driver other than a non-warning success will
    result in a thrown error.
    """
    set_call_location(sl)
    get_parameters().clear()
    get_columns().clear()
    set_err(ODBCStmtFFI.prepare(get_sth(), str))
    match get_err()
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
    set_call_location(sl)
    get_parameters().push(i)
    i.bind_parameter(get_sth(), get_parameters().size().u16())
    set_err(i.get_err())
    match get_err()
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
    set_call_location(sl)
    get_columns().push(i)
    i.bind_column(get_sth(), get_columns().size().u16())
    set_err(i.get_err())
    match get_err()
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
    set_call_location(sl)
    set_err(ODBCStmtFFI.execute(get_sth()))
    match get_err()
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
    set_call_location(sl)
    var rv: CBoxedI64 = CBoxedI64
    set_err(ODBCStmtFFI.result_count(get_sth(), rv))
    match get_err()
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
    set_call_location(sl)
    set_err(ODBCStmtFFI.fetch_scroll(get_sth(), d, offset))
    match get_err()
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
    set_call_location(sl)
    set_err(ODBCStmtFFI.close_cursor(get_sth()))
    match get_err()
    | let x: SQLSuccess val => None
    | let x: SQLError val => _set_error_text(x) ; error
    else
      error
    end

  fun ref _check_columns(sl: SourceLoc val = __loc) ? =>
    set_call_location(sl)
    for (colindex, vc) in get_columns().pairs() do
      if (vc.get_boxed_array().written_size.value.usize() > vc.get_boxed_array().alloc_size) then
        set_err(vc.realloc_column(get_sth(), vc.get_boxed_array().written_size.value.usize() + 10, colindex.u16() + 1))
        match get_err()
        | let x: SQLSuccess val => None
        | let x: SQLError val => _set_error_text(x) ; error
        else
          error
        end

        set_err(ODBCStmtFFI.get_data(get_sth(), colindex.u16() + 1, vc.get_boxed_array()))
        match get_err()
        | let x: SQLSuccess val => None
        | let x: SQLError val => _set_error_text(x) ; error
        else
          error
        end
      end
    end

  fun ref _set_error_text(sqlerr: SQLError val) =>
    var errtext: String val =
      "ODBCStmt API Error:\n" +
      get_call_location().file() + ":" + get_call_location().line().string() + ": " +
      get_call_location().type_name() + "." + get_call_location().method_name() + "()\n" +
      "  " + sqlerr.get_err_strings()
      set_errtext(errtext)

