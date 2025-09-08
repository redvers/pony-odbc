use "debug"
use ".."
use "pony_test"
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"
use "../attributes"
use "../instrumentation"

class \nodoc\ iso _TestInteger is UnitTest
  var dsn: String val
  fun name(): String val => "_TestInteger(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())
    h.assert_true(dbc.set_application_name("TestInteger"))

    h.assert_true(dbc.connect(dsn))
    h.assert_eq[String]("SQLSuccess", dbc.err.string())

    var pcmp: _TestIntegerModel iso = _TestIntegerModel

    /* Create a temporary table */
    var st: ODBCSth = ODBCSth(dbc)
    h.assert_true(st.exec_direct("create temporary table integer_tests (i integer)"))
    h.assert_true(st.exec_direct("insert into integer_tests values  (0)"))
    h.assert_true(st.exec_direct("insert into integer_tests values  (0)"))
    h.assert_true(st.exec_direct("insert into integer_tests values  (-2147483648)"))
    h.assert_false(st.exec_direct("insert into integer_tests values (-2147483649)"))
    h.assert_true(st.exec_direct("insert into integer_tests values  (2147483647)"))
    h.assert_false(st.exec_direct("insert into integer_tests values (2147483648)"))


    var stmta: ODBCSth = ODBCSth(dbc, consume pcmp)
    h.assert_is[SQLReturn val](SQLSuccess, stmta.err)
    h.assert_true(stmta.prepare())
    show_error(stmta)
    h.assert_true(stmta.execute[I32](10))
    (var s: Bool, var cnt: USize) = stmta.result_count()
    show_error(stmta)
    h.assert_true(s)
    h.assert_eq[USize](1, cnt)

    (var bool: Bool, var result: ODBCResultOut) = stmta.fetch()
    h.assert_true(bool)
    try
      h.assert_eq[I32](2147483647, (result as _PCMResultI).integer)
    else
      h.fail("Return datatype is incorrect")
    end
    (bool, result) = stmta.fetch()
    h.assert_false(bool)

  fun show_error(stmta: ODBCSth) =>
    var err: SQLReturn val = recover val SQLError.create_pstmt(stmta.stmt) end
    try
      if (false) then error end
      for f in (stmta.err as SQLError val).get_records().values() do
        Debug.out(f)
      end
      true
    end
