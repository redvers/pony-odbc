use "debug"
use ".."
use "pony_test"
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"
use "../attributes"
use "../instrumentation"

class \nodoc\ iso _TestDatabase is UnitTest
  var dsn: String val
  fun name(): String val => "_TestDatabase(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())
    h.assert_true(dbc.set_application_name("TestDatabase"))

    h.assert_true(dbc.connect(dsn))
    h.assert_eq[String]("SQLSuccess", dbc.err.string())

    (var r: SQLReturn val, var s: String val) = dbc.get_info(SqlDBMSName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    if (dsn == "psqlred") then h.assert_eq[String]("PostgreSQL", s) end
    if (dsn == "mariadb") then h.assert_eq[String]("MariaDB", s) end
    if (dsn == "sqlitedb3") then h.assert_eq[String]("SQLite", s) end

    (r, s) = dbc.get_info(SqlDBMSVer)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("Version: " + s)


