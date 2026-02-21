use "debug"
use "lib:odbc"
use "pony_test"
use "pony_check"
use ".."
use "collections"

actor \nodoc\ Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestNulls)
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

    test(_MariaDBBasic("mariadb"))
    test(_MariaDBBasic("psqlred"))
    test(_MariaDBBasic("sqlitedb3"))

    test(_MariaDBInfo("mariadb"))
    test(_MariaDBInfo("psqlred"))
    test(_MariaDBInfo("sqlitedb3"))

    test(_MariaDBTran("mariadb"))
    test(_MariaDBTran("psqlred"))
    test(_MariaDBTran("sqlitedb3"))

    // New comprehensive test suite
    test(_TestBoundaryValues("psqlred"))
    test(_TestBoundaryValues("mariadb"))
    test(_TestBoundaryValues("sqlitedb3"))

    test(_TestEdgeCases("psqlred"))
    test(_TestEdgeCases("mariadb"))
    test(_TestEdgeCases("sqlitedb3"))

    test(_TestMultipleConnections("psqlred"))
    test(_TestMultipleConnections("mariadb"))
//  SQLite is not down with multiple connections
//    test(_TestMultipleConnections("sqlitedb3"))

    test(_TestMetadataQueries("psqlred"))
    test(_TestMetadataQueries("mariadb"))
//    test(_TestMetadataQueries("sqlitedb3"))

    test(_TestErrorRecovery("psqlred"))
    test(_TestErrorRecovery("mariadb"))
    test(_TestErrorRecovery("sqlitedb3"))

// PostgreSQL has different error handling behavior that requires transaction cleanup
//    test(_TestErrorChain("psqlred"))
    test(_TestErrorChain("mariadb"))
    test(_TestErrorChain("sqlitedb3"))

    // Property-based tests (no DB connection required)
    test(_PropertySQLTypeRoundtrip)
    test(_PropertySQLTypeNulls)
    test(_PropertyCBoxedArray)
    test(_PropertyErrorChain)
    test(_PropertyErrorFrame)

    // Property-based DB roundtrip tests
    test(_PropertyDBRoundtrip("psqlred"))
    test(_PropertyDBRoundtrip("mariadb"))
    test(_PropertyDBRoundtrip("sqlitedb3"))
