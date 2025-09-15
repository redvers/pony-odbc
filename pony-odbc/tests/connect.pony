use "pony_test"
use ".."

class \nodoc\ iso _TestConnect is UnitTest
  var dsn: String val

  new create(dsn': String val) =>
    dsn = dsn'

  fun name(): String val => "_TestConnect(" + dsn + ")"

  fun apply(h: TestHelper) =>
    h.assert_true(true)
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())
    h.assert_true(dbc.set_application_name("_Postgres"))

    h.assert_true(dbc.connect(dsn))

