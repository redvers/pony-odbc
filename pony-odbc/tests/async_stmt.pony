use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestAsyncStmt is UnitTest
  var dsn: String val
  fun name(): String val => "_TestAsyncStmt(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var dbc: ODBCDbc = ODBCDbc(ODBCEnv.>set_odbc3())
    h.assert_true(dbc.connect(dsn))

    long_execution(h, dbc)
    long_execution(h, dbc)
    long_execution(h, dbc)
    create_temp_table(h, dbc)

    populate_temp_table(h, dbc)
    query_test_rowcounts(h, dbc)
    query_test_under_allocation(h, dbc)

  fun long_execution(h: TestHelper, dbc: ODBCDbc) =>
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      h.assert_false(stm.get_async_enable()?)
      stm.set_async(true)?
      h.assert_true(stm.get_async_enable()?)
      stm
        .> prepare(
          """
          WITH RECURSIVE counter(n) AS (
            SELECT 1
            UNION ALL
            SELECT n + 1 FROM counter WHERE n < 100000000
          )
          SELECT MAX(n) FROM counter;
          """
        )?
        .> execute()?
    else
      match stm.get_err()
      | let x: SQLSuccess val => Debug.out("SQLSuccess")
      | let x: SQLSuccessWithInfo val =>
        Debug.out("SQLSuccessWithInfo: \n" + x.get_err_strings())
      else
        None
      end
    end

  fun create_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    var stm: ODBCStmt = ODBCStmt(dbc)
    Debug.out(stm.get_err().string())
    try
      stm
      .>prepare("create temporary table asynctest (i integer, s varchar(100))")?
      .>execute()?
    else
      h.fail(stm.errtext)
    end

  fun populate_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    var stm: ODBCStmt = ODBCStmt(dbc)
    var pina: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    try
      stm
      .>prepare("insert into asynctest (i, s) values (?,?)")?
      .>bind_parameter(pina._1)?
      .>bind_parameter(pina._2)?

      for f in Range[I32](0,300) do
        pina._1.write(f)
        pina._2.write("A Number: " + f.string())
        stm.execute()?
      end
    else
      Debug.out("populate_temp_table(): " + stm.errtext)
      h.fail(stm.errtext)
    end

  fun query_test_rowcounts(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from asynctest where i >= ?")?
      stm.bind_parameter(pinb)?
      stm.bind_column(poutb._1)?
      stm.bind_column(poutb._2)?
      pinb.write(-1)
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](300, stm.rowcount()?)
      end
      stm.finish()?

      pinb.write(150)
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](150, stm.rowcount()?)
      end
      stm.finish()?

      pinb.write(290)
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](10, stm.rowcount()?)
      end
      stm.finish()?
    else
      Debug.out("query_test_rowcounts(): " + stm.errtext)
      h.fail(stm.errtext)
    end

  fun query_test_under_allocation(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(3))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from asynctest where i >= ?")?
      stm.bind_parameter(pinb)?
      stm.bind_column(poutb._1)?
      stm.bind_column(poutb._2)?

      pinb.write(298)
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](2, stm.rowcount()?)
      end

      try
        var cntr: I32 = 298
        while stm.fetch_scroll(SqlFetchNext)? do
          h.assert_eq[I32](cntr, poutb._1.read()?)
          h.assert_eq[String]("A Number: " + cntr.string(), poutb._2.read())
          cntr = cntr + 1
        end
        stm.finish()?
      else
      Debug.out("query_test_under_allocation(): " + stm.errtext)
        h.fail(stm.errtext)
      end
    else
      Debug.out("query_test_under_allocation() the second: " + stm.errtext)
      h.fail(stm.errtext)
    end
