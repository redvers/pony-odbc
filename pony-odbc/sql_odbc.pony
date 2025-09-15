primitive \nodoc\ _SqlAttrODBCVersion fun apply(): I32 => 200
  fun string(): String val => "_SqlAttrODBCVersion"
  fun id(i: I32): (_SqlODBC | PonyDriverError val) =>
    match i
    | 2 => _SqlODBC2
    | 3 => _SqlODBC2
    | 380 => _SqlODBC2
    else
      recover val PonyDriverError("SqlAttrODBCVersion.id(): Unknown SqlODBC version: " + i.string()) end
    end

type _SqlODBC is (_SqlODBC2 | _SqlODBC3 | _SqlODBC380)
primitive \nodoc\ _SqlODBC2         fun apply(): I32 => 2
  fun string(): String val => "_SqlODBC2"
primitive \nodoc\ _SqlODBC3         fun apply(): I32 => 3
  fun string(): String val => "_SqlODBC3"
primitive \nodoc\ _SqlODBC380       fun apply(): I32 => 380
  fun string(): String val => "_SqlODBC380"

