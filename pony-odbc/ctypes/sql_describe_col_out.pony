use "debug"

class SQLDescribeColOut
  var column_number: U16 = 1
  var column_name: CBoxedArray = CBoxedArray.>alloc(4096)
  var writtenlen_ptr:    CBoxedI16 = CBoxedI16
  var datatype_ptr:      CBoxedI16 = CBoxedI16
  var colsize_ptr:       CBoxedU64 = CBoxedU64
  var decdigits_ptr:     CBoxedI16 = CBoxedI16
  var nullable_ptr:      CBoxedI16 = CBoxedI16

  new create(col: U16) =>
    column_number = col


  fun debug(): String val =>
    "column_name: " + column_name.string() + "\n" +
    "column_number: " + column_number.string() + "\n" +
    "writtenlen_ptr: " + writtenlen_ptr.value.string() + "\n" +
    "datatype_ptr: " + datatype_ptr.value.string() + "\n" +
    "colsize_ptr: " + colsize_ptr.value.string() + "\n" +
    "decdigits_ptr: " + decdigits_ptr.value.string() + "\n" +
    "nullable_ptr: " + nullable_ptr.value.string() + "\n"
