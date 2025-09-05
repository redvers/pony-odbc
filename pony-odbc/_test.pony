use "debug"
use "lib:odbc"
use "pony_test"
use "instrumentation"
use "env"
use "dbc"
use "stmt"
use "ctypes"

actor \nodoc\ Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestMariaDB)
    test(_TestPostgres)



class \nodoc\ iso _TestMariaDB is UnitTest
  fun name(): String val => "_TestMariaDB"

  fun apply(h: TestHelper) =>
    h.assert_true(true)
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())
    h.assert_true(dbc.set_application_name("_Postgres"))

    h.assert_true(dbc.connect("mariadb"))

class \nodoc\ iso _TestPostgres is UnitTest
  fun name(): String val => "_TestPostgres"

  fun apply(h: TestHelper) =>
    h.assert_true(true)
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())
    h.assert_true(e.is_valid())

    var dbc: ODBCDbc = ODBCDbc(e)
    h.assert_true(dbc.is_valid())
    h.assert_true(dbc.set_application_name("_Postgres"))

    h.assert_true(dbc.connect("psqlred"))
    show_error_dbc(dbc)







  fun show_error_dbc(dbc: ODBCDbc) =>
    var err: SQLReturn val = recover val SQLError.create_pdbc(dbc.dbc) end
    try
      if (false) then error end
      for f in (dbc.err as SQLError val).get_records().values() do
        Debug.out(f)
      end
      true
    end


