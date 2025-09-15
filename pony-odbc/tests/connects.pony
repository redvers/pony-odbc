use "debug"
use "pony_test"
use "format"
use ".."
use "../env"
use "../dbc"
use "../stmt"

class \nodoc\ iso _TestConnects is UnitTest
  fun name(): String val => "_TestConnects"

  fun apply(h: TestHelper) ? =>
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())

    // Unknown ODBC Identifier
    h.assert_false(dbc.connect("IDontExist"))
    h.assert_eq[String]("SQLError", dbc.get_err().string())
    h.assert_eq[String val]("IM002", (dbc.get_err() as SQLError val).latest_sqlstate())
    h.assert_eq[USize](1, (dbc.get_err() as SQLError val).sqlstates().size())

    // Unknown Driver .so file
    h.assert_false(dbc.connect("psqlred_baddriver"))
    h.assert_eq[String]("SQLError", dbc.get_err().string())
    h.assert_eq[String val]("01000", (dbc.get_err() as SQLError val).latest_sqlstate())
    h.assert_eq[USize](1, (dbc.get_err() as SQLError val).sqlstates().size())

    // Unknown PostgreSQL Server
    h.assert_false(dbc.connect("psqlred_badserver"))
    h.assert_eq[String]("SQLError", dbc.get_err().string())
    h.assert_eq[String val]("08001", (dbc.get_err() as SQLError val).latest_sqlstate())
    h.assert_eq[USize](1, (dbc.get_err() as SQLError val).sqlstates().size())

    // Unknown Postgresql User
    h.assert_false(dbc.connect("psqlred_baduser"))
    h.assert_eq[String]("SQLError", dbc.get_err().string())
    h.assert_eq[String val]("08001", (dbc.get_err() as SQLError val).latest_sqlstate())
    h.assert_eq[USize](1, (dbc.get_err() as SQLError val).sqlstates().size())

    // Unknown Postgresql Database
    h.assert_false(dbc.connect("psqlred_baddatabase"))
    h.assert_eq[String]("SQLError", dbc.get_err().string())
    h.assert_eq[String val]("08001", (dbc.get_err() as SQLError val).latest_sqlstate())
    h.assert_eq[USize](1, (dbc.get_err() as SQLError val).sqlstates().size())

    // Unknown MariaDB User
    h.assert_false(dbc.connect("mariadb_baduser"))
    h.assert_eq[String]("SQLError", dbc.get_err().string())
    h.assert_eq[String val]("28000", (dbc.get_err() as SQLError val).latest_sqlstate())
    h.assert_eq[USize](1, (dbc.get_err() as SQLError val).sqlstates().size())

    // Unknown MariaDB database
    h.assert_false(dbc.connect("mariadb_baddatabase"))
    h.assert_eq[String]("SQLError", dbc.get_err().string())
    h.assert_eq[String val]("42000", (dbc.get_err() as SQLError val).latest_sqlstate())
    h.assert_eq[USize](1, (dbc.get_err() as SQLError val).sqlstates().size())

