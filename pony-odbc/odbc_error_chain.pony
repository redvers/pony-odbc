use "collections"

class ODBCErrorChain
  """
  Accumulates error frames from ODBC operations.

  The error chain maintains a configurable history of error events, allowing
  inspection of what operations failed and why. It supports:

  - Maximum frame limit with oldest-first eviction
  - Optional auto-clear on prepare/finish operations
  - Optional logging of successful operations for tracing

  ## Configuration

  ```pony
  stmt.configure_error_chain(
    max_frames = 50,
    auto_clear = true,
    log_success = false
  )
  ```

  ## Usage

  ```pony
  // Access the most recent error
  match stmt.last_error()
  | let err: ODBCErrorFrame val =>
    env.err.print(err.string())
  end

  // Iterate over all errors
  for err in stmt.error_chain().values() do
    env.err.print(err.operation + ": " + err.message())
  end

  // Print formatted chain
  env.err.print(stmt.error_chain().string())
  ```
  """
  var _frames: Array[ODBCErrorFrame val] = Array[ODBCErrorFrame val]
  var _max_frames: USize = 100
  var _sequence: USize = 0
  var _auto_clear: Bool = true
  var _log_success: Bool = false

  new create() =>
    """
    Create a new error chain with default settings.
    """
    None

  fun ref push(frame: ODBCErrorFrame val) =>
    """
    Add a frame to the chain, evicting the oldest if at capacity.
    """
    if _frames.size() >= _max_frames then
      try _frames.shift()? end
    end
    _frames.push(frame)

  fun ref clear() =>
    """
    Clear all stored frames. Sequence counter is preserved.
    """
    _frames.clear()

  fun size(): USize =>
    """
    Number of currently stored frames.
    """
    _frames.size()

  fun values(): ArrayValues[ODBCErrorFrame val, this->Array[ODBCErrorFrame val]]^ =>
    """
    Iterate over frames from oldest to newest.
    """
    _frames.values()

  fun last(): (ODBCErrorFrame val | None) =>
    """
    Get the most recent error frame, or None if empty.
    """
    try
      _frames(_frames.size() - 1)?
    else
      None
    end

  fun first(): (ODBCErrorFrame val | None) =>
    """
    Get the oldest error frame, or None if empty.
    """
    try
      _frames(0)?
    else
      None
    end

  fun apply(i: USize): ODBCErrorFrame val ? =>
    """
    Get frame by index. Throws if out of bounds.
    """
    _frames(i)?

  fun string(): String val =>
    """
    Format the entire chain for display.

    Output format:
    ```
    Error chain (2 errors):
      1. [stmt] prepare at main.pony:41 - OK
      2. [stmt] execute at main.pony:42 - 42S02: Table 'nonexistent' doesn't exist
    ```
    """
    if _frames.size() == 0 then
      return "Error chain (empty)"
    end

    let error_count = _count_errors()
    let label = if error_count == 1 then "error" else "errors" end

    var result: String ref = String
    result.append("Error chain (" + error_count.string() + " " + label)
    if _log_success then
      result.append(", " + (_frames.size() - error_count).string() + " success frames")
    end
    result.append("):\n")

    var idx: USize = 1
    for frame in _frames.values() do
      result.append("  " + idx.string() + ". " + frame.string() + "\n")
      idx = idx + 1
    end
    result.clone()

  fun _count_errors(): USize =>
    """
    Count non-success frames.
    """
    var count: USize = 0
    for frame in _frames.values() do
      if not frame.is_success then
        count = count + 1
      end
    end
    count

  fun ref next_sequence(): USize =>
    """
    Get and increment the sequence counter.
    """
    let seq = _sequence
    _sequence = _sequence + 1
    seq

  fun current_sequence(): USize =>
    """
    Get the current sequence counter without incrementing.
    """
    _sequence

  fun ref set_max_frames(n: USize) =>
    """
    Configure maximum number of stored frames.
    When reduced, excess frames are evicted oldest-first.
    """
    _max_frames = n
    while _frames.size() > _max_frames do
      try _frames.shift()? end
    end

  fun max_frames(): USize =>
    """
    Get the current maximum frames setting.
    """
    _max_frames

  fun ref set_auto_clear(v: Bool) =>
    """
    Configure auto-clear behavior.
    When true, the chain is cleared on prepare()/finish() calls.
    """
    _auto_clear = v

  fun auto_clear(): Bool =>
    """
    Get the current auto-clear setting.
    """
    _auto_clear

  fun ref set_log_success(v: Bool) =>
    """
    Configure success logging.
    When true, successful operations are also recorded in the chain.
    """
    _log_success = v

  fun log_success(): Bool =>
    """
    Get the current log_success setting.
    """
    _log_success

  fun errors_only(): Array[ODBCErrorFrame val] val =>
    """
    Return only error frames (not success frames).
    """
    var result: Array[ODBCErrorFrame val] trn = recover trn Array[ODBCErrorFrame val] end
    for frame in _frames.values() do
      if not frame.is_success then
        result.push(frame)
      end
    end
    consume result
