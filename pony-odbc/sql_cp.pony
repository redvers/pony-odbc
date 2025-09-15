primitive \nodoc\ _SqlAttrConnectionPooling fun apply(): I32 => 201
  fun string(): String val => "_SqlAttrConnectionPooling"
  fun id(i: I32): (_SqlCP | PonyDriverError val) =>
    match i
    | 0 => _SqlCPOff
    | 1 => _SqlCPOnePerDriver
    | 2 => _SqlCPOnePerHEnv
    else
      recover val PonyDriverError("SqlAttrConnectionPooling.id(): Unknown SqlCP status: " + i.string()) end
    end

type _SqlCP is (_SqlCPOff | _SqlCPOnePerDriver | _SqlCPOnePerHEnv | _SqlCPOnePerDefault)
primitive \nodoc\ _SqlCPOff fun apply(): I32 => 0
  fun string(): String val => "SqlCPOff"
primitive \nodoc\ _SqlCPOnePerDriver fun apply(): I32 => 1
  fun string(): String val => "SqlCPOnePerDriver"
primitive \nodoc\ _SqlCPOnePerHEnv fun apply(): I32 => 2
  fun string(): String val => "SqlCPOnePerHEnv"
primitive \nodoc\ _SqlCPOnePerDefault fun apply(): I32 => 0
  fun string(): String val => "SqlCPOnePerDefault"

