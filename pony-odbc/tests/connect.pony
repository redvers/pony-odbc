use "debug"
use "pony_test"
use ".."

class \nodoc\ iso _TestConnect is UnitTest
  var dsn: String val

  new create(dsn': String val) =>
    dsn = dsn'

  fun name(): String val => "_TestConnect(" + dsn + ")"

  fun apply(h: TestHelper)  =>
    var env: ODBCEnv = ODBCEnv
    try
      env.set_odbc3()?
      var dbc: ODBCDbc = env.dbc()?
    else
      try
      Debug.out(env.sqlstates()(0)?._1 + ": " + env.sqlstates()(0)?._2)
      end
    end
//    h.assert_true(dbc.set_application_name("_Postgres")?)
//
//    h.assert_true(dbc.connect(dsn)?)

