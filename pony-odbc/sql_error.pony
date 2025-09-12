use "debug"
use "collections"

use "env"
use "dbc"
use "stmt"

class \nodoc\ SQLError
  var location: SourceLoc val = __loc
  var records: Array[(I16, SQLDiagFrame)] = Array[(I16, SQLDiagFrame)]

  fun apply(): I16 => -1

  fun string(): String val => "SQLError"
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

  fun get_err_strings(): String val =>
    location.type_name() + "." +
    location.method_name() + "() returned the following error from ODBC\n\n" +
    "\n".join(get_records().values())


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

  new create_penv(htype: ODBCHandleEnv tag, sl: SourceLoc val = __loc) => None
    location = sl
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create_penv(htype, num)?))
      else
        break
      end
    end

  new create_pdbc(htype: ODBCHandleDbc tag, sl: SourceLoc val = __loc) => None
    location = sl
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create_pdbc(htype, num)?))
      else
        break
      end
    end

  new create_pstmt(htype: ODBCHandleStmt tag, sl: SourceLoc val = __loc) =>
    location = sl
    for num in Range[I16](1,1024) do
      try
        records.push((num, SQLDiagFrame.create_pstmt(htype, num)?))
      else
        break
      end
    end


