
class SQLDescribeParamOut
  var param_number: U16
  var data_type_ptr: CBoxedI16 = CBoxedI16
  var parameter_size_ptr: CBoxedU64 = CBoxedU64
  var decimal_digits_ptr: CBoxedI16 = CBoxedI16
  var nullable_ptr: CBoxedI16 = CBoxedI16

  new create(a: U16) => param_number = a

  fun debug(): String val =>
    " Column Number: " + param_number.string() + "\n" +
    "     Data Type: " + data_type_ptr.value.string() + "\n" +
    "Parameter Size: " + parameter_size_ptr.value.string() + "\n" +
    "Decimal Digits: " + decimal_digits_ptr.value.string() + "\n" +
    "     Nullable?: " + nullable_ptr.value.string() + "\n"
