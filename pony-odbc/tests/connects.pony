use "debug"
use "pony_test"
use "format"
use ".."
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"
use "../attributes"
use "../instrumentation"

class \nodoc\ iso _TestConnects is UnitTest
  fun name(): String val => "_TestConnects"

  fun apply(h: TestHelper) =>
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())

    // Unknown ODBC Identifier
    h.assert_false(dbc.connect("IDontExist"))
    h.assert_eq[String]("SQLError", dbc.err.string())

    var err: SQLError val = SQLError.create_pdbc(dbc.dbc)
    try
      h.assert_eq[String val]("IM002", err.get_tuples()(0)?._2)
    else
      h.fail("SQLError contents not found: " + err.string())
    end

    // Unknown Driver .so file
    h.assert_false(dbc.connect("psqlred_baddriver"))
    h.assert_eq[String]("SQLError", dbc.err.string())

    err = SQLError.create_pdbc(dbc.dbc)
    try
      h.assert_eq[String val]("01000", err.get_tuples()(0)?._2)
    else
      h.fail("SQLError contents not found: " + err.string())
    end

    // Unknown PostgreSQL Server
    h.assert_false(dbc.connect("psqlred_badserver"))
    h.assert_eq[String]("SQLError", dbc.err.string())

    err = SQLError.create_pdbc(dbc.dbc)
    try
      h.assert_eq[String val]("08001", err.get_tuples()(0)?._2)
    else
      h.fail("SQLError contents not found: " + err.string())
    end

    // Unknown Postgresql User
    h.assert_false(dbc.connect("psqlred_baduser"))
    h.assert_eq[String]("SQLError", dbc.err.string())

    err = SQLError.create_pdbc(dbc.dbc)
    try
      h.assert_eq[String val]("08001", err.get_tuples()(0)?._2)
    else
      h.fail("SQLError contents not found: " + err.string())
    end

    // Unknown Postgresql Database
    h.assert_false(dbc.connect("psqlred_baddatabase"))
    h.assert_eq[String]("SQLError", dbc.err.string())

    err = SQLError.create_pdbc(dbc.dbc)
    try
      h.assert_eq[String val]("08001", err.get_tuples()(0)?._2)
    else
      h.fail("SQLError contents not found: " + err.string())
    end

    // Unknown MariaDB User
    h.assert_false(dbc.connect("mariadb_baduser"))
    h.assert_eq[String]("SQLError", dbc.err.string())

    err = SQLError.create_pdbc(dbc.dbc)
    try
      h.assert_eq[String val]("HY000", err.get_tuples()(0)?._2)
    else
      h.fail("SQLError contents not found: " + err.string())
    end

    // Unknown MariaDB database
    h.assert_false(dbc.connect("mariadb_baddatabase"))
    h.assert_eq[String]("SQLError", dbc.err.string())

    err = SQLError.create_pdbc(dbc.dbc)
    try
      h.assert_eq[String val]("HY000", err.get_tuples()(0)?._2)
    else
      h.fail("SQLError contents not found: " + err.string())
    end

