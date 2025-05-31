use "debug"
use "pony_test"
use "lib:iodbc"

actor Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestOptions)


class iso _TestOptions is UnitTest
  fun name(): String val => "_TestOptions"

  fun apply(h: TestHelper) ? =>
    let iodbc: ODBC = ODBC("mysqlitedb")?
    iodbc.datasources()
    h.assert_true(true)
