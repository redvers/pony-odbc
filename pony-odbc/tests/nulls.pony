use "debug"
use "pony_test"
use ".."

class \nodoc\ iso _TestNulls is UnitTest
  fun name(): String val => "_TestNulls"

  fun apply(h: TestHelper) =>
    h.assert_true(true)

    var ssi: SQLSmallInteger = SQLSmallInteger
    var si:  SQLInteger = SQLInteger
    var sbi: SQLBigInteger = SQLBigInteger
    var sf:  SQLFloat = SQLFloat
    var sr:  SQLReal = SQLReal
    var scr: SQLVarchar = SQLVarchar(128)

    h.assert_true(ssi.is_null())
    h.assert_true( si.is_null())
    h.assert_true(sbi.is_null())
    h.assert_true( sf.is_null())
    h.assert_true( sr.is_null())
    h.assert_true(scr.is_null())

    // Write values into the buffer
    h.assert_true(ssi.write(42))
    h.assert_true( si.write(65536))
    h.assert_true(sbi.write(1010165536))
    h.assert_true( sf.write(0.65536))
    h.assert_true( sr.write(0.65536))
    h.assert_true(scr.write("sixty-five thousand, five hundred and thirty-six"))

    h.assert_false(ssi.is_null())
    h.assert_false( si.is_null())
    h.assert_false(sbi.is_null())
    h.assert_false( sf.is_null())
    h.assert_false( sr.is_null())
    h.assert_false(scr.is_null())

    h.assert_true(ssi.reset())
    h.assert_true( si.reset())
    h.assert_true(sbi.reset())
    h.assert_true( sf.reset())
    h.assert_true( sr.reset())
    h.assert_true(scr.reset())

    h.assert_true(ssi.is_null())
    h.assert_true( si.is_null())
    h.assert_true(sbi.is_null())
    h.assert_true( sf.is_null())
    h.assert_true( sr.is_null())
    h.assert_true(scr.is_null())
