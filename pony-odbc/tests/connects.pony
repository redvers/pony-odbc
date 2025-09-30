use "debug"
use "pony_test"
use "format"
use ".."

class \nodoc\ iso _TestConnects is UnitTest
  fun name(): String val => "_TestConnects"

  fun apply(h: TestHelper) ? =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?
      // Unknown ODBC Identifier
      must_error(h, dbc, "IDontExist", "IM002")
      // Unknown Driver .so file
      must_error(h, dbc, "psqlred_baddriver", "01000")
      // Unknown PostgreSQL Server
      must_error(h, dbc, "psqlred_badserver", "08001")
      // Unknown Postgresql User
      must_error(h, dbc, "psqlred_baduser", "08001")
      // Unknown Postgresql Database
      must_error(h, dbc, "psqlred_baddatabase", "08001")
      // Unknown MariaDB User
      must_error(h, dbc, "mariadb_baduser", "28000")
      // Unknown MariaDB database
      must_error(h, dbc, "mariadb_baddatabase", "42000")
    else
      h.fail("Failed here")
      error
    end

  fun must_error(h: TestHelper, dbc: ODBCDbc, dsn: String val, value: String val) =>
    try
      dbc.connect(dsn)?
    else
      try
        var a: Array[(String val, String val)] val = dbc.sqlstates()
        h.assert_eq[String val](value, a(a.size() - 1)?._1)
      else
        h.fail("Did not get a DBC error for " + dsn)
      end
    end

