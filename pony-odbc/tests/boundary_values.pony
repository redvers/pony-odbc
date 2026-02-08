use "debug"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestBoundaryValues is UnitTest
  """
  Tests boundary and extreme values for all numeric SQL types.
  Validates min/max values for INTEGER, BIGINT, SMALLINT, FLOAT, and REAL.
  """
  var dsn: String val
  fun name(): String val => dsn + "/_TestBoundaryValues"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      test_smallint_boundaries(h, dbc)
      test_integer_boundaries(h, dbc)
      test_bigint_boundaries(h, dbc)
      test_float_boundaries(h, dbc)
      test_real_boundaries(h, dbc)
      test_zero_values(h, dbc)
      test_negative_boundaries(h, dbc)
    else
      h.fail("Failed to connect or run boundary tests")
    end

  fun test_smallint_boundaries(h: TestHelper, dbc: ODBCDbc) =>
    """Test SMALLINT min/max values (I16: -32768 to 32767)"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_smallint (val SMALLINT)")?

      var input: SQLSmallInteger = SQLSmallInteger
      var output: SQLSmallInteger = SQLSmallInteger

      stm.prepare("INSERT INTO test_smallint VALUES (?)")?
      stm.bind_parameter(input)?

      // Test maximum value
      input.write(32767)
      stm.execute()?
      stm.finish()?

      // Test minimum value
      input.write(-32768)
      stm.execute()?
      stm.finish()?

      // Verify values
      stm.prepare("SELECT val FROM test_smallint ORDER BY val")?
      stm.bind_column(output)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I16](-32768, output.read()?)

      h.assert_true(stm.fetch()?)
      h.assert_eq[I16](32767, output.read()?)

      h.assert_false(stm.fetch()?)
      stm.finish()?
    else
      h.fail("test_smallint_boundaries failed")
    end

  fun test_integer_boundaries(h: TestHelper, dbc: ODBCDbc) =>
    """Test INTEGER min/max values (I32: -2147483648 to 2147483647)"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_integer (val INTEGER)")?

      var input: SQLInteger = SQLInteger
      var output: SQLInteger = SQLInteger

      stm.prepare("INSERT INTO test_integer VALUES (?)")?
      stm.bind_parameter(input)?

      // Test maximum value
      input.write(2147483647)
      stm.execute()?
      stm.finish()?

      // Test minimum value
      input.write(-2147483648)
      stm.execute()?
      stm.finish()?

      // Verify values
      stm.prepare("SELECT val FROM test_integer ORDER BY val")?
      stm.bind_column(output)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](-2147483648, output.read()?)

      h.assert_true(stm.fetch()?)
      h.assert_eq[I32](2147483647, output.read()?)

      h.assert_false(stm.fetch()?)
      stm.finish()?
    else
      h.fail("test_integer_boundaries failed")
    end

  fun test_bigint_boundaries(h: TestHelper, dbc: ODBCDbc) =>
    """Test BIGINT min/max values (I64)"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_bigint (val BIGINT)")?

      var input: SQLBigInteger = SQLBigInteger
      var output: SQLBigInteger = SQLBigInteger

      stm.prepare("INSERT INTO test_bigint VALUES (?)")?
      stm.bind_parameter(input)?

      // Test maximum value
      input.write(9223372036854775807)
      stm.execute()?
      stm.finish()?

      // Test minimum value
      input.write(-9223372036854775808)
      stm.execute()?
      stm.finish()?

      // Verify values
      stm.prepare("SELECT val FROM test_bigint ORDER BY val")?
      stm.bind_column(output)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I64](-9223372036854775808, output.read()?)

      h.assert_true(stm.fetch()?)
      h.assert_eq[I64](9223372036854775807, output.read()?)

      h.assert_false(stm.fetch()?)
      stm.finish()?
    else
      h.fail("test_bigint_boundaries failed")
    end

  fun test_float_boundaries(h: TestHelper, dbc: ODBCDbc) =>
    """Test FLOAT extreme values (F32)"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_float (val FLOAT)")?

      var input: SQLFloat = SQLFloat
      var output: SQLFloat = SQLFloat

      stm.prepare("INSERT INTO test_float VALUES (?)")?
      stm.bind_parameter(input)?

      // Test very large value
      input.write(3.4028234e38)
      stm.execute()?
      stm.finish()?

      // Test very small positive value
      input.write(1.17549435e-38)
      stm.execute()?
      stm.finish()?

      // Test negative large value
      input.write(-3.4028234e38)
      stm.execute()?
      stm.finish()?

      stm.finish()?
    else
      h.fail("test_float_boundaries failed")
    end

  fun test_real_boundaries(h: TestHelper, dbc: ODBCDbc) =>
    """Test REAL extreme values (F64)"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      if (dsn == "psqlred") then
        // Postgres REAL is 32 bit, so to test it we need to override
        stm.direct_exec("CREATE TEMPORARY TABLE test_real (val FLOAT)")?
      else
        stm.direct_exec("CREATE TEMPORARY TABLE test_real (val REAL)")?
      end

      var input: SQLReal = SQLReal
      var output: SQLReal = SQLReal

      stm.prepare("INSERT INTO test_real VALUES (?)")?
      stm.bind_parameter(input)?

      // Test very large value
      input.write(1.7976931348623157e308)
      stm.execute()?
      stm.finish()?

      // Test very small positive value
      input.write(2.2250738585072014e-308)
      stm.execute()?
      stm.finish()?

      stm.finish()?
    else
      h.fail("test_real_boundaries failed")
    end

  fun test_zero_values(h: TestHelper, dbc: ODBCDbc) =>
    """Test that zero values work correctly for all numeric types"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_zeros (si SMALLINT, i INTEGER, bi BIGINT, f FLOAT, r REAL)")?

      var si_in: SQLSmallInteger = SQLSmallInteger
      var i_in: SQLInteger = SQLInteger
      var bi_in: SQLBigInteger = SQLBigInteger
      var f_in: SQLFloat = SQLFloat
      var r_in: SQLReal = SQLReal

      stm.prepare("INSERT INTO test_zeros VALUES (?, ?, ?, ?, ?)")?
      stm.bind_parameter(si_in)?
      stm.bind_parameter(i_in)?
      stm.bind_parameter(bi_in)?
      stm.bind_parameter(f_in)?
      stm.bind_parameter(r_in)?

      si_in.write(0)
      i_in.write(0)
      bi_in.write(0)
      f_in.write(0.0)
      r_in.write(0.0)

      stm.execute()?
      stm.finish()?

      // Verify
      var si_out: SQLSmallInteger = SQLSmallInteger
      var i_out: SQLInteger = SQLInteger
      var bi_out: SQLBigInteger = SQLBigInteger
      var f_out: SQLFloat = SQLFloat
      var r_out: SQLReal = SQLReal

      stm.prepare("SELECT * FROM test_zeros")?
      stm.bind_column(si_out)?
      stm.bind_column(i_out)?
      stm.bind_column(bi_out)?
      stm.bind_column(f_out)?
      stm.bind_column(r_out)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I16](0, si_out.read()?)
      h.assert_eq[I32](0, i_out.read()?)
      h.assert_eq[I64](0, bi_out.read()?)
      h.assert_eq[F32](0.0, f_out.read()?)
      h.assert_eq[F64](0.0, r_out.read()?)

      stm.finish()?
    else
      h.fail("test_zero_values failed")
    end

  fun test_negative_boundaries(h: TestHelper, dbc: ODBCDbc) =>
    """Test negative one values for all types"""
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec("CREATE TEMPORARY TABLE test_neg (si SMALLINT, i INTEGER, bi BIGINT, f FLOAT, r REAL)")?

      var si_in: SQLSmallInteger = SQLSmallInteger
      var i_in: SQLInteger = SQLInteger
      var bi_in: SQLBigInteger = SQLBigInteger
      var f_in: SQLFloat = SQLFloat
      var r_in: SQLReal = SQLReal

      stm.prepare("INSERT INTO test_neg VALUES (?, ?, ?, ?, ?)")?
      stm.bind_parameter(si_in)?
      stm.bind_parameter(i_in)?
      stm.bind_parameter(bi_in)?
      stm.bind_parameter(f_in)?
      stm.bind_parameter(r_in)?

      si_in.write(-1)
      i_in.write(-1)
      bi_in.write(-1)
      f_in.write(-1.0)
      r_in.write(-1.0)

      stm.execute()?
      stm.finish()?

      var si_out: SQLSmallInteger = SQLSmallInteger
      var i_out: SQLInteger = SQLInteger
      var bi_out: SQLBigInteger = SQLBigInteger

      stm.prepare("SELECT si, i, bi FROM test_neg")?
      stm.bind_column(si_out)?
      stm.bind_column(i_out)?
      stm.bind_column(bi_out)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_eq[I16](-1, si_out.read()?)
      h.assert_eq[I32](-1, i_out.read()?)
      h.assert_eq[I64](-1, bi_out.read()?)

      stm.finish()?
    else
      h.fail("test_negative_boundaries failed")
    end
