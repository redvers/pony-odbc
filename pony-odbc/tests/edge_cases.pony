use "debug"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestEdgeCases is UnitTest
  """
  Tests edge cases including:
  - Empty strings and zero-length values
  - Very long strings
  - Special characters and unicode
  - Empty result sets
  - Multiple sequential operations
  """
  var dsn: String val
  fun name(): String val => dsn + "/_TestEdgeCases"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      test_empty_strings(h, dbc)
      test_long_strings(h, dbc)
      test_special_characters(h, dbc)
      test_empty_result_set(h, dbc)
      test_single_row_result(h, dbc)
      test_whitespace_strings(h, dbc)
      test_repeated_values(h, dbc)
      test_string_buffer_exact_size(h, dbc)
    else
      h.fail("Failed to connect or run edge case tests")
    end

  fun test_empty_strings(h: TestHelper, dbc: ODBCDbc) =>
    """Test empty string insertion and retrieval"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_empty (id INTEGER, val VARCHAR(100))")?

      var id_in: SQLInteger = SQLInteger
      var str_in: SQLVarchar = SQLVarchar(100)
      var id_out: SQLInteger = SQLInteger
      var str_out: SQLVarchar = SQLVarchar(100)

      stm.prepare("INSERT INTO test_empty VALUES (?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(str_in)?

      // Insert empty string
      id_in.write(1)
      str_in.write("")
      stm.execute()?
      stm.finish()?

      // Retrieve and verify
      stm.prepare("SELECT id, val FROM test_empty WHERE id = ?")?
      stm.bind_parameter(id_in)?
      stm.bind_column(id_out)?
      stm.bind_column(str_out)?

      id_in.write(1)
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](1, id_out.read()?)
      h.assert_eq[String]("", str_out.read()?)

      stm.finish()?
    else
      h.fail("test_empty_strings failed")
    end

  fun test_long_strings(h: TestHelper, dbc: ODBCDbc) =>
    """Test very long string values (stress test buffer expansion)"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_long (id INTEGER, val VARCHAR(5000))")?

      var id_in: SQLInteger = SQLInteger
      var str_in: SQLVarchar = SQLVarchar(5000)
      var id_out: SQLInteger = SQLInteger
      var str_out: SQLVarchar = SQLVarchar(10) // Intentionally undersized

      // Build a long string (4000 characters)
      var long_str: String = ""
      for i in Range[USize](0, 400) do
        long_str = long_str + "0123456789"
      end

      stm.prepare("INSERT INTO test_long VALUES (?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(str_in)?

      id_in.write(1)
      str_in.write(long_str)
      stm.execute()?
      stm.finish()?

      // Retrieve with undersized buffer (tests auto-expansion)
      stm.prepare("SELECT id, val FROM test_long WHERE id = ?")?
      stm.bind_parameter(id_in)?
      stm.bind_column(id_out)?
      stm.bind_column(str_out)?

      id_in.write(1)
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](1, id_out.read()?)
      h.assert_eq[String](long_str, str_out.read()?)

      stm.finish()?
    else
      h.fail("test_long_strings failed")
    end

  fun test_special_characters(h: TestHelper, dbc: ODBCDbc) =>
    """Test strings with special characters"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_special (id INTEGER, val VARCHAR(200))")?

      var id_in: SQLInteger = SQLInteger
      var str_in: SQLVarchar = SQLVarchar(200)
      var id_out: SQLInteger = SQLInteger
      var str_out: SQLVarchar = SQLVarchar(200)

      stm.prepare("INSERT INTO test_special VALUES (?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(str_in)?

      let test_strings: Array[String] = [
        "Tab:\tNewline:\nReturn:\r"
        "Quote: ' Double: \" Backslash: \\"
        "Symbols: !@#$%^&*()_+-={}[]|:;<>?,./~`"
        "Apostrophe's test"
      ]

      var counter: I32 = 1
      for test_str in test_strings.values() do
        id_in.write(counter)
        str_in.write(test_str)
        stm.execute()?
        stm.finish()?
        counter = counter + 1
      end

      // Verify one of them
      stm.prepare("SELECT val FROM test_special WHERE id = ?")?
      stm.bind_parameter(id_in)?
      stm.bind_column(str_out)?

      id_in.write(3)
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[String]("Symbols: !@#$%^&*()_+-={}[]|:;<>?,./~`", str_out.read()?)

      stm.finish()?
    else
      h.fail("test_special_characters failed")
    end

  fun test_empty_result_set(h: TestHelper, dbc: ODBCDbc) =>
    """Test queries that return no rows"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_empty_result (id INTEGER)")?

      var id_out: SQLInteger = SQLInteger

      // Query empty table
      stm.prepare("SELECT id FROM test_empty_result WHERE id > ?")?
      var id_in: SQLInteger = SQLInteger
      stm.bind_parameter(id_in)?
      stm.bind_column(id_out)?

      id_in.write(0)
      stm.execute()?

      // Should return false immediately (no rows)
      h.assert_false(stm.fetch()?)

      stm.finish()?
    else
      h.fail("test_empty_result_set failed")
    end

  fun test_single_row_result(h: TestHelper, dbc: ODBCDbc) =>
    """Test queries that return exactly one row"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_single (id INTEGER, val VARCHAR(50))")?

      var id_in: SQLInteger = SQLInteger
      var str_in: SQLVarchar = SQLVarchar(50)

      stm.prepare("INSERT INTO test_single VALUES (?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(str_in)?

      id_in.write(42)
      str_in.write("Only one row")
      stm.execute()?
      stm.finish()?

      // Query for single row
      var id_out: SQLInteger = SQLInteger
      var str_out: SQLVarchar = SQLVarchar(50)

      stm.prepare("SELECT id, val FROM test_single")?
      stm.bind_column(id_out)?
      stm.bind_column(str_out)?
      stm.execute()?

      // First fetch should succeed
      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](42, id_out.read()?)
      h.assert_eq[String]("Only one row", str_out.read()?)

      // Second fetch should fail (no more rows)
      h.assert_false(stm.fetch()?)

      stm.finish()?
    else
      h.fail("test_single_row_result failed")
    end

  fun test_whitespace_strings(h: TestHelper, dbc: ODBCDbc) =>
    """Test strings with only whitespace"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_whitespace (id INTEGER, val VARCHAR(100))")?

      var id_in: SQLInteger = SQLInteger
      var str_in: SQLVarchar = SQLVarchar(100)

      stm.prepare("INSERT INTO test_whitespace VALUES (?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(str_in)?

      // Single space
      id_in.write(1)
      str_in.write(" ")
      stm.execute()?
      stm.finish()?

      // Multiple spaces
      id_in.write(2)
      str_in.write("     ")
      stm.execute()?
      stm.finish()?

      // Leading/trailing spaces
      id_in.write(3)
      str_in.write("  text  ")
      stm.execute()?
      stm.finish()?

      var str_out: SQLVarchar = SQLVarchar(100)

      stm.prepare("SELECT val FROM test_whitespace WHERE id = ?")?
      stm.bind_parameter(id_in)?
      stm.bind_column(str_out)?

      id_in.write(1)
      stm.execute()?
      h.assert_true(stm.fetch()?)
      h.assert_eq[String](" ", str_out.read()?)
      stm.finish()?

    else
      h.fail("test_whitespace_strings failed")
    end

  fun test_repeated_values(h: TestHelper, dbc: ODBCDbc) =>
    """Test inserting the same value multiple times"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_repeated (val INTEGER)")?

      var val_in: SQLInteger = SQLInteger

      stm.prepare("INSERT INTO test_repeated VALUES (?)")?
      stm.bind_parameter(val_in)?

      // Insert same value 100 times
      val_in.write(42)
      for i in Range[I32](0, 100) do
        stm.execute()?
        stm.finish()?
      end

      // Count rows
      var count_out: SQLInteger = SQLInteger
      stm.direct_exec("SELECT COUNT(*) FROM test_repeated WHERE val = 42")?
      stm.bind_column(count_out)?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](100, count_out.read()?)

      stm.finish()?
    else
      h.fail("test_repeated_values failed")
    end

  fun test_string_buffer_exact_size(h: TestHelper, dbc: ODBCDbc) =>
    """Test string that exactly fills the buffer"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_exact (val VARCHAR(100))")?

      var str_in: SQLVarchar = SQLVarchar(50)
      var str_out: SQLVarchar = SQLVarchar(50)

      // Create exactly 50 character string
      var exact_str: String = ""
      for i in Range[USize](0, 5) do
        exact_str = exact_str + "1234567890"
      end

      stm.prepare("INSERT INTO test_exact VALUES (?)")?
      stm.bind_parameter(str_in)?

      str_in.write(exact_str)
      stm.execute()?
      stm.finish()?

      stm.prepare("SELECT val FROM test_exact")?
      stm.bind_column(str_out)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[String](exact_str, str_out.read()?)

      stm.finish()?
    else
      h.fail("test_string_buffer_exact_size failed")
    end
