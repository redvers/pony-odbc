use "debug"
use "pony_test"
//use "lib:iodbc"
use "lib:odbc"

actor Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
//    test(_TestSQLite)
    test(_TestMySQL)


class iso _TestSQLite is UnitTest
  fun name(): String val => "_TestSQLite"

  fun apply(h: TestHelper) ? =>
    var henv: HandleENV = HandleENV.create()?
                          .>set_odbc3()?

    var hdbc: HandleDBC = HandleDBC.create(henv)?
                          .>set_application_name("_TestSQLite")?
                          .>connect("mysqlitedb")?
                          .>get_commit_mode()

    var stmt: HandleSTMT = HandleSTMT.create(hdbc)?

    Debug.out(stmt.prepare("drop table if exists version").string())
    Debug.out(stmt.execute().string())
//    Debug.out("commit: " + hdbc.commit().string())

    stmt = HandleSTMT.create(hdbc)?
    Debug.out(stmt.prepare("create table version (a text, b integer)").string())
    Debug.out(stmt.execute().string())


//    var stmt: HandleSTMT

//    iodbc.datasources()
    h.assert_true(true)

class iso _TestMySQL is UnitTest
  fun name(): String val => "_TestMySQL"

  fun apply(h: TestHelper) ? =>
    var henv: HandleENV = HandleENV.create()?
                          .>set_odbc3()?

    var hdbc: HandleDBC = HandleDBC.create(henv)?
                          .>set_application_name("_TestSQLite")?
                          .>connect("psqlred")?
                          .>get_commit_mode()

    var stmt: HandleSTMT = HandleSTMT.create(hdbc)?

    Debug.out(stmt.prepare("drop table if exists version").string())
    Debug.out(stmt.execute().string())
//    Debug.out("commit: " + hdbc.commit().string())

    stmt = HandleSTMT.create(hdbc)?
    Debug.out(stmt.prepare("create table version (a text, b integer)").string())
    Debug.out(stmt.execute().string())


//    var stmt: HandleSTMT

//    iodbc.datasources()
    h.assert_true(true)
