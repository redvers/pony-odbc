use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "../instrumentation"
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"
use "collections"

actor \nodoc\ Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestPGMariaDBTypes("psqlred", "mariadb"))
    test(_TestEnvironment)

    test(_TestConnect("mariadb"))
    test(_TestConnect("psqlred"))
    test(_TestConnect("sqlitedb3"))

    test(_TestExecDirect("mariadb"))
    test(_TestExecDirect("psqlred"))
    test(_TestExecDirect("sqlitedb3"))

    test(_TestInteger("mariadb"))
    test(_TestInteger("psqlred"))
    test(_TestInteger("sqlitedb3"))

    test(_TestAPIIdea("psqlred"))
    test(_TestAPIIdea("mariadb"))
    test(_TestAPIIdea("sqlitedb3"))

  fun show_error_dbc(dbc: ODBCDbc) =>
    var err: SQLReturn val = recover val SQLError.create_pdbc(dbc.dbc) end
    try
      if (false) then error end
      for f in (dbc.err as SQLError val).get_records().values() do
        Debug.out(f)
      end
      true
    end

class \nodoc\ iso _TestAPIIdea is UnitTest
  var dsn: String val
  fun name(): String val => "_TestAPIIdea(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var dbc: ODBCDbc = ODBCDbc(ODBCEnv.>set_odbc3())

    h.assert_true(dbc.connect(dsn))
    h.assert_eq[String]("SQLSuccess", dbc.err.string())


    var stm: ODBCThing = ODBCThing(dbc)
    try
      stm
      .>prepare("create temporary table odbthingtest (i integer, s varchar(100))")?
      .>execute()?
      .>finish()?
    else
      Debug.out("Something in there failed")
      try
        for f in (stm.err as SQLError val).get_records().values() do
          h.fail(f)
        end
      end
    end

    stm = ODBCThing(dbc)
    var pina: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar.>alloc(101))
    try
      stm
      .>prepare("insert into odbthingtest (i, s) values (?,?)")?
      .>bind_parameter(pina._1, 1)?
      .>bind_parameter(pina._2, 2)?

      for f in Range[I32](0,300) do
        pina._1.write(f)
        pina._2.write("A Number: " + f.string())
        stm.execute()?
      end
      stm.finish()?
    else
      try
        for f in (stm.err as SQLError val).get_records().values() do
          h.fail(f)
        end
      end
    end

    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar.>alloc(101))
    try
      stm
      stm.prepare("select * from odbthingtest where i >= ?")?
      stm.bind_parameter(pinb, 1)?
      stm.bind_column(poutb._1, 1)?
      stm.bind_column(poutb._2, 2)?
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

      try
        while true do
          stm.fetch()?
        end
        stm.finish()?
      end


    else
      try
        for f in (stm.err as SQLError val).get_records().values() do
          h.fail(f)
        end
      else
        Debug.out("Got err as: " + stm.err.string())
      end
    end








//    stm
//    .>prepare("select (


