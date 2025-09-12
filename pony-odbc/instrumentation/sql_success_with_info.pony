use "debug"
use "collections"

use ".."
use "../env"
use "../dbc"
use "../stmt"

class SQLSuccessWithInfo
  var records: Array[(I16, SQLDiagFrame)] = Array[(I16, SQLDiagFrame)]

  fun string(): String val => "SQLSuccessWithInfo"
  fun apply(): I16 => 1

  fun get_records(): Array[String val] val =>
    let rv: Array[String val] trn = recover trn Array[String val](8) end
    for (i,f) in records.values() do
      rv.push(f.recstring())
    end
    consume rv

  fun get_tuples(): Array[(I16, String val, String val)] val =>
    let rv: Array[(I16, String val, String val)] trn = recover trn Array[(I16, String val, String val)](8) end
    for (i,f) in records.values() do
      rv.push(f.rec_tuple())
    end
    consume rv

  new create_penv(htype: ODBCHandleEnv tag) =>
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create_penv(htype, num)?))
      else
        break
      end
    end

  new create_pdbc(htype: ODBCHandleDbc tag) =>
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create_pdbc(htype, num)?))
      else
        break
      end
    end

  new create_pstmt(htype: ODBCHandleStmt tag) =>
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create_pstmt(htype, num)?))
      else
        break
      end
    end



