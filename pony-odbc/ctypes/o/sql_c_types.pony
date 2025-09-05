use "debug"

class SQLDescribeColOut
  var column_number: U16 = 1
  var column_name: CBoxedArray = CBoxedArray(4096)
  var writtenlen:    CBoxedI16 = CBoxedI16
  var datatype:      CBoxedI16 = CBoxedI16
  var colsize:       CBoxedU64 = CBoxedU64
  var decdigits:     CBoxedI16 = CBoxedI16
  var nullable:      CBoxedI16 = CBoxedI16


/*



class SQLCChar
  var strct: CBoxedArray = CBoxedArray

struct CBoxedI8
  var value: I8 = I8(0)
  fun sizeof(): I64 => 1

struct CBoxedU8
  var value: U8 = U8(0)
  fun sizeof(): I64 => 1

struct CBoxedI16
  var value: I16 = I16(0)
  fun sizeof(): I64 => 2

struct CBoxedU16
  var value: U16 = U16(0)
  fun sizeof(): I64 => 2


struct CBoxedI32
  var value: I32 = I32(0)
  fun sizeof(): I64 => 4
  new create(a: I32 = 0) => value = a

struct CBoxedU32
  var value: U32 = U32(4)
  fun sizeof(): I64 => 2

struct CBoxedF32
  var value: F32 = F32(0)
  fun sizeof(): I64 => 4

struct CBoxedF64
  var value: F64 = F64(0)
  fun sizeof(): I64 => 8


struct CBoxedI64
  var value: I64 = I64(0)
  fun sizeof(): I64 => 8

struct CBoxedU64
  var value: U64 = U64(0)
  fun sizeof(): I64 => 8

//SQL_C_TYPE_DATE	SQL_DATE_STRUCT	struct with year/month/day
/*
  Source: /usr/include/iodbc/sqltypes.h:242
  Original Name: tagDATE_STRUCT
  Struct Size (bits):  48
  Struct Align (bits): 16

  Fields (Offset in bits):
     000000: [FundamentalType(short int) size=16]: year
     000016: [FundamentalType(short unsigned int) size=16]: month
     000032: [FundamentalType(short unsigned int) size=16]: day
*/
struct SQLCTypeDate
  var year: I16 = I16(0)
  var month: U16 = U16(0)
  var day: U16 = U16(0)

  fun sizeof(): I64 => 6

//SQL_C_TYPE_TIME	SQL_TIME_STRUCT	struct with hour/min/sec
/*
  Source: /usr/include/iodbc/sqltypes.h:255
  Original Name: tagTIME_STRUCT
  Struct Size (bits):  48
  Struct Align (bits): 16

  Fields (Offset in bits):
     000000: [FundamentalType(short unsigned int) size=16]: hour
     000016: [FundamentalType(short unsigned int) size=16]: minute
     000032: [FundamentalType(short unsigned int) size=16]: second
*/
struct SQLCTypeTime
  var hour: U16 = U16(0)
  var minute: U16 = U16(0)
  var second: U16 = U16(0)

  fun sizeof(): I64 => 6

//SQL_C_TYPE_TIMESTAMP	SQL_TIMESTAMP_STRUCT	struct with full date/time
/*
  Source: /usr/include/iodbc/sqltypes.h:268
  Original Name: tagTIMESTAMP_STRUCT
  Struct Size (bits):  128
  Struct Align (bits): 32

  Fields (Offset in bits):
     000000: [FundamentalType(short int) size=16]: year
     000016: [FundamentalType(short unsigned int) size=16]: month
     000032: [FundamentalType(short unsigned int) size=16]: day
     000048: [FundamentalType(short unsigned int) size=16]: hour
     000064: [FundamentalType(short unsigned int) size=16]: minute
     000080: [FundamentalType(short unsigned int) size=16]: second
     000096: [FundamentalType(unsigned int) size=32]: fraction
*/
struct SQLCTypeTimestamp
  var year: I16 = I16(0)
  var month: U16 = U16(0)
  var day: U16 = U16(0)
  var hour: U16 = U16(0)
  var minute: U16 = U16(0)
  var second: U16 = U16(0)
  var fraction: U32 = U32(0)

  fun sizeof(): I64 => 16

//SQL_C_NUMERIC	SQL_NUMERIC_STRUCT	struct for DECIMAL types
/*
  Source: /usr/include/iodbc/sqltypes.h:374
  Original Name: tagSQL_NUMERIC_STRUCT
  Struct Size (bits):  152
  Struct Align (bits): 8

  Fields (Offset in bits):
     000000: [FundamentalType(unsigned char) size=8]: precision
     000008: [FundamentalType(signed char) size=8]: scale
     000016: [FundamentalType(unsigned char) size=8]: sign
     000024: [ArrayType size=(0-15)]->[FundamentalType(unsigned char) size=8]
*/
struct SQLCNumeric
  var precision: U8 = U8(0)
  var scale: I8 = I8(0)
  var sign: U8 = U8(0)
  var val0: U8 = U8(0)
  var val1: U8 = U8(0)
  var val2: U8 = U8(0)
  var val3: U8 = U8(0)
  var val4: U8 = U8(0)
  var val5: U8 = U8(0)
  var val6: U8 = U8(0)
  var val7: U8 = U8(0)
  var val8: U8 = U8(0)
  var val9: U8 = U8(0)
  var vala: U8 = U8(0)
  var valb: U8 = U8(0)
  var valc: U8 = U8(0)
  var vald: U8 = U8(0)
  var vale: U8 = U8(0)

  fun sizeof(): I64 => 19
//SQL_C_GUID	SQLGUID	struct for UUIDs
/*
  Source: /usr/include/iodbc/sqltypes.h:389
  Original Name: tagSQLGUID
  Struct Size (bits):  128
  Struct Align (bits): 32

  Fields (Offset in bits):
     000000: [FundamentalType(unsigned int) size=32]: Data1
     000032: [FundamentalType(short unsigned int) size=16]: Data2
     000048: [FundamentalType(short unsigned int) size=16]: Data3
     000064: [ArrayType size=(0-7)]->[FundamentalType(unsigned char) size=8]
*/
struct SQLCGuid
  var data1: U32 = U32(0)
  var data2: U16 = U16(0)
  var data3: U16 = U16(0)
  var data10: U8 = U8(0)
  var data11: U8 = U8(0)
  var data12: U8 = U8(0)
  var data13: U8 = U8(0)
  var data14: U8 = U8(0)
  var data15: U8 = U8(0)
  var data16: U8 = U8(0)
  var data17: U8 = U8(0)

  fun sizeof(): I64 => 16

/*C type identifier	ODBC C typedef	C type
SQL_C_BOOKMARK[i]	BOOKMARK	unsigned long int[d]
SQL_C_VARBOOKMARK	SQLCHAR *	unsigned char *
All C interval data types	SQL_INTERVAL_STRUCT	See the C Interval Structure section, later in this appendix.
*/
*/
