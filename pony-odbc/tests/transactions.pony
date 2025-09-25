use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestTransactions is UnitTest
  var dsn: String val
  fun name(): String val => "_TestTransactions(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    try
      env.set_odbc3()?
      var dbc: ODBCDbc = env.dbc()?


      h.assert_true(dbc.get_autocommit()?)
      dbc.set_autocommit(false)?
      h.assert_false(dbc.get_autocommit()?)
      dbc.set_autocommit(true)?
      h.assert_true(dbc.get_autocommit()?)
      dbc.set_autocommit(false)?
      h.assert_false(dbc.get_autocommit()?)

      h.assert_true(dbc.connect(dsn)?)
      h.assert_eq[String]("SQLSuccess", dbc.get_err().string())

      create_temp_table(h, dbc)
      h.assert_true(dbc.commit()?)
      populate_temp_table(h, dbc)
      h.assert_true(dbc.rollback()?)
      populate_temp_table(h, dbc)
      query_test_rowcounts(h, dbc)
      query_test_under_allocation(h, dbc)
    else
      h.fail("We failed in here")
    end


  fun create_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm
      .>prepare("create temporary table transactiontest (i integer, s varchar(100))")?
      .>execute()?
    else
      h.fail("We failed in create_temp_table")
    end

  fun populate_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    var pina: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm
      .>prepare("insert into transactiontest (i, s) values (?,?)")?
      .>bind_parameter(pina._1)?
      .>bind_parameter(pina._2)?

      for f in Range[I32](0,300) do
        pina._1.write(f)
        pina._2.write("A Number: " + f.string())
        stm.execute()?
      end
    else
      h.fail("We failed in populate_temp_table")
    end

  fun query_test_rowcounts(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.prepare("select * from transactiontest where i >= ?")?
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
      h.fail("We failed in query_test_rowcounts")
    end

  fun query_test_under_allocation(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(3))
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm.prepare("select * from transactiontest where i >= ?")?
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
          h.assert_eq[String]("A Number: " + cntr.string(), poutb._2.read()?)
          cntr = cntr + 1
        end
        stm.finish()?
      else
        h.fail("We failed in query_test_under_allocation (A)")
      end
    else
      h.fail("We failed in query_test_under_allocation (B)")
    end

