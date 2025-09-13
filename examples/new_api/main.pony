use "../../pony-odbc"
use "lib:odbc"

actor Main
  let env: Env
  var inb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(100))
  var outb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(100))

  new create(env': Env) =>
    env = env'

    var dbc: ODBCDbc = ODBCDbc
    if (not dbc.connect("psqlred")) then
      env.out.print(dbc.get_errtext())
    else
      var stm: ODBCStmt = ODBCStmt(dbc)
      try
        // Create a demo table
        stm
        .> prepare("create temporary table hello_world (i integer unique, s varchar(40))")?
        .> execute()?

        // Prepare your statement to insert values
        stm .> prepare("insert into hello_world (i, s) values (?, ?)")?
          .> bind_parameter(inb._1)?
          .> bind_parameter(inb._2)?

        // Insert two rows
        inb._1.write(1); if (inb._2.write("First Row"))  then stm.execute()? end
        inb._1.write(2); if (inb._2.write("Second Row")) then stm.execute()? end
        try
          inb._1.write(2); if (inb._2.write("Not Unique")) then stm.execute()? end
        end
        try
          inb._1.write(3); if (inb._2.write("TooLong: " + ("x"*100))) then stm.execute()? end
        end

        // Query our database
        stm .> prepare("select * from hello_world")?
          .> bind_column(outb._1)?
          .> bind_column(outb._2)?
          .> execute()?

        var i: I32 = 0 ; var s: String val = "" ; var moredata: Bool = true
        while (stm.fetch_scroll(SqlFetchNext)?) do
          i = outb._1.read()?
          s = outb._2.read()
          env.out.print("Integer: " + i.string() + ", s: " + s)
        end
      else
        env.out.print("An error was raised: ")
        env.out.print(dbc.get_errtext())
        env.out.print(stm.errtext)
      end
    end

