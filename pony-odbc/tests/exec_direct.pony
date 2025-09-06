use "debug"
use "pony_test"
use ".."
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"
use "../attributes"
use "../instrumentation"

class \nodoc\ iso _TestExecDirect is UnitTest
  var dsn: String val

  new create(dsn': String val) => dsn = dsn'

  fun name(): String val => "_TestExecDirect(" + dsn + ")"

  fun apply(h: TestHelper) =>
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())
    h.assert_true(dbc.set_application_name("TestExecDirect"))

    h.assert_true(dbc.connect(dsn))
    h.assert_eq[String]("SQLSuccess", dbc.err.string())


    /* Create a temporary table */
    var stmt: ODBCSth = ODBCSth(dbc)
    h.assert_true(stmt.exec_direct("create temporary table test_exec_direct (foo integer)"))

    (var bool: Bool, var cnt: USize) = stmt.result_count()
    h.assert_true(bool)
    h.assert_eq[USize](0, cnt)


    /* Attempt to create the same table again - this WILL fail */
    h.assert_false(stmt.exec_direct("create temp table test_exec_direct (foo integer)"))
    Debug.out(stmt.err.string())
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

