class val ODBCErrorFrame is Comparable[ODBCErrorFrame]
  """
  Captures a single error event from an ODBC operation.

  Each frame records:
  - The operation that failed (e.g., "prepare", "execute", "bind_parameter")
  - Source location where the operation was called
  - The ODBC return code
  - Diagnostic information (SQLSTATE codes and messages)
  - A sequence number for ordering in an error chain
  - Optional SQL text if applicable
  - The handle type ("env", "dbc", "stmt")
  - Whether this was a successful operation (when log_success is enabled)

  ## Example Usage

  ```pony
  match stmt.last_error()
  | let err: ODBCErrorFrame val =>
    env.err.print(err.string())
    // Output: [stmt] execute at main.pony:42 - 42S02: Table not found
  end
  ```
  """
  let operation: String val
  let source_loc: SourceLoc val
  let sql_return: SQLReturn val
  let diagnostics: Array[(String val, String val)] val
  let sequence: USize
  let sql_text: (String val | None)
  let handle_type: String val
  let is_success: Bool

  new val create(
    operation': String val,
    source_loc': SourceLoc val,
    sql_return': SQLReturn val,
    diagnostics': Array[(String val, String val)] val,
    sequence': USize,
    sql_text': (String val | None) = None,
    handle_type': String val = "stmt",
    is_success': Bool = false
  ) =>
    operation = operation'
    source_loc = source_loc'
    sql_return = sql_return'
    diagnostics = diagnostics'
    sequence = sequence'
    sql_text = sql_text'
    handle_type = handle_type'
    is_success = is_success'

  fun string(): String val =>
    """
    Formatted error for display.

    Format: "[handle_type] operation at file:line - SQLSTATE: message"
    For success frames: "[handle_type] operation at file:line - OK"
    """
    let loc_str = _loc_string()
    if is_success then
      "[" + handle_type + "] " + operation + " at " + loc_str + " - OK"
    else
      let state = sqlstate()
      let msg = message()
      if state.size() > 0 then
        "[" + handle_type + "] " + operation + " at " + loc_str + " - " + state + ": " + msg
      else
        "[" + handle_type + "] " + operation + " at " + loc_str + " - " + sql_return.string()
      end
    end

  fun _loc_string(): String val =>
    """
    Format source location as "file:line"
    """
    source_loc.file() + ":" + source_loc.line().string()

  fun sqlstate(): String val =>
    """
    Returns the first SQLSTATE code or an empty string if none available.
    """
    try
      diagnostics(0)?._1
    else
      ""
    end

  fun message(): String val =>
    """
    Returns the first diagnostic message or a generic error description.
    """
    try
      diagnostics(0)?._2
    else
      sql_return.string()
    end

  fun lt(that: ODBCErrorFrame box): Bool =>
    """
    Compare by sequence number for sorting.
    """
    sequence < that.sequence

  fun eq(that: ODBCErrorFrame box): Bool =>
    """
    Compare by sequence number for equality.
    """
    sequence == that.sequence
