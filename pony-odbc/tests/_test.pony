use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "../env"
use "../dbc"
use "../stmt"
use "collections"

actor \nodoc\ Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestEnvironment)
    test(_TestConnects)

    test(_TestConnect("mariadb"))
    test(_TestConnect("psqlred"))
    test(_TestConnect("sqlitedb3"))

    test(_TestDatabase("mariadb"))
    test(_TestDatabase("psqlred"))
    test(_TestDatabase("sqlitedb3"))

    test(_TestStmtAPI("psqlred"))
    test(_TestStmtAPI("mariadb"))
    test(_TestStmtAPI("sqlitedb3"))

  fun show_error_dbc(dbc: ODBCDbc) =>
    var err: SQLReturn val = recover val SQLError.create_pdbc(dbc.dbc) end
    try
      if (false) then error end
      for f in (dbc.get_err() as SQLError val).get_records().values() do
        Debug.out(f)
      end
      true
    end

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
    var pina: (SQLVarchar, SQLVarchar) = (SQLVarchar.>alloc(20), SQLVarchar.>alloc(101))
    try
      stm
      .>prepare("insert into odbthingtest (i, s) values (?,?)")?
      .>bind_parameter(pina._1)?
      .>bind_parameter(pina._2)?

      for f in Range[I32](0,300) do
        pina._1.write(f.string())
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
    var pinb: SQLVarchar = SQLVarchar.>alloc(25)
    var poutb: (SQLVarchar, SQLVarchar) = (SQLVarchar.>alloc(25), SQLVarchar.>alloc(101))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from odbthingtest where i >= ?")?
      stm.bind_parameter(pinb)?
      stm.bind_column(poutb._1)?
      stm.bind_column(poutb._2)?
      pinb.write(I16(-1).string())
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](300, stm.rowcount()?)
      end
      stm.finish()?

      pinb.write("150")
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](150, stm.rowcount()?)
      end
      stm.finish()?

      pinb.write("290")
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
    var pinb: SQLVarchar = SQLVarchar.>alloc(25)
    var poutb: (SQLVarchar, SQLVarchar) = (SQLVarchar.>alloc(25), SQLVarchar.>alloc(3))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from odbthingtest where i >= ?")?
      stm.bind_parameter(pinb)?
      stm.bind_column(poutb._1)?
      stm.bind_column(poutb._2)?

      pinb.write("298")
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](2, stm.rowcount()?)
      end

      try
        var cntr: USize = 298
        while stm.fetch_scroll(SqlFetchNext)? do
          h.assert_eq[String](cntr.string(), poutb._1.string())
          h.assert_eq[String]("A Number: " + cntr.string(), poutb._2.string())
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

