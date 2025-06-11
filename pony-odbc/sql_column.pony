use "debug"

use @SQLDescribeCol[I16](
  StatementHandle: Pointer[None] tag,
  ColumnNumber: U16,
      ColumnName: Pointer[U8] tag,
      BufferLength: I16, NameLength: Pointer[I16] tag,

  DataType: Pointer[I16] tag,
  ColumnSize: Pointer[U64] tag,
  DecimalDigits: Pointer[I16] tag,
  Nullable: Pointer[I16] tag)




class SQLColumn
  var columnname: String ref = ".".mul(512) // FIXME
  var namelength: I16 = 0
  var datatype: I16 = 0 // FIXME
  var columnsize: U64 = 0 // FIXME
  var decimaldigits: I16 = 0 // FIXME
  var nullable: I16 = 0 // FIXME

  new create(stmt: HandleSTMT, colnum: U16) ? =>
    match @SQLDescribeCol(stmt.h(),
                    colnum,
                    columnname.cstring(),
                    512,
                    addressof namelength,
                    addressof datatype,
                    addressof columnsize,
                    addressof decimaldigits,
                    addressof nullable)
    | 0 => columnname.recalc()
    | 1 => columnname.recalc()
    else
      error
    end
    columnname.recalc()
    Debug.out(columnname + "[datatype]: " + datatype.string())
    Debug.out(columnname + "[columnsize]: " + columnsize.string())
    Debug.out(columnname + "[decimaldigits]: " + decimaldigits.string())
    Debug.out(columnname + "[nullable]: " + nullable.string())
    Debug.out("")

