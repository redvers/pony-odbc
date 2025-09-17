use "debug"
use ".."
use "pony_test"

class \nodoc\ iso _TestDatabase is UnitTest
  var dsn: String val
  fun name(): String val => "_TestDatabase(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) ? =>
    var env: ODBCEnv = ODBCEnv
    try
      env.set_odbc3()?
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.set_application_name("TestDatabase")?)

      h.assert_true(dbc.connect(dsn)?)
      h.assert_eq[String]("SQLSuccess", dbc.get_err().string())
    else
      h.fail("Yeah - we failed")
      error
    end

    /*
    (var r: SQLReturn val, var s: String val) = dbc.get_info(SqlDBMSName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    if (dsn == "psqlred") then h.assert_eq[String]("PostgreSQL", s) end
    if (dsn == "mariadb") then h.assert_eq[String]("MariaDB", s) end
    if (dsn == "sqlitedb3") then h.assert_eq[String]("SQLite", s) end

    (r, s) = dbc.get_info(SqlDBMSVer)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("Version: " + s)

    (r, s) = dbc.get_info(SqlDataSourceName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("DataSourceName: " + s)

    (r, s) = dbc.get_info(SqlDriverName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("DriverName: " + s)

    (r, s) = dbc.get_info(SqlServerName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("ServerName: " + s)

    (r, s) = dbc.get_info(SqlDatabaseName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("DatabaseName: " + s)

    (r, s) = dbc.get_info(SqlUserName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("UserName: " + s)

    (r, s) = dbc.get_info(SqlCatalogName)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("CatalogName: " + s)

    (r, s) = dbc.get_info(SqlDriverODBCVer)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("DriverODBCVersion: " + s)

    (r, s) = dbc.get_info(SqlDriverVer)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("DriverVer: " + s)

    (r, s) = dbc.get_info(SqlODBCVer)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("ODBCVer: " + s)

    (r, s) = dbc.get_info(SqlDMVer)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    Debug.out("DMVer: " + s)

    (r, var i: I32) = ODBCDbcFFI.get_attr_i32(dbc.dbc, SqlAttrAccessMode)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    h.assert_eq[I32](0, i)

    (r, i) = ODBCDbcFFI.get_attr_i32(dbc.dbc, SqlAttrAutoCommit)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    h.assert_eq[I32](1, i)

    (r, i) = ODBCDbcFFI.get_attr_i32(dbc.dbc, SqlAttrTrace)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    h.assert_eq[I32](0, i)
    */
