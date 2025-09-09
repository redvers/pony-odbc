use "../instrumentation"

primitive SqlAttrConnectionPooling fun apply(): I32 => 201
  fun id(i: I32): (SqlCP | PonyDriverError val) =>
    match i
    | 0 => SqlCPOff
    | 1 => SqlCPOnePerDriver
    | 2 => SqlCPOnePerHEnv
    else
      recover val PonyDriverError("SqlAttrConnectionPooling.id(): Unknown SqlCP status: " + i.string()) end
    end

type SqlCP is (SqlCPOff | SqlCPOnePerDriver | SqlCPOnePerHEnv | SqlCPOnePerDefault)
primitive SqlCPOff fun apply(): I32 => 0
primitive SqlCPOnePerDriver fun apply(): I32 => 1
primitive SqlCPOnePerHEnv fun apply(): I32 => 2
primitive SqlCPOnePerDefault fun apply(): I32 => 0

