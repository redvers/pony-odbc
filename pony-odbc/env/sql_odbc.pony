use ".."

primitive \nodoc\ SqlAttrODBCVersion fun apply(): I32 => 200
  fun string(): String val => "SqlAttrODBCVersion"
  fun id(i: I32): (SqlODBC | PonyDriverError val) =>
    match i
    | 2 => SqlODBC2
    | 3 => SqlODBC2
    | 380 => SqlODBC2
    else
      recover val PonyDriverError("SqlAttrODBCVersion.id(): Unknown SqlODBC version: " + i.string()) end
    end

type SqlODBC is (SqlODBC2 | SqlODBC3 | SqlODBC380)
primitive \nodoc\ SqlODBC2         fun apply(): I32 => 2
  fun string(): String val => "SqlODBC2"
primitive \nodoc\ SqlODBC3         fun apply(): I32 => 3
  fun string(): String val => "SqlODBC3"
primitive \nodoc\ SqlODBC380       fun apply(): I32 => 380
  fun string(): String val => "SqlODBC380"

