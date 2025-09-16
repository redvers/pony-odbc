use "../../pony-odbc"
use "lib:odbc"

actor Main
  let env: Env

  new create(env': Env) =>
    env = env'

    var dbc: ODBCDbc = ODBCDbc
    if (not dbc.connect("psqlred")) then
      env.out.print(dbc.errtext)
    else
      var stm: ODBCStmt = ODBCStmt(dbc)
      try
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

        // Insert two rows
        inint.write(1); if (instr.write("First Row"))  then stm.execute()? end
        inint.write(2); if (instr.write("Second Row")) then stm.execute()? end
        try
          inint.write(2); if (instr.write("Not Unique")) then stm.execute()? end
        end
        try
          inint.write(3); if (instr.write("TooLong: " + ("x"*100))) then stm.execute()? end
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
          var s: String val = outstr.read()
          env.out.print("Integer: " + i.string() + ", s: " + s)
        end
      else
        env.out.print("An error was raised: ")
        env.out.print(dbc.errtext)
        env.out.print(stm.errtext)
      end
    end

