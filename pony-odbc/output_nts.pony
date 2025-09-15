primitive \nodoc\ _SqlAttrOutputNts fun apply(): I32 => 10001
  fun string(): String val => "_SqlAttrOutputNts"
  fun id(i: I32): (_SqlBool | PonyDriverError val) =>
    match i
    | 0 => _SqlFalse
    | 1 => _SqlTrue
    else
      recover val PonyDriverError("SqlBool had an invalid number: " + i.string()) end
    end

type _SqlBool is (_SqlTrue | _SqlFalse)
primitive \nodoc\ _SqlTrue fun apply(): I32 => 1
  fun string(): String val => "_SqlTrue"
primitive \nodoc\ _SqlFalse fun apply(): I32 => 0
  fun string(): String val => "_SqlFalse"

