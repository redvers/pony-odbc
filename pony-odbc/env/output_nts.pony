use "../instrumentation"

primitive SqlAttrOutputNts fun apply(): I32 => 10001
  fun string(): String val => "SqlAttrOutputNts"
  fun id(i: I32): (SqlBool | PonyDriverError val) =>
    match i
    | 0 => SqlFalse
    | 1 => SqlTrue
    else
      recover val PonyDriverError("SqlBool had an invalid number: " + i.string()) end
    end

type SqlBool is (SqlTrue | SqlFalse)
primitive SqlTrue fun apply(): I32 => 1
  fun string(): String val => "SqlTrue"
primitive SqlFalse fun apply(): I32 => 0
  fun string(): String val => "SqlFalse"

