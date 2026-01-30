use "debug"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestErrorRecovery is UnitTest
  """
  Tests error handling and recovery scenarios:
  - Constraint violations
  - Invalid data type conversions
  - Recovery after errors
  - Executing statements after errors
  """
  var dsn: String val
  fun name(): String val => "_TestErrorRecovery(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      test_unique_constraint_violation(h, dbc)
      test_not_null_constraint(h, dbc)
      test_recovery_after_error(h, dbc)
      test_invalid_table_name(h, dbc)
      test_invalid_column_reference(h, dbc)
    else
      h.fail("Failed to connect or run error recovery tests")
    end

  fun test_unique_constraint_violation(h: TestHelper, dbc: ODBCDbc) =>
    """Test handling of UNIQUE constraint violations"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_unique (id INTEGER UNIQUE, val VARCHAR(50))")?

      var id_in: SQLInteger = SQLInteger
      var val_in: SQLVarchar = SQLVarchar(50)

      stm.prepare("INSERT INTO test_unique VALUES (?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(val_in)?

      // First insert should succeed
      id_in.write(1)
      val_in.write("First")
      stm.execute()?
      stm.finish()?

      // Second insert with same ID should fail
      id_in.write(1)
      val_in.write("Duplicate")
      try
        stm.execute()?
        h.fail("Should have thrown error for unique constraint violation")
      else
        // Expected error - verify we got a SQL state
        let states = stm.sqlstates()
        h.assert_true(states.size() > 0)
      end

      // Verify we can still use the statement after error
      stm.finish()?
      id_in.write(2)
      val_in.write("Second")
      stm.execute()?
      stm.finish()?

      // Verify the valid insert worked
      var id_out: SQLInteger = SQLInteger
      var val_out: SQLVarchar = SQLVarchar(50)

      stm.prepare("SELECT id, val FROM test_unique WHERE id = ?")?
      stm.bind_parameter(id_in)?
      stm.bind_column(id_out)?
      stm.bind_column(val_out)?

      id_in.write(2)
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](2, id_out.read()?)
      h.assert_eq[String]("Second", val_out.read()?)

      stm.finish()?
    else
      h.fail("test_unique_constraint_violation failed")
    end

  fun test_not_null_constraint(h: TestHelper, dbc: ODBCDbc) =>
    """Test handling of NOT NULL constraint violations"""
    try
      var stm: ODBCStmt = dbc.stmt()?

      // SQLite doesn't enforce NOT NULL on column definition the same way
      if (dsn != "sqlitedb3") then
        stm.direct_exec("CREATE TEMPORARY TABLE test_not_null (id INTEGER NOT NULL, val VARCHAR(50))")?

        var id_in: SQLInteger = SQLInteger
        var val_in: SQLVarchar = SQLVarchar(50)

        stm.prepare("INSERT INTO test_not_null VALUES (?, ?)")?
        stm.bind_parameter(id_in)?
        stm.bind_parameter(val_in)?

        // Insert with NULL id should fail
        id_in.null()
        val_in.write("Test")
        try
          stm.execute()?
          h.fail("Should have thrown error for NOT NULL constraint violation")
        else
          // Expected error
          h.assert_true(true)
        end

        stm.finish()?

        // Verify we can still use statement after error
        id_in.write(1)
        val_in.write("Valid")
        stm.execute()?
        stm.finish()?
      end
    else
      h.fail("test_not_null_constraint failed")
    end

  fun test_recovery_after_error(h: TestHelper, dbc: ODBCDbc) =>
    """Test that connections and statements remain usable after errors"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_recovery (id INTEGER PRIMARY KEY, val VARCHAR(50))")?

      var id_in: SQLInteger = SQLInteger
      var val_in: SQLVarchar = SQLVarchar(50)

      stm.prepare("INSERT INTO test_recovery VALUES (?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(val_in)?

      // Successful insert
      id_in.write(1)
      val_in.write("One")
      stm.execute()?
      stm.finish()?

      // Failed insert (duplicate primary key)
      try
        id_in.write(1)
        val_in.write("One Again")
        stm.execute()?
      end

      stm.finish()?

      // Another successful insert - proves recovery
      id_in.write(2)
      val_in.write("Two")
      stm.execute()?
      stm.finish()?

      // Failed insert
      try
        id_in.write(2)
        val_in.write("Two Again")
        stm.execute()?
      end

      stm.finish()?

      // Another successful insert
      id_in.write(3)
      val_in.write("Three")
      stm.execute()?
      stm.finish()?

      // Verify all successful inserts
      var count_out: SQLInteger = SQLInteger
      stm.direct_exec("SELECT COUNT(*) FROM test_recovery")?
      stm.bind_column(count_out)?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](3, count_out.read()?)

      stm.finish()?
    else
      h.fail("test_recovery_after_error failed")
    end

  fun test_invalid_table_name(h: TestHelper, dbc: ODBCDbc) =>
    """Test querying non-existent table"""
    try
      var stm: ODBCStmt = dbc.stmt()?

      try
        stm.direct_exec("SELECT * FROM table_that_does_not_exist_12345")?
        h.fail("Should have thrown error for invalid table name")
      else
        // Expected error
        let states = stm.sqlstates()
        h.assert_true(states.size() > 0)
      end

      // Verify statement can still be used
      stm.direct_exec("CREATE TEMPORARY TABLE test_valid (id INTEGER)")?

      var id_in: SQLInteger = SQLInteger
      stm.prepare("INSERT INTO test_valid VALUES (?)")?
      stm.bind_parameter(id_in)?

      id_in.write(42)
      stm.execute()?
      stm.finish()?

      var id_out: SQLInteger = SQLInteger
      stm.prepare("SELECT id FROM test_valid")?
      stm.bind_column(id_out)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](42, id_out.read()?)

      stm.finish()?
    else
      h.fail("test_invalid_table_name failed")
    end

  fun test_invalid_column_reference(h: TestHelper, dbc: ODBCDbc) =>
    """Test referencing non-existent column"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_invalid_col (id INTEGER, name VARCHAR(50))")?

      var id_in: SQLInteger = SQLInteger
      stm.prepare("INSERT INTO test_invalid_col VALUES (?, ?)")?
      stm.bind_parameter(id_in)?

      var name_in: SQLVarchar = SQLVarchar(50)
      stm.bind_parameter(name_in)?

      id_in.write(1)
      name_in.write("Test")
      stm.execute()?
      stm.finish()?

      // Try to query non-existent column
      try
        stm.prepare("SELECT id, name, nonexistent_column FROM test_invalid_col")?
        stm.execute()?
        h.fail("Should have thrown error for invalid column reference")
      else
        // Expected error
        h.assert_true(true)
      end

      stm.finish()?

      // Verify we can still query valid columns
      var id_out: SQLInteger = SQLInteger
      var name_out: SQLVarchar = SQLVarchar(50)

      stm.prepare("SELECT id, name FROM test_invalid_col")?
      stm.bind_column(id_out)?
      stm.bind_column(name_out)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](1, id_out.read()?)
      h.assert_eq[String]("Test", name_out.read()?)

      stm.finish()?
    else
      h.fail("test_invalid_column_reference failed")
    end
