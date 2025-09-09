use "../instrumentation"

primitive SqlAttrODBCVersion fun apply(): I32 => 200
  fun id(i: I32): (SqlODBC | PonyDriverError val) =>
    match i
    | 2 => SqlODBC2
    | 3 => SqlODBC2
    | 380 => SqlODBC2
    else
      recover val PonyDriverError("SqlAttrODBCVersion.id(): Unknown SqlODBC version: " + i.string()) end
    end

type SqlODBC is (SqlODBC2 | SqlODBC3 | SqlODBC380)
primitive SqlODBC2         fun apply(): I32 => 2
primitive SqlODBC3         fun apply(): I32 => 3
primitive SqlODBC380       fun apply(): I32 => 380

