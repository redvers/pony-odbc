use "debug"
use "lib:odbc"
use "pony_test"
use ".."
use "collections"

actor \nodoc\ Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestEnvironment)
    test(_TestConnects)

    test(_TestConnect("mariadb"))
    test(_TestConnect("psqlred"))
    test(_TestConnect("sqlitedb3"))

    test(_TestDatabase("mariadb"))
    test(_TestDatabase("psqlred"))
    test(_TestDatabase("sqlitedb3"))

    test(_TestStmtAPI("psqlred"))
    test(_TestStmtAPI("mariadb"))
    test(_TestStmtAPI("sqlitedb3"))

    test(_TestTypeTests("psqlred"))
    test(_TestTypeTests("mariadb"))
    test(_TestTypeTests("sqlitedb3"))

    test(_TestTransactions("psqlred"))
    test(_TestTransactions("mariadb"))
    test(_TestTransactions("sqlitedb3"))
