use "dbc"
use "stmt"
use "debug"

class ODBCStmt is STMTTrait
  """
  A simple API for performing SQL queries using ODBC for maximum portability.

  **THIS API WILL CHANGE**

  This is a *synchronous* API so its use should bear that in mind. An
  asynchronous API will follow later.

  ## Prerequisites

  This API handles queries.  Before you can execute a query, you need to
  connect to a database.  Before you can connect to a database, you need an
  optional Environment.

  See the documentation of ODBCDbc and ODBCEnv for more detail one what
  these two objects are and how they are used.  The example below is
  barebones for those objects.

  ## Usage

  ```pony
  use "pony-odbc"
  use "lib:odbc"

  actor Main
    let env: Env
    var inb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(100))
    var outb: (SQLInteger, SQLVarchar) = (SQLInteger, SQLVarchar(100))

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
          env.out.print(dbc.errtext)
          env.out.print(stm.errtext)
        end
      end
  ```

  In general, please ignore the `sl: SourceLoc val` argument to all the
  functions. They are automatically populated with the call site from
  your application in order to enrich error reporting.

  """
  var _dbc: ODBCDbc
  var _sth: ODBCHandleStmt tag
  var _err: SQLReturn val
  var _parameters: Array[SQLType] = Array[SQLType]
  var _columns:    Array[SQLType] = Array[SQLType]
  var errtext: String val = ""
  var _call_location: SourceLoc val = __loc

  fun ref get_dbc(): ODBCDbc => _dbc
  fun ref set_dbc(dbc: ODBCDbc) => _dbc = dbc
  fun ref get_sth(): ODBCHandleStmt tag => _sth
  fun ref set_sth(h: ODBCHandleStmt tag) => _sth = h
  fun ref get_err(): SQLReturn val => _err
  fun ref set_err(sqlerr: SQLReturn val) => _err = sqlerr
  fun ref get_parameters(): Array[SQLType] => _parameters
  fun ref set_parameters(pin: Array[SQLType]) => _parameters = pin
  fun ref get_columns(): Array[SQLType] => _columns
  fun ref set_columns(pout: Array[SQLType]) => _columns = pout

  fun ref get_errtext(): String val => errtext
  fun ref set_errtext(str: String val) => errtext = str

  fun ref get_call_location(): SourceLoc val => _call_location
  fun ref set_call_location(sl: SourceLoc val) => _call_location = sl

  new create(dbc': ODBCDbc, sl: SourceLoc val = __loc) =>
    """
    This constructor creates a new ODBCStmt instance which represents in the
    ODBC API an abstraction of an ODBC Statement Handle.

    These handles can be recycled.
    """
    _call_location = sl
    (_err, _sth) = ODBCStmtFFI.alloc(dbc'.get_dbc())
    _dbc = dbc'

