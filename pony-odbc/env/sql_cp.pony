use ".."
primitive \nodoc\ SqlAttrConnectionPooling fun apply(): I32 => 201
  fun string(): String val => "SqlAttrConnectionPooling"
  fun id(i: I32): (SqlCP | PonyDriverError val) =>
    match i
    | 0 => SqlCPOff
    | 1 => SqlCPOnePerDriver
    | 2 => SqlCPOnePerHEnv
    else
      recover val PonyDriverError("SqlAttrConnectionPooling.id(): Unknown SqlCP status: " + i.string()) end
    end

type SqlCP is (SqlCPOff | SqlCPOnePerDriver | SqlCPOnePerHEnv | SqlCPOnePerDefault)
primitive \nodoc\ SqlCPOff fun apply(): I32 => 0
  fun string(): String val => "SqlCPOff"
primitive \nodoc\ SqlCPOnePerDriver fun apply(): I32 => 1
  fun string(): String val => "SqlCPOnePerDriver"
primitive \nodoc\ SqlCPOnePerHEnv fun apply(): I32 => 2
  fun string(): String val => "SqlCPOnePerHEnv"
primitive \nodoc\ SqlCPOnePerDefault fun apply(): I32 => 0
  fun string(): String val => "SqlCPOnePerDefault"

