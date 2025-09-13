use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "../env"
use "../dbc"
use "../stmt"
use "collections"

class \nodoc\ iso _TestTypeTests is UnitTest
  var dsn: String val
  fun name(): String val => "_TestTypeTests(" + dsn + ")"

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
      if (dsn == "psqlred") then
        stm
        .>prepare("create temporary table typetest (" +
                  "si smallint, " +
                  "ii integer, " +
                  "bi bigint, " +
                  "fl float, " +
                  "rl real, " +
                  "vc varchar(100), " +
                  "vb bytea)")?
        .>execute()?
      else
        stm
        .>prepare("create temporary table typetest (" +
                  "si smallint, " +
                  "ii integer, " +
                  "bi bigint, " +
                  "fl float, " +
                  "rl real, " +
                  "vc varchar(100), " +
                  "vb varbinary(100))")?
        .>execute()?
      end
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
    var pina: (SQLSmallInteger, SQLInteger, SQLBigInteger, SQLFloat, SQLReal, SQLVarchar, SQLVarbinary) = (SQLSmallInteger, SQLInteger, SQLBigInteger, SQLFloat, SQLReal, SQLVarchar(100), SQLVarbinary(100))
    try
      stm
      .>prepare("insert into typetest values (?,?,?,?,?,?,?)")?
      .>bind_parameter(pina._1)?
      .>bind_parameter(pina._2)?
      .>bind_parameter(pina._3)?
      .>bind_parameter(pina._4)?
      .>bind_parameter(pina._5)?
      .>bind_parameter(pina._6)?
      .>bind_parameter(pina._7)?

      for f in Range[USize](0,300) do
        pina._1.write(f.i16())
        pina._2.write(f.i32())
        pina._3.write(f.i64())
        pina._4.write((f.f32()+0.5).f32())
        pina._5.write((f.f64()+0.5).f64())
        pina._6.write(f.string())
        pina._7.write([0;42;12;41;252;13])
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
    var pinb: SQLSmallInteger = SQLSmallInteger
    var poutb: (SQLSmallInteger, SQLInteger, SQLBigInteger, SQLFloat, SQLReal, SQLVarchar, SQLVarbinary) = (SQLSmallInteger, SQLInteger, SQLBigInteger, SQLFloat, SQLReal, SQLVarchar(100), SQLVarbinary(100))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from typetest where si >= ?")?
      stm.bind_parameter(pinb)?
      stm.bind_column(poutb._1)?
      stm.bind_column(poutb._2)?
      stm.bind_column(poutb._3)?
      stm.bind_column(poutb._4)?
      stm.bind_column(poutb._5)?
      stm.bind_column(poutb._6)?
      stm.bind_column(poutb._7)?
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
    var poutb: (SQLSmallInteger, SQLInteger, SQLBigInteger, SQLFloat, SQLReal, SQLVarchar, SQLVarbinary) = (SQLSmallInteger, SQLInteger, SQLBigInteger, SQLFloat, SQLReal, SQLVarchar(100), SQLVarbinary(100))
    var stm: ODBCStmt = ODBCStmt(dbc)
    try
      stm.prepare("select * from typetest where ii >= ?")?
      stm.bind_parameter(pinb)?
      stm.bind_column(poutb._1)?
      stm.bind_column(poutb._2)?
      stm.bind_column(poutb._3)?
      stm.bind_column(poutb._4)?
      stm.bind_column(poutb._5)?
      stm.bind_column(poutb._6)?
      stm.bind_column(poutb._7)?

      pinb.write(298)
      stm.execute()?
      if (dsn != "sqlitedb3") then
        h.assert_eq[I64](2, stm.rowcount()?)
      end
      try
        var cntr: I32 = 298
        while stm.fetch_scroll(SqlFetchNext)? do
          h.assert_eq[I16](cntr.i16(), poutb._1.read()?)
          h.assert_eq[I32](cntr, poutb._2.read()?)
          h.assert_eq[I64](cntr.i64(), poutb._3.read()?)
          h.assert_eq[F32]((cntr.f32()+0.5), poutb._4.read()?)
          h.assert_eq[F64]((cntr.f64()+0.5), poutb._5.read()?)
          h.assert_eq[String](cntr.string(), poutb._6.read())
//          h.assert_eq[USize](6, poutb._7.read().size())
//          h.assert_eq[I32](cntr, poutb._7.read()?)
          cntr = cntr + 1
//        pina._4.write((f.f32() * 0.332).f32())
//        pina._5.write((f.f64() * 0.00332).f64())
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
