use "debug"
use "collections"

class SQLError
  var records: Array[(I16, SQLDiagFrame)] = Array[(I16, SQLDiagFrame)]

  fun string(): String val => "SQLError"

  new create(htype: ODBCHandle) =>
    Debug.out("Called SQLError")
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create(htype, num)?))
      else
        break
      end
    end

