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

class \nodoc\ iso _TestPGMariaDBTypes is UnitTest
  var pgdsn: String val
  var mariadsn: String val

  new create(pgdsn': String val, mariadsn': String val) =>
    pgdsn = pgdsn'
    mariadsn = mariadsn'

  fun name(): String val => "_TestPGMariaTypes(" + pgdsn + "/" + mariadsn + ")"

  fun apply(h: TestHelper) =>
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var mdbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(mdbc.is_valid())
    h.assert_true(mdbc.set_application_name("TestMariaDBTypes"))
    h.assert_true(mdbc.connect(mariadsn))
    h.assert_eq[String]("SQLSuccess", mdbc.err.string())

    var pdbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(pdbc.is_valid())
    h.assert_true(pdbc.set_application_name("TestPostgresDBTypes"))
    h.assert_true(pdbc.connect(pgdsn))
    h.assert_eq[String]("SQLSuccess", pdbc.err.string())

/*
 *  MARIA DB                PostgreSQL      Pony
 *
 * tinyint                  X
 * smallint                 smallint        I16
 * mediumint                X
 * int                      int             I32
 * bigint                   bigint          I64
 * float (F32)              real (F32)
 * real (F64)               float (F64)
 * double (F64)             double
 * decimal                  decimal
 * bit                      X
 *
 * COMMON TYPES ARE:
 * smallint                 smallint
 * int                      int
 * bigint                   bigint
 * float                    real      // These types do NOT match across since
 * double                   double    // it is defined completely differently
 * decimal                  decimal
*/

    /* Create temporary tables */
    var numericsql: String val = "create temporary table test_mariadb_numerics (" +
                                    "msmallint smallint, " +
                                    "mint int, " +
                                    "mbigint bigint, " +
                                    "mfloat float, " +
                                    "mreal real, " +
                                    "mdecimal decimal" +
                                    ")"

    var mnumerics: ODBCSth = ODBCSth(mdbc)
    var pnumerics: ODBCSth = ODBCSth(pdbc)

    h.assert_true(mnumerics.exec_direct(numericsql))
    h.assert_true(pnumerics.exec_direct(numericsql))

    var numerics_q: String val = "select * from test_mariadb_numerics where " +
                                    "msmallint = ? AND " +
                                    "mint = ? AND " +
                                    "mbigint = ? AND " +
                                    "mfloat = ? AND " +
                                    "mreal = ? AND " +
                                    "mdecimal = ?"

    h.assert_is[SQLReturn val](SQLSuccess, (ODBCStmtFFI.prepare(mnumerics.stmt, numerics_q)))
    h.assert_is[SQLReturn val](SQLSuccess, (ODBCStmtFFI.prepare(pnumerics.stmt, numerics_q)))

    Debug.out("| #  | Column Name      | Parameter Values (dt / sz)| Column Values    (dt / sz)|")
    Debug.out("|    |                  | MariaDB     |    Postgres | MariaDB     |    Postgres |")

    show_both(h, mnumerics, pnumerics, 1, "msmallint")
    show_both(h, mnumerics, pnumerics, 2, "mint")
    show_both(h, mnumerics, pnumerics, 3, "mbigint")
    show_both(h, mnumerics, pnumerics, 4, "mfloat")
    show_both(h, mnumerics, pnumerics, 5, "mreal")
    show_both(h, mnumerics, pnumerics, 6, "mdecimal")

  fun show_both(h: TestHelper, mn: ODBCSth,  pn: ODBCSth, col: U16, name': String val) =>
    var mparo: SQLDescribeParamOut = SQLDescribeParamOut(col)
    var mcolo: SQLDescribeColOut = SQLDescribeColOut(col)

    var pparo: SQLDescribeParamOut = SQLDescribeParamOut(col)
    var pcolo: SQLDescribeColOut = SQLDescribeColOut(col)

    h.assert_is[SQLReturn val](SQLSuccess, ODBCStmtFFI.describe_column(mn.stmt, mcolo, name'))
    h.assert_is[SQLReturn val](SQLSuccess, ODBCStmtFFI.describe_param(mn.stmt, mparo))

    h.assert_is[SQLReturn val](SQLSuccess, ODBCStmtFFI.describe_column(pn.stmt, pcolo, name'))
    h.assert_is[SQLReturn val](SQLSuccess, ODBCStmtFFI.describe_param(pn.stmt, pparo))

    var mpdt: I16 = mparo.data_type_ptr.value
    var mcdt: I16 = mcolo.datatype_ptr.value
    var mpsz: U64 = mparo.parameter_size_ptr.value
    var mcsz: U64 = mcolo.colsize_ptr.value

    var ppdt: I16 = pparo.data_type_ptr.value
    var pcdt: I16 = pcolo.datatype_ptr.value
    var ppsz: U64 = pparo.parameter_size_ptr.value
    var pcsz: U64 = pcolo.colsize_ptr.value

    Debug.out("| " + Format.int[U16](col where width = 2, fill = '0') + " | " +
        Format(name' where width = 16) + " | " +
                     Format.int[I16](mpdt where width = 3) + " | " +
                     Format.int[U64](mpsz where width = 5) + " | " +
                     Format.int[I16](ppdt where width = 3) + " | " +
                     Format.int[U64](ppsz where width = 5) + " | " +

                     Format.int[I16](mcdt where width = 3) + " | " +
                     Format.int[U64](mcsz where width = 5) + " | " +
                     Format.int[I16](pcdt where width = 3) + " | " +
                     Format.int[U64](pcsz where width = 5) + " | " )

/*
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
*/
  fun show_error_stmt(stmta: ODBCSth) =>
    var err: SQLReturn val = recover val SQLError.create_pstmt(stmta.stmt) end
    try
      if (false) then error end
      for f in (stmta.err as SQLError val).get_records().values() do
        Debug.out(f)
      end
      true
    end

  fun show_error(err: SQLReturn val) =>
    try
      for f in (err as SQLError val).get_records().values() do
        Debug.out(f)
      end
    end

