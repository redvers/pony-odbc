use "../../pony-odbc"
use "lib:odbc"

actor Main
  let env: Env
  var inb: (SQLVarchar, SQLVarchar) = (SQLVarchar.>alloc(25), SQLVarchar.>alloc(100))
  var outb: (SQLVarchar, SQLVarchar) = (SQLVarchar.>alloc(25), SQLVarchar.>alloc(100))

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

        // Prepare your statement to insert values
        stm .> prepare("insert into hello_world (i, s) values (?, ?)")?
          .> bind_parameter(inb._1)?
          .> bind_parameter(inb._2)?

        // Insert three good rows
        insert_row(stm, 1, "This is my first row's string")?
        insert_row(stm, 2, "This is my second row's string")?
        try
          insert_row(stm, 2, "This will fail the uniqueness check")?
        end
        try
          insert_row(stm, 3, "This will fail due to the length of this string exceeding the input buffer check")?
        end

        // Query our database
        stm .> prepare("select * from hello_world")?
          .> bind_column(outb._1)?
          .> bind_column(outb._2)?
          .> execute()?

        var i: I32 = 0 ; var s: String val = "" ; var moredata: Bool = true
        while ((moredata, (i, s)) = fetch_row(stm)?; moredata) do
          env.out.print("Integer: " + i.string() + ", s: " + s)
        end
      else
        env.out.print("An error was raised: ")
        env.out.print(dbc.errtext)
        env.out.print(stm.errtext)
      end
    end

  fun ref insert_row(stm: ODBCStmt, integer: I32, str: String val)? =>
    inb._1.write(integer.string())
    inb._2.write(str)
    stm.execute()?

  fun ref fetch_row(stm: ODBCStmt): (Bool, (I32, String val)) ? =>
    (stm.fetch_scroll(SqlFetchNext)?, (outb._1.string().i32()?, outb._2.string()))
