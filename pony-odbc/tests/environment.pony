use "debug"
use "pony_test"
use ".."

class \nodoc\ iso _TestEnvironment is UnitTest
  fun name(): String val => "_TestEnvironment"

  fun apply(h: TestHelper) =>
    h.assert_true(true)
    var e: ODBCEnv = ODBCEnv
    h.assert_true(e.is_valid())
    h.assert_true(e.set_odbc3())

    /*
    // We're using ODBC3
    (var r: SQLReturn val, var i: I32) = e.get_attr(_SqlAttrODBCVersion)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    h.assert_eq[I32](3, i)

    // With no pooling
    (r, i) = e.get_attr(_SqlAttrConnectionPooling)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    h.assert_eq[I32](0, i)

    // So pooling match doesn't apply
    (r, i) = e.get_attr(_SqlAttrCPMatch)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    h.assert_eq[I32](0, i)

    // … and our strings will be returned WITH Nulls
    (r, i) = e.get_attr(_SqlAttrOutputNts)
    h.assert_is[SQLReturn val](SQLSuccess, r)
    h.assert_eq[I32](1, i)
*/
