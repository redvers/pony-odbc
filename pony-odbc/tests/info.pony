

use "debug"
use "pony_test"
use "collections"
use ".."
use "../ffi"

class \nodoc\ iso _MariaDBInfo is UnitTest
  var dsn: String val

  new create(dsn': String val) =>
    dsn = dsn'

  fun name(): String val => "_MariaDBInfo(" + dsn + ")"

  fun apply(h: TestHelper) ? =>
    var env: ODBCEnv = ODBCEnv
    var dbh: ODBCDbc = env.dbc()?
    dbh.connect(dsn)?

    try get_type_info(h, dbh)? else h.fail("Failed in get_type_info") end
    try sql_get_type_info(h, dbh)? else h.fail("Failed in sql_get_type_info") end

    try
      var dbc: ODBCDbc = env.dbc()?
    else
      try
      Debug.out(env.sqlstates()(0)?._1 + ": " + env.sqlstates()(0)?._2)
      end
    end

  fun get_type_info(h: TestHelper, dbh: ODBCDbc) ? =>
    var sth: ODBCStmt = dbh.stmt()?

    sth.get_type_info()?
    var result_cols: CBoxedI16 = CBoxedI16
    h.assert_true(sth.num_result_cols(result_cols)?)
    h.assert_eq[I16](19, result_cols.value)
    h.assert_true(sth.finish()?)

  fun sql_get_type_info(h: TestHelper, dbh: ODBCDbc) ? =>
    var buf: SQLVarchar = SQLVarchar(512)
    dbh.get_info(6, buf)?  // SQL_DRIVER_NAME
    var nm: String = buf.string()
    buf.reset()
    dbh.get_info(77, buf)? // SQL_DRIVER_ODBC_VER
    var vr: String = buf.string()
    Debug.out("[" + dsn + "]: " + nm + " → " + vr)

    // Need to distinguish for actual integers vs stringified integers.
