use "debug"
use "pony_test"
use ".."

class \nodoc\ iso _TestConnect is UnitTest
  var dsn: String val

  new create(dsn': String val) =>
    dsn = dsn'

  fun name(): String val => dsn + "/_TestConnect"

  fun apply(h: TestHelper)  =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?
      dbc.connect(dsn)?
    else
      try
        Debug.out(env.sqlstates()(0)?._1 + ": " + env.sqlstates()(0)?._2)
        h.fail(env.sqlstates()(0)?._1 + ": " + env.sqlstates()(0)?._2)
      else
        h.fail("I failed so bad I can't debug it")
      end
    end
//    h.assert_true(dbc.set_application_name("_Postgres")?)
//
//    h.assert_true(dbc.connect(dsn)?)

