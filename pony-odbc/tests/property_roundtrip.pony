use "pony_test"
use ".."
use "collections"
use "random"

class \nodoc\ iso _PropertyDBRoundtrip is UnitTest
  """
  Property-style database roundtrip tests using random values.
  Generates random I16/I32/I64 and string values, inserts them via
  parameterized queries, reads them back, and verifies equality.
  """
  var dsn: String val
  fun name(): String val => dsn + "/_PropertyDBRoundtrip"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      test_integer_roundtrip(h, dbc)
      test_string_roundtrip(h, dbc)
      test_null_roundtrip(h, dbc)
    else
      h.fail("Failed to connect in _PropertyDBRoundtrip")
    end

  fun test_integer_roundtrip(h: TestHelper, dbc: ODBCDbc) =>
    """
    Insert 100 random integer triples (I16, I32, I64), read them back
    in insertion order, and verify each value survives the roundtrip.
    """
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec(
        "CREATE TEMPORARY TABLE prop_ints " +
        "(seq INTEGER, si SMALLINT, ii INTEGER, bi BIGINT)")?

      var seq_in: SQLInteger = SQLInteger
      var si_in: SQLSmallInteger = SQLSmallInteger
      var ii_in: SQLInteger = SQLInteger
      var bi_in: SQLBigInteger = SQLBigInteger

      stm.prepare("INSERT INTO prop_ints VALUES (?, ?, ?, ?)")?
      stm.bind_parameter(seq_in)?
      stm.bind_parameter(si_in)?
      stm.bind_parameter(ii_in)?
      stm.bind_parameter(bi_in)?

      let rand = Rand(42)
      let expected = Array[(I16, I32, I64)]

      for i in Range[I32](0, 100) do
        let si_val = rand.next().i16()
        let ii_val = rand.next().i32()
        let bi_val = rand.next().i64()
        expected.push((si_val, ii_val, bi_val))
        seq_in.write(i)
        si_in.write(si_val)
        ii_in.write(ii_val)
        bi_in.write(bi_val)
        stm.execute()?
      end
      stm.finish()?

      // Read back in insertion order
      var seq_out: SQLInteger = SQLInteger
      var si_out: SQLSmallInteger = SQLSmallInteger
      var ii_out: SQLInteger = SQLInteger
      var bi_out: SQLBigInteger = SQLBigInteger

      stm.prepare("SELECT seq, si, ii, bi FROM prop_ints ORDER BY seq")?
      stm.bind_column(seq_out)?
      stm.bind_column(si_out)?
      stm.bind_column(ii_out)?
      stm.bind_column(bi_out)?
      stm.execute()?

      var idx: USize = 0
      while stm.fetch()? do
        let exp = expected(idx)?
        h.assert_eq[I16](exp._1, si_out.read()?)
        h.assert_eq[I32](exp._2, ii_out.read()?)
        h.assert_eq[I64](exp._3, bi_out.read()?)
        idx = idx + 1
      end
      h.assert_eq[USize](100, idx)
      stm.finish()?
    else
      h.fail("test_integer_roundtrip failed")
    end

  fun test_string_roundtrip(h: TestHelper, dbc: ODBCDbc) =>
    """
    Insert 50 random alphanumeric strings, read them back in insertion
    order, and verify each survives the roundtrip.
    """
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec(
        "CREATE TEMPORARY TABLE prop_strings (seq INTEGER, vc VARCHAR(200))")?

      var seq_in: SQLInteger = SQLInteger
      var vc_in: SQLVarchar = SQLVarchar(200)

      stm.prepare("INSERT INTO prop_strings VALUES (?, ?)")?
      stm.bind_parameter(seq_in)?
      stm.bind_parameter(vc_in)?

      let rand = Rand(123)
      let alphabet: String val =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
      let expected = Array[String val]

      for i in Range[I32](0, 50) do
        let len = ((rand.next() % 100) + 1).usize()
        let s = recover val
          let buf = String(len)
          for _ in Range(0, len) do
            let ci = (rand.next() % alphabet.size().u64()).usize()
            try buf.push(alphabet(ci)?) end
          end
          buf
        end
        expected.push(s)
        seq_in.write(i)
        vc_in.write(s)
        stm.execute()?
      end
      stm.finish()?

      // Read back in insertion order
      var seq_out: SQLInteger = SQLInteger
      var vc_out: SQLVarchar = SQLVarchar(200)

      stm.prepare("SELECT seq, vc FROM prop_strings ORDER BY seq")?
      stm.bind_column(seq_out)?
      stm.bind_column(vc_out)?
      stm.execute()?

      var idx: USize = 0
      while stm.fetch()? do
        let exp = expected(idx)?
        h.assert_eq[String val](exp, vc_out.read()?)
        idx = idx + 1
      end
      h.assert_eq[USize](50, idx)
      stm.finish()?
    else
      h.fail("test_string_roundtrip failed")
    end

  fun test_null_roundtrip(h: TestHelper, dbc: ODBCDbc) =>
    """
    Insert a row with all NULL values and verify they read back as null.
    """
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.direct_exec(
        "CREATE TEMPORARY TABLE prop_nulls " +
        "(si SMALLINT, ii INTEGER, bi BIGINT, vc VARCHAR(100))")?

      var si_in: SQLSmallInteger = SQLSmallInteger
      var ii_in: SQLInteger = SQLInteger
      var bi_in: SQLBigInteger = SQLBigInteger
      var vc_in: SQLVarchar = SQLVarchar(100)

      stm.prepare("INSERT INTO prop_nulls VALUES (?, ?, ?, ?)")?
      stm.bind_parameter(si_in)?
      stm.bind_parameter(ii_in)?
      stm.bind_parameter(bi_in)?
      stm.bind_parameter(vc_in)?

      // All parameters start as null, so this inserts NULLs
      stm.execute()?
      stm.finish()?

      // Read back and verify nulls
      var si_out: SQLSmallInteger = SQLSmallInteger
      var ii_out: SQLInteger = SQLInteger
      var bi_out: SQLBigInteger = SQLBigInteger
      var vc_out: SQLVarchar = SQLVarchar(100)

      stm.prepare("SELECT * FROM prop_nulls")?
      stm.bind_column(si_out)?
      stm.bind_column(ii_out)?
      stm.bind_column(bi_out)?
      stm.bind_column(vc_out)?
      stm.execute()?

      h.assert_true(stm.fetch()?)
      h.assert_true(si_out.is_null(), "si should be null after roundtrip")
      h.assert_true(ii_out.is_null(), "ii should be null after roundtrip")
      h.assert_true(bi_out.is_null(), "bi should be null after roundtrip")
      h.assert_true(vc_out.is_null(), "vc should be null after roundtrip")

      h.assert_false(stm.fetch()?)
      stm.finish()?
    else
      h.fail("test_null_roundtrip failed")
    end
