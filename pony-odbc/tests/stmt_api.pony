use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestStmtAPI is UnitTest
  var dsn: String val
  fun name(): String val => "_TestStmtAPI(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?

      // This should fail
      create_table_before_connection(h, dbc)
      h.assert_true(dbc.connect(dsn)?)

      // Create our temporary table
      create_temp_table(h, dbc)

      // Drop connection here, temp table should disappear
      h.assert_true(dbc.disconnect()?)

      // Fail to create table again due to no connection
      create_table_before_connection(h, dbc)

      // Reconnect
      h.assert_true(dbc.connect(dsn)?)

      // Syntax Error
      create_temp_table_syntax_err(env, h, dbc)

      // Create Table
      create_temp_table(h, dbc)

      // Attempt to insert without assigning buffers
      populate_temp_table_no_binding(env, h, dbc)

      // Populate the table with some data.
      populate_temp_table(h, dbc)

      // Query rowcount (borked on sqlite)
      query_test_rowcounts(h, dbc)

      query_test_under_allocation(h, dbc)
    else
      h.fail("We failed in here")
    end

  fun create_table_before_connection(h: TestHelper, dbc: ODBCDbc) =>
    try
      var stm: ODBCStmt = dbc.stmt()?
    else
      try
        h.assert_eq[String val]("08003", dbc.sqlstates()(0)?._1)
      else
        h.fail("Statement creation should have failed, it didn't")
      end
    end

  fun create_temp_table_syntax_err(env: ODBCEnv, h: TestHelper, dbc: ODBCDbc) =>
    try
      var stm: ODBCStmt = dbc.stmt()?
      try
        stm
          .> prepare("create le odbthingtest (i integer, s varchar(100))")?
      else
        h.assert_eq[USize](0, env.sqlstates().size())
        h.assert_eq[USize](0, dbc.sqlstates().size())
        h.assert_eq[USize](1, stm.sqlstates().size())
        try
          h.assert_eq[String val]("42000", stm.sqlstates()(0)?._1)
        else
          h.fail("Unable to locate sqlstate for create_table_temp_syntax_err")
        end


      end
      try
        stm
          .> execute()?
      else
        h.assert_eq[USize](0, env.sqlstates().size())
        h.assert_eq[USize](0, dbc.sqlstates().size())

/*
 * A change in behaviour in how mariadb's connector mean we have to gate
 * this test.
 */
        if (dsn != "mariadb") then
          h.assert_eq[USize](1, stm.sqlstates().size())
        end
        try
          if (dsn != "mariadb") then
            h.assert_true((stm.sqlstates()(0)?._1 == "42601")// Vendor Specific
                     or (stm.sqlstates()(0)?._1 == "HY010")  // MariaDB already b0rked
                     or (stm.sqlstates()(0)?._1 == "HY000")) // General Error
          end
        else
          h.fail("Unable to locate sqlstate for create_table_temp_syntax_err")
        end
      end
    else
      h.fail("Failed at create_table_temp_syntax_err")
    end

  fun create_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    try
      var stm: ODBCStmt = dbc.stmt()?
      stm
      .>prepare("create temporary table odbthingtest (i integer, s varchar(100))")?
      .>execute()?
    else
      h.fail("Failed at create_temp_table()")
    end

  fun populate_temp_table_no_binding(env: ODBCEnv, h: TestHelper, dbc: ODBCDbc) =>
    var pina: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    try
      var stm: ODBCStmt = dbc.stmt()?
      try
        stm
        .>prepare("insert into odbthingtest (i, s) values (?,?)")?
          stm.execute()?
      else
        h.assert_eq[USize](0, env.sqlstates().size())
        h.assert_eq[USize](0, dbc.sqlstates().size())
//        h.assert_eq[USize](1, stm.sqlstates().size()) //
        try
          h.assert_true((stm.sqlstates()(0)?._1 == "HY000")
                     or (stm.sqlstates()(0)?._1 == "07002"))
        end
      end
    else
      h.fail("Failed at populate_temp_table_no_binding")
    end

  fun populate_temp_table(h: TestHelper, dbc: ODBCDbc) =>
    var pina: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    try
      var stm: ODBCStmt = dbc.stmt()?
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
      h.fail("populate_temp_table errored out")
    end

  fun query_test_rowcounts(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(101))
    try
      var stm: ODBCStmt = dbc.stmt()?
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
      h.fail("query_row_counts has failed")
    end

  fun query_test_under_allocation(h: TestHelper, dbc: ODBCDbc) =>
    var pinb: SQLInteger = SQLInteger
    var poutb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(3))
    try
      var stm: ODBCStmt = dbc.stmt()?
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
          h.assert_eq[String]("A Number: " + cntr.string(), poutb._2.read()?)
          cntr = cntr + 1
        end
        stm.finish()?
      else
        h.fail("Underallocation failed (part A)")
      end
    else
      h.fail("Underallocation failed (part B)")
    end
