use "debug"
use "pony_test"
use "collections"
use ".."
use "../ffi"

class \nodoc\ iso _MariaDBTran is UnitTest
  var dsn: String val

  new create(dsn': String val) =>
    dsn = dsn'

  fun name(): String val => dsn + "/_MariaDBTran"

  fun apply(h: TestHelper) ? =>
    var env: ODBCEnv = ODBCEnv
    var dbh: ODBCDbc = env.dbc()?
    dbh.set_autocommit(false)?
    dbh.connect(dsn)?

    try my_transaction(h, dbh)? else h.fail("Failed in my_transaction") end

    try
      var dbc: ODBCDbc = env.dbc()?
    else
      try
      Debug.out(env.sqlstates()(0)?._1 + ": " + env.sqlstates()(0)?._2)
      end
    end

  fun my_transaction(h: TestHelper, dbh: ODBCDbc) ? =>
    h.assert_false(dbh.get_autocommit()?)
    var sth: ODBCStmt = dbh.stmt()?

    sth.strict = false
    sth.direct_exec("DROP TABLE IF EXISTS t1")?
    sth.strict = true
    dbh.commit()?

    sth.direct_exec("CREATE TABLE t1 (col1 INT, col2 VARCHAR(30))")?
    sth.direct_exec("INSERT INTO t1 VALUES (10,'venu')")?
    dbh.commit()?

    sth.direct_exec("INSERT INTO t1 VALUES (20,'mysql')")?
    dbh.rollback()?

    sth.direct_exec("DELETE FROM t1 WHERE col1 = 10")?
    dbh.rollback()?
    sth.finish()?

    sth.direct_exec("SELECT * FROM t1")?
    h.assert_true(sth.fetch()?)
    sth.finish()?

    sth.direct_exec("INSERT INTO t1 VALUES (30,'test'),(40,'transaction')")?
    dbh.commit()?

    sth.direct_exec("DELETE FROM t1 WHERE col1 = 30")?
    dbh.commit()?

    sth.direct_exec("SELECT * FROM t1 WHERE col1 = 30")?
    h.assert_false(sth.fetch()?)
    sth.finish()?

    sth.direct_exec("DELETE FROM t1 WHERE col1 = 40")?
    dbh.commit()?

    sth.direct_exec("SELECT * FROM t1 WHERE col1 = 40")?
    h.assert_false(sth.fetch()?)
    sth.finish()?

    sth.direct_exec("DROP TABLE t1")?
    sth.finish()?
