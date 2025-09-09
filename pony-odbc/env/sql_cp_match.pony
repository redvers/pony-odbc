use "../instrumentation"

primitive SqlAttrCPMatch fun apply(): I32 => 202
  fun id(i: I32): (SqlCPMatch | PonyDriverError val) =>
    match i
    | 0 => SqlCPStrict
    | 1 => SqlCPRelaxed
    else
      recover val PonyDriverError("SqlAttrCPMatch.id(): Unknown SqlCPMatch version: " + i.string()) end
    end

type SqlCPMatch is (SqlCPStrict | SqlCPRelaxed | SqlCPDefault)
primitive SqlCPStrict fun apply(): I32 => 0
primitive SqlCPRelaxed fun apply(): I32 => 1
primitive SqlCPDefault fun apply(): I32 => 0

