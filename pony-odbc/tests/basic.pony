
use "debug"
use "pony_test"
use "collections"
use ".."
use "../ffi"

class \nodoc\ iso _MariaDBBasic is UnitTest
  var dsn: String val

  new create(dsn': String val) =>
    dsn = dsn'

  fun name(): String val => "_MariaDBBasic(" + dsn + ")"

  fun apply(h: TestHelper) ? =>
    var env: ODBCEnv = ODBCEnv
    var dbh: ODBCDbc = env.dbc()?
    dbh.connect(dsn)?

    try simple_test(h, dbh)? else h.fail("Failed in simple_test") end
    try simple_test1(h, dbh)? else h.fail("Failed in simple_test1") end
    try select1000(h, dbh)? else h.fail("Failed in select1000") end
    try simple_2(h, dbh)? else h.fail("Failed in simple_2") end
    try test_reconnect(h, dbh)? else h.fail("Failed in test_reconnect") end

    try
      var dbc: ODBCDbc = env.dbc()?
    else
      try
      Debug.out(env.sqlstates()(0)?._1 + ": " + env.sqlstates()(0)?._2)
      end
    end

  fun simple_test(h: TestHelper, dbh: ODBCDbc) ? =>
    var sth: ODBCStmt = dbh.stmt()?
    var value: CBoxedU16 = CBoxedU16
    var buffer: CBoxedArray = CBoxedArray .> alloc(128)
    var v: SQLVarchar = SQLVarchar(128)

    /* NOTE - The rest of these tests were originally written to use
     * SQLWCHAR. Pony does not support fixed-length unicode, so
     * we're converting all the tests to (what I assume is) utf8.
     */
    sth.direct_exec("CREATE TEMPORARY TABLE smpltest (a int, b varchar(25))")?
    sth.direct_exec("INSERT INTO smpltest VALUES (1, 'Row no 1')")?
    sth.direct_exec("INSERT INTO smpltest VALUES (2, 'Row no 2')")?

    sth.prepare("SELECT a, b FROM smpltest")?

    sth.execute()?
    sth.fetch()?

    var myint: SQLInteger = SQLInteger
    var varchar: SQLVarchar = SQLVarchar(20)

    sth.get_data(1, myint)?
    sth.get_data(2, varchar)?
    h.assert_eq[I32](1, myint.read()?)
    h.assert_eq[String val]("Row no 1", varchar.read()?)

    myint.reset()
    varchar.reset()

    sth.fetch()?
    sth.get_data(1, myint)?
    sth.get_data(2, varchar)?
    h.assert_eq[I32](2, myint.read()?)
    h.assert_eq[String val]("Row no 2", varchar.read()?)

    sth.finish()?


  fun simple_test1(h: TestHelper, dbh: ODBCDbc) ? =>
    var sth: ODBCStmt = dbh.stmt()?
    var nRowCount: CBoxedI64 = CBoxedI64

    sth.direct_exec("CREATE TEMPORARY TABLE t_basic (id INT PRIMARY KEY, name VARCHAR(20))")?
    sth.direct_exec("INSERT INTO t_basic VALUES (1,'foo'),(2,'bar'),(3,'baz')")?
    sth.direct_exec("UPDATE t_basic SET name = 'bop' WHERE id = 2")?

    h.assert_eq[I64](1, sth.rowcount()?)

    sth.direct_exec("DELETE FROM t_basic WHERE id = 3")?
    h.assert_eq[I64](1, sth.rowcount()?)

    sth.direct_exec("ALTER TABLE t_basic RENAME TO t_basic_2")?
    try
      sth.direct_exec("DROP TABLE t_basic")?
      h.fail("This drop should have failed")
    else
      h.assert_true(true)
    end
    sth.direct_exec("DROP TABLE t_basic_2")?

  fun select1000(h: TestHelper, dbh: ODBCDbc) ? =>
    var sth: ODBCStmt = dbh.stmt()?
    var myint: SQLInteger = SQLInteger
    var varchar: SQLVarchar = SQLVarchar(20)

    var wrlen: CBoxedI64 = CBoxedI64
    wrlen.value = ODBCVarcharConsts.sql_nts().i64()

    sth.direct_exec("CREATE TEMPORARY TABLE t_max_select (a INT, b VARCHAR(30))")?

    sth.prepare("INSERT INTO t_max_select VALUES (?,?)")?
    sth.bind_parameter(myint)?
    sth.bind_parameter(varchar)?

    for f in Range(0, 1000) do
      myint.null()  // This is a NULL - Yay!
      varchar.write("MySQL" + f.string())
      try
        sth.execute()?
      else
        Debug.out(sth.sqlstates()(0)?._1 + ": " + sth.sqlstates()(0)?._2)
      end
    end
    sth.finish()?

    sth.direct_exec("SELECT * FROM t_max_select")?

    var num: USize = 0
    while (sth.fetch()?) do
      num = num +1
    end
    h.assert_eq[USize](1000, num)

    sth.finish()?

  fun simple_2(h: TestHelper, dbh: ODBCDbc) ? =>
    var sth: ODBCStmt = dbh.stmt()?

    var nRowCount: SQLInteger = SQLInteger
    var nInData: SQLInteger = SQLInteger .> write(1)
    var c: SQLVarchar = SQLVarchar(31)
    var d: SQLVarchar = SQLVarchar(31)

    sth.direct_exec("CREATE TEMPORARY TABLE t_myodbc (a INT, b VARCHAR(30), c VARCHAR(10), d VARCHAR(10))")?

    sth.finish()?

    sth.direct_exec("INSERT INTO t_myodbc VALUES (10, 'direct', NULL, NULL)")?
    sth.prepare("INSERT INTO t_myodbc (a,b,c) VALUES (?, 'param', ?)")?

    sth.bind_parameter(nInData)?
    sth.bind_parameter(c)?

    for f in Range[I32](20, 100, 10) do
      nInData.write(f)
      c.null()
      sth.execute()?
    end
    sth.finish()?

    sth.direct_exec("SELECT * FROM t_myodbc")?

    var aa: SQLInteger = SQLInteger .> write(0)
    var bb: SQLVarchar = SQLVarchar(31)
    var cc: SQLVarchar = SQLVarchar(11)
    var dd: SQLVarchar = SQLVarchar(11)
    sth.bind_column(aa)?
    sth.bind_column(bb)?
    sth.bind_column(cc)?
    sth.bind_column(dd)?

    nInData.write(10)

    while (sth.fetch()?) do
      h.assert_eq[I32](aa.read()?, aa.read()?)
      nInData.write(nInData.read()? + 10)
      h.assert_true(cc.is_null())
      h.assert_true(dd.is_null())
    end

    if (dsn != "sqlitedb3") then
      h.assert_eq[I32](sth.rowcount()?.i32(), ((nInData.read()? - 10) / 10))
    end
    sth.finish()?

  fun test_reconnect(h: TestHelper, dbh: ODBCDbc) ? =>
    var sth: ODBCStmt = dbh.stmt()?

