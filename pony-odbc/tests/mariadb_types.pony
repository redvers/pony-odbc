use "debug"
use "pony_test"
use ".."
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"
use "../attributes"
use "../instrumentation"

class \nodoc\ iso _TestMariaDBTypes is UnitTest
  var dsn: String val

  new create(dsn': String val) => dsn = dsn'

  fun name(): String val => "_TestMariaDBTypes(" + dsn + ")"

  fun apply(h: TestHelper) =>
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())
    h.assert_true(dbc.set_application_name("TestMariaDBTypes"))

    h.assert_true(dbc.connect(dsn))
    h.assert_eq[String]("SQLSuccess", dbc.err.string())

    /* Create temporary tables */
    var numerics: ODBCSth = ODBCSth(dbc)
    var numericsql: String val = "create temporary table test_mariadb_numerics (" +
                                    "mtinyint tinyint, " +
                                    "msmallint smallint, " +
                                    "mmediumint mediumint, " +
                                    "mint int, " +
                                    "mbigint bigint, " +
                                    "mfloat float, " +
                                    "mdouble double, " +
                                    "mdecimal decimal, " +
                                    "mbit bit" +
                                    ")"

    h.assert_true(numerics.exec_direct(numericsql))
    var numerics_q: String val = "select * from test_mariadb_numerics where " +
                                    "mtinyint = ? AND " +
                                    "msmallint = ? AND " +
                                    "mmediumint = ? AND " +
                                    "mint = ? AND " +
                                    "mbigint = ? AND " +
                                    "mfloat = ? AND " +
                                    "mdouble = ? AND " +
                                    "mdecimal = ? AND " +
                                    "mbit = ?"

    var err: SQLReturn val = ODBCStmtFFI.prepare(numerics.stmt, numerics_q)
    show_error(numerics)

    show_both(h, numerics.stmt, 1, "mtinyint")
    show_both(h, numerics.stmt, 2, "msmallint")
    show_both(h, numerics.stmt, 3, "mmediumint")
    show_both(h, numerics.stmt, 4, "mint")
    show_both(h, numerics.stmt, 5, "mbigint")
    show_both(h, numerics.stmt, 6, "mfloat")
    show_both(h, numerics.stmt, 7, "mdouble")
    show_both(h, numerics.stmt, 8, "mdecimal")
    show_both(h, numerics.stmt, 9, "mbit")




  fun show_both(h: TestHelper, hh: ODBCHandleStmt tag, col: U16, name': String val) =>
    var paro: SQLDescribeParamOut = SQLDescribeParamOut(col)
    var colo: SQLDescribeColOut = SQLDescribeColOut(col)

    h.assert_is[SQLReturn val](SQLSuccess, ODBCStmtFFI.describe_column(hh, colo, name'))
    h.assert_is[SQLReturn val](SQLSuccess, ODBCStmtFFI.describe_param(hh, paro))

    Debug.out("\nColumn Number: " + paro.param_number.string() + "          " + colo.column_number.string())
    Debug.out("Column Name:   " + name'       + "          " + colo.column_name.string())
    Debug.out("Data Type:     " + paro.data_type_ptr.value.string() + "          " + colo.datatype_ptr.value.string())
    Debug.out("Parameter Size:" + paro.parameter_size_ptr.value.string() + "          " + colo.colsize_ptr.value.string())

/*
    /* Attempt to create the same table again - this WILL fail */
    h.assert_false(stmt.exec_direct("create temp table test_exec_direct (foo integer)"))
    var er: SQLError val = recover val SQLError.create_pstmt(stmt.stmt) end
    try
      match dsn
      | "mariadb" => h.assert_eq[String val]("42000", er.get_tuples()(0)?._2)
      | "psqlred" => h.assert_eq[String val]("42P07", er.get_tuples()(0)?._2)
      else
        h.fail("Add support for the new dsn here")
      end
    else
      h.fail("We got an empty SQLError - this should never happen™")
    end


    /* Insert a single value into the table */
    h.assert_true(stmt.exec_direct("insert into test_exec_direct values (0)"))

    /* This select will execute, but there is no facility for getting the
     * results.  We just use result_count() to ensure we have the correct
     * number (1)                                                         */
    h.assert_true(stmt.exec_direct("select * from test_exec_direct"))
    (bool, cnt) = stmt.result_count()
    h.assert_true(bool)
    h.assert_eq[USize](1, cnt)

    /* Close the cursor */
    h.assert_true(stmt.finish())

    /* Insert another three rows */
    h.assert_true(stmt.exec_direct("insert into test_exec_direct values (0)"))
    h.assert_true(stmt.exec_direct("insert into test_exec_direct values (1)"))
    h.assert_true(stmt.exec_direct("insert into test_exec_direct values (2)"))

    /* Select all the rows, count should be 4 */
    h.assert_true(stmt.exec_direct("select * from test_exec_direct"))
    (bool, cnt) = stmt.result_count()
    h.assert_true(bool)
    h.assert_eq[USize](4, cnt)
    h.assert_true(stmt.finish())

    /* Delete all rows from the table.  result_count() will report how
     * many rows were affected (ie, deleted) (4)                        */
    h.assert_true(stmt.exec_direct("delete from test_exec_direct"))
    (bool, cnt) = stmt.result_count()
    h.assert_true(bool)
    h.assert_eq[USize](4, cnt)

    /* Select to ensure there are no rows left */
    h.assert_true(stmt.exec_direct("select * from test_exec_direct"))
    (bool, cnt) = stmt.result_count()
    h.assert_true(bool)
    h.assert_eq[USize](0, cnt)
    h.assert_true(stmt.finish())
*/
  fun show_error(stmta: ODBCSth) =>
    var err: SQLReturn val = recover val SQLError.create_pstmt(stmta.stmt) end
    try
      if (false) then error end
      for f in (stmta.err as SQLError val).get_records().values() do
        Debug.out(f)
      end
      true
    end



