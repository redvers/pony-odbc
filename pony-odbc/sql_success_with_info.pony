use "debug"
use "collections"

class SQLSuccessWithInfo
  var records: Array[(I16, SQLDiagFrame)] = Array[(I16, SQLDiagFrame)]

  fun string(): String val => "SQLSuccessWithInfo"
  fun apply(): I16 => 1

  new create(htype: ODBCHandle) =>
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create(htype, num)?))
      else
        break
      end
    end

