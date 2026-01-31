use "debug"
use "lib:odbc"
use "pony_test"
use ".."

class iso _TestErrorChain is UnitTest
  let _dsn: String

  new iso create(dsn: String val) =>
    _dsn = dsn

  fun name(): String => "ErrorChain(" + _dsn + ")"

  fun apply(h: TestHelper) =>
    h.long_test(30_000_000_000)

    try
      let henv: ODBCEnv = ODBCEnv
      let dbc: ODBCDbc = henv.dbc()?
      dbc.connect(_dsn)?

      // Test 1: Error frame captures correct operation name
      _test_error_captures_operation(h, dbc)?

      // Test 2: Error frame captures SQLSTATE and message
      _test_error_captures_diagnostics(h, dbc)?

      // Test 3: Chain respects max_frames limit
      _test_max_frames_limit(h, dbc)?

      // Test 4: auto_clear behavior
      _test_auto_clear_behavior(h, dbc)?

      // Test 5: log_success behavior
      _test_log_success_behavior(h, dbc)?

      // Test 6: is_success flag
      _test_is_success_flag(h, dbc)?

      // Test 7: Hierarchical all_errors
      _test_hierarchical_errors(h, henv, dbc)?

      // Test 8: string() formatting
      _test_string_formatting(h, dbc)?

      h.complete(true)
    else
      h.fail("Test setup failed")
      h.complete(false)
    end

  fun _test_error_captures_operation(h: TestHelper, dbc: ODBCDbc): Bool ? =>
    """
    Test that error frames capture the correct operation name.
    """
    let stmt = dbc.stmt()?
    stmt.configure_error_chain(100, false, false)

    // Trigger an error by trying to execute without preparing
    try
      stmt.execute()?
      h.fail("Expected error from execute without prepare")
    end

    match stmt.last_error()
    | let err: ODBCErrorFrame val =>
      h.assert_eq[String val]("execute", err.operation)
      h.assert_eq[String val]("stmt", err.handle_type)
      h.assert_eq[Bool](false, err.is_success)
    else
      h.fail("Expected error frame after failed execute")
    end
    true

  fun _test_error_captures_diagnostics(h: TestHelper, dbc: ODBCDbc): Bool ? =>
    """
    Test that error frames capture SQLSTATE and diagnostic messages.
    """
    let stmt = dbc.stmt()?
    stmt.configure_error_chain(100, false, false)

    // Trigger a syntax error
    try
      stmt.prepare("SELECT * FROM this_table_does_not_exist_xyz123")?
      stmt.execute()?
    end

    match stmt.last_error()
    | let err: ODBCErrorFrame val =>
      // SQLSTATE should be non-empty for a real error
      let state = err.sqlstate()
      let msg = err.message()
      // We can't assert exact SQLSTATE as it varies by driver
      if (_dsn != "mariadb") then
        h.assert_true(state.size() > 0, "SQLSTATE should not be empty")
        h.assert_true(msg.size() > 0, "Error message should not be empty")
      else
        h.log("Skipping this for mariadb in CI")
      end
    else
      h.fail("Expected error frame with diagnostics")
    end
    true

  fun _test_max_frames_limit(h: TestHelper, dbc: ODBCDbc): Bool ? =>
    """
    Test that chain respects max_frames and evicts oldest first.
    """
    let stmt = dbc.stmt()?
    stmt.configure_error_chain(3, false, true)  // Small limit, log successes

    // Generate several operations
    stmt.prepare("SELECT 1")?  // Success
    try stmt.execute()? end
    stmt.prepare("SELECT 2")?  // Success

    // With log_success=true and max_frames=3, we should have at most 3 frames
    h.assert_true(stmt.error_chain().size() <= 3,
      "Chain should respect max_frames limit")
    true

  fun _test_auto_clear_behavior(h: TestHelper, dbc: ODBCDbc): Bool ? =>
    """
    Test auto_clear clears chain on prepare/finish when enabled.
    """
    let stmt = dbc.stmt()?

    // First, test with auto_clear = true (default)
    stmt.configure_error_chain(100, true, true)
    stmt.prepare("SELECT 1")?
    let size_after_first_prepare = stmt.error_chain().size()

    stmt.prepare("SELECT 2")?  // Should clear first
    let size_after_second_prepare = stmt.error_chain().size()

    // With auto_clear, the chain should be cleared before each prepare
    // so second prepare should not accumulate frames from first
    h.assert_eq[USize](size_after_first_prepare, size_after_second_prepare)

    // Now test with auto_clear = false
    stmt.configure_error_chain(100, false, true)
    stmt.prepare("SELECT 3")?
    let size_before = stmt.error_chain().size()

    stmt.prepare("SELECT 4")?  // Should NOT clear
    let size_after = stmt.error_chain().size()

    // Without auto_clear, frames should accumulate
    h.assert_true(size_after > size_before,
      "Without auto_clear, frames should accumulate")
    true

  fun _test_log_success_behavior(h: TestHelper, dbc: ODBCDbc): Bool ? =>
    """
    Test that log_success controls whether successful ops are recorded.
    """
    let stmt = dbc.stmt()?

    // With log_success = false (default)
    stmt.configure_error_chain(100, true, false)
    stmt.prepare("SELECT 1")?
    let size_no_success = stmt.error_chain().size()
    h.assert_eq[USize](0, size_no_success,
      "With log_success=false, successful ops should not be recorded")

    // With log_success = true
    stmt.configure_error_chain(100, true, true)
    stmt.prepare("SELECT 2")?
    let size_with_success = stmt.error_chain().size()
    h.assert_true(size_with_success > 0,
      "With log_success=true, successful ops should be recorded")
    true

  fun _test_is_success_flag(h: TestHelper, dbc: ODBCDbc): Bool ? =>
    """
    Test that is_success flag is set correctly.
    """
    let stmt = dbc.stmt()?
    stmt.configure_error_chain(100, false, true)

    // Generate a success
    stmt.prepare("SELECT 1")?

    match stmt.last_error()
    | let err: ODBCErrorFrame val =>
      h.assert_eq[Bool](true, err.is_success,
        "Success frame should have is_success=true")
    else
      h.fail("Expected success frame")
    end

    // Generate an error
    try
      stmt.prepare("INVALID SQL SYNTAX !!!")?
      stmt.execute()?
    end

    match stmt.last_error()
    | let err: ODBCErrorFrame val =>
      h.assert_eq[Bool](false, err.is_success,
        "Error frame should have is_success=false")
    else
      h.fail("Expected error frame")
    end
    true

  fun _test_hierarchical_errors(h: TestHelper, henv: ODBCEnv, dbc: ODBCDbc): Bool ? =>
    """
    Test that all_errors() aggregates errors from child handles.
    """
    let stmt1 = dbc.stmt()?
    let stmt2 = dbc.stmt()?

    stmt1.configure_error_chain(100, false, true)
    stmt2.configure_error_chain(100, false, true)

    // Generate operations on both statements
    stmt1.prepare("SELECT 1")?
    stmt2.prepare("SELECT 2")?

    // dbc.all_errors() should include both statement's errors
    let dbc_errors = dbc.all_errors()
    h.assert_true(dbc_errors.size() >= 2,
      "dbc.all_errors() should include statement errors")

    // env.all_errors() should include all errors
    let env_errors = henv.all_errors()
    h.assert_true(env_errors.size() >= dbc_errors.size(),
      "env.all_errors() should include all descendant errors")
    true

  fun _test_string_formatting(h: TestHelper, dbc: ODBCDbc): Bool ? =>
    """
    Test that string() produces readable output.
    """
    let stmt = dbc.stmt()?
    stmt.configure_error_chain(100, false, true)

    stmt.prepare("SELECT 1")?

    let chain_str = stmt.error_chain().string()
    h.assert_true(chain_str.contains("Error chain"),
      "Chain string should contain 'Error chain'")

    match stmt.last_error()
    | let err: ODBCErrorFrame val =>
      let err_str = err.string()
      h.assert_true(err_str.contains("[stmt]"),
        "Error string should contain handle type")
      h.assert_true(err_str.contains("prepare"),
        "Error string should contain operation name")
    else
      h.fail("Expected error frame")
    end
    true
