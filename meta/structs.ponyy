

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
struct TagDATESTRUCTStruct
  var _year: I16 = I16(0)
  var _month: U16 = U16(0)
  var _day: U16 = U16(0)


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
struct TagTIMESTRUCTStruct
  var _hour: U16 = U16(0)
  var _minute: U16 = U16(0)
  var _second: U16 = U16(0)


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
struct TagTIMESTAMPSTRUCTStruct
  var _year: I16 = I16(0)
  var _month: U16 = U16(0)
  var _day: U16 = U16(0)
  var _hour: U16 = U16(0)
  var _minute: U16 = U16(0)
  var _second: U16 = U16(0)
  var _fraction: U32 = U32(0)


/*
  Source: /usr/include/iodbc/sqltypes.h:310
  Original Name: tagSQL_YEAR_MONTH
  Struct Size (bits):  64
  Struct Align (bits): 32

  Fields (Offset in bits):
     000000: [FundamentalType(unsigned int) size=32]: year  
     000032: [FundamentalType(unsigned int) size=32]: month  
*/
struct TagSQLYEARMONTHStruct
  var _year: U32 = U32(0)
  var _month: U32 = U32(0)


/*
  Source: /usr/include/iodbc/sqltypes.h:318
  Original Name: tagSQL_DAY_SECOND
  Struct Size (bits):  160
  Struct Align (bits): 32

  Fields (Offset in bits):
     000000: [FundamentalType(unsigned int) size=32]: day  
     000032: [FundamentalType(unsigned int) size=32]: hour  
     000064: [FundamentalType(unsigned int) size=32]: minute  
     000096: [FundamentalType(unsigned int) size=32]: second  
     000128: [FundamentalType(unsigned int) size=32]: fraction  
*/
struct TagSQLDAYSECONDStruct
  var _day: U32 = U32(0)
  var _hour: U32 = U32(0)
  var _minute: U32 = U32(0)
  var _second: U32 = U32(0)
  var _fraction: U32 = U32(0)


/*
  Source: /usr/include/iodbc/sqltypes.h:329
  Original Name: tagSQL_INTERVAL_STRUCT
  Struct Size (bits):  224
  Struct Align (bits): 32

  Fields (Offset in bits):
     000000: [Enumeration size=32,fid: f37]: interval_type  
     000032: [FundamentalType(short int) size=16]: interval_sign  
     000064: [UNION size=160] -- UNSUPPORTED FIXME: intval  
*/
struct TagSQLINTERVALSTRUCTStruct
  var _interval_type: I32 = I32(0)
  var _interval_sign: I16 = I16(0)
  var _intval: None = None


/*
  Source: /usr/include/iodbc/sqltypes.h:374
  Original Name: tagSQL_NUMERIC_STRUCT
  Struct Size (bits):  152
  Struct Align (bits): 8

  Fields (Offset in bits):
     000000: [FundamentalType(unsigned char) size=8]: precision  
     000008: [FundamentalType(signed char) size=8]: scale  
     000016: [FundamentalType(unsigned char) size=8]: sign  
     000024: [ArrayType size=(0-15)]->[FundamentalType(unsigned char) size=8] -- UNSUPPORTED - FIXME: val  
*/
struct TagSQLNUMERICSTRUCTStruct
  var _precision: U8 = U8(0)
  var _scale: I8 = I8(0)
  var _sign: U8 = U8(0)
  var _val: Pointer[U8] = Pointer[U8]


/*
  Source: /usr/include/iodbc/sqltypes.h:389
  Original Name: tagSQLGUID
  Struct Size (bits):  128
  Struct Align (bits): 32

  Fields (Offset in bits):
     000000: [FundamentalType(unsigned int) size=32]: Data1  
     000032: [FundamentalType(short unsigned int) size=16]: Data2  
     000048: [FundamentalType(short unsigned int) size=16]: Data3  
     000064: [ArrayType size=(0-7)]->[FundamentalType(unsigned char) size=8] -- UNSUPPORTED - FIXME: Data4  
*/
struct TagSQLGUIDStruct
  var _Data1: U32 = U32(0)
  var _Data2: U16 = U16(0)
  var _Data3: U16 = U16(0)
  var _Data4: Pointer[U8] = Pointer[U8]
