primitive \nodoc\ _SqlAttrCPMatch fun apply(): I32 => 202
  fun string(): String val => "_SqlAttrCPMatch"
  fun id(i: I32): (_SqlCPMatch | PonyDriverError val) =>
    match i
    | 0 => _SqlCPStrict
    | 1 => _SqlCPRelaxed
    else
      recover val PonyDriverError("SqlAttrCPMatch.id(): Unknown SqlCPMatch version: " + i.string()) end
    end

type _SqlCPMatch is (_SqlCPStrict | _SqlCPRelaxed | _SqlCPDefault)
primitive \nodoc\ _SqlCPStrict fun apply(): I32 => 0
  fun string(): String val => "SqlCPStrict"
primitive \nodoc\ _SqlCPRelaxed fun apply(): I32 => 1
  fun string(): String val => "SqlCPRelaxed"
primitive \nodoc\ _SqlCPDefault fun apply(): I32 => 0
  fun string(): String val => "SqlCPDefault"

