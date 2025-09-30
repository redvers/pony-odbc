use "debug"
use "pony_test"
use ".."

class \nodoc\ iso _TestEnvironment is UnitTest
  fun name(): String val => "_TestEnvironment"

  fun apply(h: TestHelper) =>
    h.assert_true(true)
    var e: ODBCEnv = ODBCEnv.create()
    h.assert_eq[USize](0, e.sqlstates().size())

    /*
    // We're using ODBC3
    var ci32: CBoxedI32 = CBoxedI32
    e.get_attr(_SqlAttrODBCVersion, ci32)
    h.assert_eq[I32](3, ci32.value)

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
