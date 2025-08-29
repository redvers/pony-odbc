use "debug"

class SQLDescribeColOut
  var column_number: U16 = 1
  var column_name: CBoxedArray = CBoxedArray(4096)
  var writtenlen:    CBoxedI16 = CBoxedI16
  var datatype:      CBoxedI16 = CBoxedI16
  var colsize:       CBoxedU64 = CBoxedU64
  var decdigits:     CBoxedI16 = CBoxedI16
  var nullable:      CBoxedI16 = CBoxedI16

