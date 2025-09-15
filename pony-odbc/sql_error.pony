use "debug"
use "collections"

class \nodoc\ SQLError
  var _location: SourceLoc val = __loc
  var _records: Array[(I16, SQLDiagFrame)] = Array[(I16, SQLDiagFrame)]

  fun apply(): I16 => -1

  fun string(): String val => "SQLError"

  fun get_err_strings(): String val =>
    _location.type_name() + "." +
    _location.method_name() + "() returned the following error from ODBC\n\n" +
    "\n".join(get_records().values())

  new \nodoc\ create_penv(htype: ODBCHandleEnv tag, sl: SourceLoc val = __loc) => None
    _location = sl
    for num in Range[I16](1,1024) do
      try
        _records.push((num, SQLDiagFrame.create_penv(htype, num)?))
      else
        break
      end
    end

  new \nodoc\ create_pdbc(htype: ODBCHandleDbc tag, sl: SourceLoc val = __loc) => None
    _location = sl
    for num in Range[I16](1,1024) do
      try
        _records.push((num, SQLDiagFrame.create_pdbc(htype, num)?))
      else
        break
      end
    end

  new \nodoc\ create_pstmt(htype: ODBCHandleStmt tag, sl: SourceLoc val = __loc) =>
    _location = sl
    for num in Range[I16](1,1024) do
      try
        _records.push((num, SQLDiagFrame.create_pstmt(htype, num)?))
      else
        break
      end
    end

  fun latest_sqlstate(): String val =>
    """
    Returns the latest SQLSTATE from this SQLError.
    """
    try
      _records(_records.size() - 1)?._2.sqlstate.clone()
    else
      ""
    end

  fun sqlstates(): Array[String val] val =>
    """
    Returns an Array of SQLSTATEs in the order in which they were provided
    to the driver.
    """
    var rs: USize = _records.size()
    var rv: Array[String val] trn = recover trn Array[String val](rs) end
    for (i,f) in _records.values() do
      rv.push(f.sqlstate.clone())
    end
    consume rv

  fun get_records(): Array[String val] val =>
    """
    Returns an Array of human-readable strings suitable for logging.
    """
    let rv: Array[String val] trn = recover trn Array[String val](8) end
    for (i,f) in _records.values() do
      rv.push(f.recstring())
    end
    consume rv

  fun get_tuples(): Array[(I16, String val, String val)] val =>
    """
    Returns an Array of tuples of the form:
      - Index
      - SQLSTATE
      - Human readable error message
    """
    let rv: Array[(I16, String val, String val)] trn = recover trn Array[(I16, String val, String val)](8) end
    for (i,f) in _records.values() do
      rv.push(f.rec_tuple())
    end
    consume rv
