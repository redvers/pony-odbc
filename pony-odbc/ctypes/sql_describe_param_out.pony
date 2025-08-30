
class SQLDescribeParamOut
  var param_number: U16
  var data_type_ptr: I16 = 100
  var parameter_size_ptr: U64 = 100
  var decimal_digits_ptr: I16 = 100
  var nullable_ptr: I16 = 100

  new create(a: U16) => param_number = a
