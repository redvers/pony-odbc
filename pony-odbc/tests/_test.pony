use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "../instrumentation"
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"

actor \nodoc\ Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestPGMariaDBTypes("psqlred", "mariadb"))
    test(_TestConnect("mariadb"))
    test(_TestConnect("psqlred"))
    test(_TestExecDirect("mariadb"))
    test(_TestExecDirect("psqlred"))

//    test(_TestInteger("mariadb"))
//    test(_TestInteger("psqlred"))

  fun show_error_dbc(dbc: ODBCDbc) =>
    var err: SQLReturn val = recover val SQLError.create_pdbc(dbc.dbc) end
    try
      if (false) then error end
      for f in (dbc.err as SQLError val).get_records().values() do
        Debug.out(f)
      end
      true
    end


