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

    /*
  new create(htype: ODBCHandle) =>
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create(htype, num)?))
      else
        break
      end
    end
    */

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



