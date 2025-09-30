use "../../pony-odbc"
use "lib:odbc"

actor Main
  let env: Env

  new create(env': Env) =>
    env = env'

    var henv: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = henv.dbc()?
      dbc.connect("psqlred")?
      try
        var stm: ODBCStmt = dbc.stmt()?
        // Create a demo table
        stm
        .> prepare("create temporary table hello_world (i integer unique, s varchar(40))")?
        .> execute()?

        // Create input parameters:
        var inint: SQLInteger = SQLInteger
        var instr: SQLVarchar = SQLVarchar(40)
        // Prepare your statement to insert values
        stm .> prepare("insert into hello_world (i, s) values (?, ?)")?
          .> bind_parameter(inint)?
          .> bind_parameter(instr)?

        // Insert three rows
        inint.write(1); if (instr.write("First Row"))  then stm.execute()? end
        inint.write(2); if (instr.write("Second Row")) then stm.execute()? end
        inint.write(3); instr.null(); stm.execute()?
        try
          inint.write(3); if (instr.write("Not Unique")) then stm.execute()? end
        end
        try
          inint.write(4); if (instr.write("TooLong: " + ("x"*100))) then stm.execute()? end
        end

        // Create output columns:
        var outint: SQLInteger = SQLInteger
        var outstr: SQLVarchar = SQLVarchar(40)
        // Query our database
        stm .> prepare("select * from hello_world")?
          .> bind_column(outint)?
          .> bind_column(outstr)?
          .> execute()?

        while (stm.fetch_scroll()?) do
          var i: I32 = outint.read()?
          var s: String val =
            if (outstr.is_null()) then
              "A SQL NULL value"
            else
              outstr.read()?
            end
          env.out.print("Integer: " + i.string() + ", s: " + s)
        end
      else
        env.out.print("Failed doing stuff")
        env.out.print("dbc: " + dbc.sqlstates()(0)?._1 + ": " + dbc.sqlstates()(0)?._2)
      end
      try
        env.out.print("dbc: " + dbc.sqlstates()(0)?._1 + ": " + dbc.sqlstates()(0)?._2)
      end
    else
      env.out.print("It all failed")
    end
