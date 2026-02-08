use "debug"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestMultipleConnections is UnitTest
  """
  Tests multiple database connections and concurrent statement operations.
  Validates that:
  - Multiple connections to same DSN work correctly
  - Multiple statements on same connection work correctly
  - Statement reuse patterns work correctly
  - Interleaved operations don't interfere
  """
  var dsn: String val
  fun name(): String val => dsn + "/_TestMultipleConnections"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    test_two_connections(h, env)
    test_multiple_statements_same_connection(h, env)
    test_statement_reuse_different_queries(h, env)
    test_interleaved_fetch_operations(h, env)
    test_connection_reconnect(h, env)

  fun test_two_connections(h: TestHelper, env: ODBCEnv) =>
    """Test two simultaneous connections to the same database"""
    try
      var dbc1: ODBCDbc = env.dbc()?
      var dbc2: ODBCDbc = env.dbc()?

      h.assert_true(dbc1.connect(dsn)?)
      h.assert_true(dbc2.connect(dsn)?)

      // Create table on connection 1
      var stm1: ODBCStmt = dbc1.stmt()?
      stm1.direct_exec("CREATE TEMPORARY TABLE test_conn1 (id INTEGER, val VARCHAR(50))")?

      var id_in: SQLInteger = SQLInteger
      var val_in: SQLVarchar = SQLVarchar(50)

      stm1.prepare("INSERT INTO test_conn1 VALUES (?, ?)")?
      stm1.bind_parameter(id_in)?
      stm1.bind_parameter(val_in)?

      id_in.write(1)
      val_in.write("From connection 1")
      stm1.execute()?
      stm1.finish()?

      // Create table on connection 2
      var stm2: ODBCStmt = dbc2.stmt()?
      stm2.direct_exec("CREATE TEMPORARY TABLE test_conn2 (id INTEGER, val VARCHAR(50))")?

      stm2.prepare("INSERT INTO test_conn2 VALUES (?, ?)")?
      stm2.bind_parameter(id_in)?
      stm2.bind_parameter(val_in)?

      id_in.write(2)
      val_in.write("From connection 2")
      stm2.execute()?
      stm2.finish()?

      // Verify both connections work independently
      var id_out: SQLInteger = SQLInteger
      var val_out: SQLVarchar = SQLVarchar(50)

      stm1.prepare("SELECT id, val FROM test_conn1")?
      stm1.bind_column(id_out)?
      stm1.bind_column(val_out)?
      stm1.execute()?

      h.assert_true(stm1.fetch()?)
      h.assert_eq[I32](1, id_out.read()?)
      h.assert_eq[String]("From connection 1", val_out.read()?)
      stm1.finish()?

      stm2.prepare("SELECT id, val FROM test_conn2")?
      stm2.bind_column(id_out)?
      stm2.bind_column(val_out)?
      stm2.execute()?

      h.assert_true(stm2.fetch()?)
      h.assert_eq[I32](2, id_out.read()?)
      h.assert_eq[String]("From connection 2", val_out.read()?)
      stm2.finish()?

      // Cleanup
      dbc1.disconnect()?
      dbc2.disconnect()?
    else
      h.fail("test_two_connections failed")
    end

  fun test_multiple_statements_same_connection(h: TestHelper, env: ODBCEnv) =>
    """Test multiple statement handles on the same connection"""
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      // Create table
      var stm_setup: ODBCStmt = dbc.stmt()?
      stm_setup.direct_exec("CREATE TEMPORARY TABLE test_multi_stmt (id INTEGER, val VARCHAR(50))")?

      // Insert with first statement
      var stm1: ODBCStmt = dbc.stmt()?
      var id_in: SQLInteger = SQLInteger
      var val_in: SQLVarchar = SQLVarchar(50)

      stm1.prepare("INSERT INTO test_multi_stmt VALUES (?, ?)")?
      stm1.bind_parameter(id_in)?
      stm1.bind_parameter(val_in)?

      for i in Range[I32](1, 6) do
        id_in.write(i)
        val_in.write("Row " + i.string())
        stm1.execute()?
        stm1.finish()?
      end

      // Query with second statement
      var stm2: ODBCStmt = dbc.stmt()?
      var id_out: SQLInteger = SQLInteger
      var val_out: SQLVarchar = SQLVarchar(50)

      stm2.prepare("SELECT id, val FROM test_multi_stmt WHERE id = ?")?
      stm2.bind_parameter(id_in)?
      stm2.bind_column(id_out)?
      stm2.bind_column(val_out)?

      id_in.write(3)
      stm2.execute()?

      h.assert_true(stm2.fetch()?)
      h.assert_eq[I32](3, id_out.read()?)
      h.assert_eq[String]("Row 3", val_out.read()?)
      stm2.finish()?

      // Both statements should still be usable
      id_in.write(4)
      stm2.execute()?

      h.assert_true(stm2.fetch()?)
      h.assert_eq[I32](4, id_out.read()?)
      stm2.finish()?
    else
      h.fail("test_multiple_statements_same_connection failed")
    end

  fun test_statement_reuse_different_queries(h: TestHelper, env: ODBCEnv) =>
    """Test reusing the same statement handle for different queries"""
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      var stm: ODBCStmt = dbc.stmt()?

      // First query - create and populate table
      stm.direct_exec("CREATE TEMPORARY TABLE test_reuse (id INTEGER, name VARCHAR(50), value FLOAT)")?

      var id_in: SQLInteger = SQLInteger
      var name_in: SQLVarchar = SQLVarchar(50)
      var value_in: SQLFloat = SQLFloat

      stm.prepare("INSERT INTO test_reuse VALUES (?, ?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(name_in)?
      stm.bind_parameter(value_in)?

      id_in.write(1)
      name_in.write("First")
      value_in.write(1.5)
      stm.execute()?
      stm.finish()?

      // Reuse for different insert
      id_in.write(2)
      name_in.write("Second")
      value_in.write(2.5)
      stm.execute()?
      stm.finish()?

      // Reuse for SELECT query (different structure)
      var id_out: SQLInteger = SQLInteger
      var name_out: SQLVarchar = SQLVarchar(50)

      stm.prepare("SELECT id, name FROM test_reuse WHERE id = ?")?
      stm.bind_parameter(id_in)?
      stm.bind_column(id_out)?
      stm.bind_column(name_out)?

      id_in.write(2)
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](2, id_out.read()?)
      h.assert_eq[String]("Second", name_out.read()?)
      stm.finish()?

      // Reuse for UPDATE query
      stm.prepare("UPDATE test_reuse SET name = ? WHERE id = ?")?
      stm.bind_parameter(name_in)?
      stm.bind_parameter(id_in)?

      name_in.write("Updated")
      id_in.write(1)
      stm.execute()?
      stm.finish()?

      // Verify update
      stm.prepare("SELECT name FROM test_reuse WHERE id = ?")?
      stm.bind_parameter(id_in)?
      stm.bind_column(name_out)?

      id_in.write(1)
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[String]("Updated", name_out.read()?)
      stm.finish()?
    else
      h.fail("test_statement_reuse_different_queries failed")
    end

  fun test_interleaved_fetch_operations(h: TestHelper, env: ODBCEnv) =>
    """Test interleaving fetch operations on different statements (non-concurrent but sequential)"""
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      // Setup table
      var stm_setup: ODBCStmt = dbc.stmt()?
      stm_setup.direct_exec("CREATE TEMPORARY TABLE test_interleave (id INTEGER)")?

      var id_in: SQLInteger = SQLInteger
      stm_setup.prepare("INSERT INTO test_interleave VALUES (?)")?
      stm_setup.bind_parameter(id_in)?

      for i in Range[I32](1, 11) do
        id_in.write(i)
        stm_setup.execute()?
        stm_setup.finish()?
      end

      // Create two queries
      var stm1: ODBCStmt = dbc.stmt()?
      var stm2: ODBCStmt = dbc.stmt()?

      var id_out1: SQLInteger = SQLInteger
      var id_out2: SQLInteger = SQLInteger

      stm1.prepare("SELECT id FROM test_interleave WHERE id <= 5 ORDER BY id")?
      stm1.bind_column(id_out1)?
      stm1.execute()?

      stm2.prepare("SELECT id FROM test_interleave WHERE id > 5 ORDER BY id")?
      stm2.bind_column(id_out2)?
      stm2.execute()?

      // Fetch from stm1
      h.assert_true(stm1.fetch()?)
      h.assert_eq[I32](1, id_out1.read()?)

      // Fetch from stm2
      h.assert_true(stm2.fetch()?)
      h.assert_eq[I32](6, id_out2.read()?)

      // Back to stm1
      h.assert_true(stm1.fetch()?)
      h.assert_eq[I32](2, id_out1.read()?)

      // Back to stm2
      h.assert_true(stm2.fetch()?)
      h.assert_eq[I32](7, id_out2.read()?)

      stm1.finish()?
      stm2.finish()?
    else
      h.fail("test_interleaved_fetch_operations failed")
    end

  fun test_connection_reconnect(h: TestHelper, env: ODBCEnv) =>
    """Test disconnecting and reconnecting"""
    try
      var dbc: ODBCDbc = env.dbc()?

      // First connection
      h.assert_true(dbc.connect(dsn)?)

      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_reconnect (id INTEGER)")?

      // Disconnect
      h.assert_true(dbc.disconnect()?)

      // Reconnect
      h.assert_true(dbc.connect(dsn)?)

      // Verify we can create a new statement after reconnect
      var stm2: ODBCStmt = dbc.stmt()?
      stm2.direct_exec("CREATE TEMPORARY TABLE test_reconnect2 (id INTEGER)")?

      var id_in: SQLInteger = SQLInteger
      stm2.prepare("INSERT INTO test_reconnect2 VALUES (?)")?
      stm2.bind_parameter(id_in)?

      id_in.write(42)
      stm2.execute()?
      stm2.finish()?

      // Verify insert worked
      var id_out: SQLInteger = SQLInteger
      stm2.prepare("SELECT id FROM test_reconnect2")?
      stm2.bind_column(id_out)?
      stm2.execute()?

      h.assert_true(stm2.fetch()?)
      h.assert_eq[I32](42, id_out.read()?)
      stm2.finish()?
    else
      h.fail("test_connection_reconnect failed")
    end
