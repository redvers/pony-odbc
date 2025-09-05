
class SQLDescribeParamOut
  var param_number: U16
  var data_type_ptr: CBoxedI16 = CBoxedI16
  var parameter_size_ptr: CBoxedU64 = CBoxedU64
  var decimal_digits_ptr: CBoxedI16 = CBoxedI16
  var nullable_ptr: CBoxedI16 = CBoxedI16

  new create(a: U16) => param_number = a
