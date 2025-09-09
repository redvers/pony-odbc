use "../instrumentation"

primitive SqlAttrCPMatch fun apply(): I32 => 202
  fun string(): String val => "SqlAttrCPMatch"
  fun id(i: I32): (SqlCPMatch | PonyDriverError val) =>
    match i
    | 0 => SqlCPStrict
    | 1 => SqlCPRelaxed
    else
      recover val PonyDriverError("SqlAttrCPMatch.id(): Unknown SqlCPMatch version: " + i.string()) end
    end

type SqlCPMatch is (SqlCPStrict | SqlCPRelaxed | SqlCPDefault)
primitive SqlCPStrict fun apply(): I32 => 0
  fun string(): String val => "SqlCPStrict"
primitive SqlCPRelaxed fun apply(): I32 => 1
  fun string(): String val => "SqlCPRelaxed"
primitive SqlCPDefault fun apply(): I32 => 0
  fun string(): String val => "SqlCPDefault"

