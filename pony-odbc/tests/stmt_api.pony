use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "../env"
use "../dbc"
use "../stmt"
use "collections"

class \nodoc\ iso _TestStmtAPI is UnitTest
  var dsn: String val
  fun name(): String val => "_TestStmtAPI(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var dbc: ODBCDbc = ODBCDbc(ODBCEnv.>set_odbc3())

    h.assert_true(dbc.connect(dsn))
    h.assert_eq[String]("SQLSuccess", dbc.get_err().string())

    create_temp_table(h, dbc)
    populate_temp_table(h, dbc)
    query_test_rowcounts(h, dbc)
    query_test_under_allocation(h, dbc)


  fun create_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm
      .>prepare("create temporary table odbthingtest (i integer, s varchar(100))")?
      .>execute()?
    else
      Debug.out("Something in there failed")
      try
        for f in (stm.get_err() as SQLError val).get_records().values() do
          h.fail(f)
        end
      end
    end

  fun populate_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    var stm: ODBCStmt = ODBCStmt(dbc)
    var pina: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    try
      stm
      .>prepare("insert into odbthingtest (i, s) values (?,?)")?
      .>bind_parameter(pina._1)?
      .>bind_parameter(pina._2)?

      for f in Range[I32](0,300) do
        pina._1.write(f)
        pina._2.write("A Number: " + f.string())
        stm.execute()?
      end
    else
      try
        for f in (stm.get_err() as SQLError val).get_records().values() do
          h.fail(f)
        end
      end
    end

  fun query_test_rowcounts(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from odbthingtest where i >= ?")?
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
      try
        for f in (stm.get_err() as SQLError val).get_records().values() do
          h.fail(f)
        end
      else
        Debug.out("Got err as: " + stm.get_err().string())
      end
    end

  fun query_test_under_allocation(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(3))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from odbthingtest where i >= ?")?
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
        try
          for f in (stm.get_err() as SQLSuccessWithInfo val).get_records().values() do
            h.fail(f)
          end
        end
      end
    else
      try
        for f in (stm.get_err() as SQLError val).get_records().values() do
          h.fail(f)
        end
      else
        Debug.out("Got err as: " + stm.get_err().string())
      end
    end
