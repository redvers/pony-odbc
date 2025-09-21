

/*
  Source: /usr/include/iodbc/sql.h:781
  Original Name: SQLAllocConnect/usr/include/iodbc/sql.h:781

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocConnect[I16](EnvironmentHandle: Pointer[None] tag, ConnectionHandle: NullablePointer[Pointer[None]Struct] tag)



/*
  Source: /usr/include/iodbc/sql.h:785
  Original Name: SQLAllocEnv/usr/include/iodbc/sql.h:785

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocEnv[I16](EnvironmentHandle: NullablePointer[Pointer[None]Struct] tag)



/*
  Source: /usr/include/iodbc/sql.h:789
  Original Name: SQLAllocHandle/usr/include/iodbc/sql.h:789

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocHandle[I16](HandleType: I16, InputHandle: Pointer[None] tag, OutputHandle: NullablePointer[Pointer[None]Struct] tag)



/*
  Source: /usr/include/iodbc/sql.h:795
  Original Name: SQLAllocStmt/usr/include/iodbc/sql.h:795

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocStmt[I16](ConnectionHandle: Pointer[None] tag, StatementHandle: NullablePointer[Pointer[None]Struct] tag)



/*
  Source: /usr/include/iodbc/sql.h:799
  Original Name: SQLBindCol/usr/include/iodbc/sql.h:799

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLBindCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, TargetType: I16, TargetValue: Pointer[None] tag, BufferLength: I64, StrLenorInd: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sql.h:808
  Original Name: SQLBindParam/usr/include/iodbc/sql.h:808

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(long unsigned int) size=64]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLBindParam[I16](StatementHandle: Pointer[None] tag, ParameterNumber: U16, ValueType: I16, ParameterType: I16, LengthPrecision: U64, ParameterScale: I16, ParameterValue: Pointer[None] tag, StrLenorInd: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sql.h:819
  Original Name: SQLCancel/usr/include/iodbc/sql.h:819

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLCancel[I16](StatementHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:823
  Original Name: SQLCloseCursor/usr/include/iodbc/sql.h:823

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLCloseCursor[I16](StatementHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:831
  Original Name: SQLColAttribute/usr/include/iodbc/sql.h:831

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLColAttribute[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, FieldIdentifier: U16, CharacterAttribute: Pointer[None] tag, BufferLength: I16, StringLength: Pointer[I16] tag, NumericAttribute: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sql.h:841
  Original Name: SQLColumns/usr/include/iodbc/sql.h:841

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLColumns[I16](StatementHandle: Pointer[None] tag, CatalogName: Pointer[U8] tag, NameLength1: I16, SchemaName: Pointer[U8] tag, NameLength2: I16, TableName: Pointer[U8] tag, NameLength3: I16, ColumnName: Pointer[U8] tag, NameLength4: I16)



/*
  Source: /usr/include/iodbc/sql.h:852
  Original Name: SQLConnect/usr/include/iodbc/sql.h:852

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLConnect[I16](ConnectionHandle: Pointer[None] tag, ServerName: Pointer[U8] tag, NameLength1: I16, UserName: Pointer[U8] tag, NameLength2: I16, Authentication: Pointer[U8] tag, NameLength3: I16)



/*
  Source: /usr/include/iodbc/sql.h:862
  Original Name: SQLCopyDesc/usr/include/iodbc/sql.h:862

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLCopyDesc[I16](SourceDescHandle: Pointer[None] tag, TargetDescHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:867
  Original Name: SQLDataSources/usr/include/iodbc/sql.h:867

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDataSources[I16](EnvironmentHandle: Pointer[None] tag, Direction: U16, ServerName: Pointer[U8] tag, BufferLength1: I16, NameLength1: Pointer[I16] tag, Description: Pointer[U8] tag, BufferLength2: I16, NameLength2: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:877
  Original Name: SQLDescribeCol/usr/include/iodbc/sql.h:877

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDescribeCol[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, ColumnName: Pointer[U8] tag, BufferLength: I16, NameLength: Pointer[I16] tag, DataType: Pointer[I16] tag, ColumnSize: Pointer[U64] tag, DecimalDigits: Pointer[I16] tag, Nullable: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:888
  Original Name: SQLDisconnect/usr/include/iodbc/sql.h:888

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLDisconnect[I16](ConnectionHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:892
  Original Name: SQLEndTran/usr/include/iodbc/sql.h:892

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLEndTran[I16](HandleType: I16, Handle: Pointer[None] tag, CompletionType: I16)



/*
  Source: /usr/include/iodbc/sql.h:898
  Original Name: SQLError/usr/include/iodbc/sql.h:898

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLError[I16](EnvironmentHandle: Pointer[None] tag, ConnectionHandle: Pointer[None] tag, StatementHandle: Pointer[None] tag, Sqlstate: Pointer[U8] tag, NativeError: Pointer[I32] tag, MessageText: Pointer[U8] tag, BufferLength: I16, TextLength: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:908
  Original Name: SQLExecDirect/usr/include/iodbc/sql.h:908

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLExecDirect[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:913
  Original Name: SQLExecute/usr/include/iodbc/sql.h:913

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLExecute[I16](StatementHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:916
  Original Name: SQLFetch/usr/include/iodbc/sql.h:916

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFetch[I16](StatementHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:920
  Original Name: SQLFetchScroll/usr/include/iodbc/sql.h:920

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(long int) size=64]
*/
use @SQLFetchScroll[I16](StatementHandle: Pointer[None] tag, FetchOrientation: I16, FetchOffset: I64)



/*
  Source: /usr/include/iodbc/sql.h:926
  Original Name: SQLFreeConnect/usr/include/iodbc/sql.h:926

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFreeConnect[I16](ConnectionHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:929
  Original Name: SQLFreeEnv/usr/include/iodbc/sql.h:929

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFreeEnv[I16](EnvironmentHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:933
  Original Name: SQLFreeHandle/usr/include/iodbc/sql.h:933

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:938
  Original Name: SQLFreeStmt/usr/include/iodbc/sql.h:938

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLFreeStmt[I16](StatementHandle: Pointer[None] tag, Option: U16)



/*
  Source: /usr/include/iodbc/sql.h:943
  Original Name: SQLGetConnectAttr/usr/include/iodbc/sql.h:943

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sql.h:951
  Original Name: SQLGetConnectOption/usr/include/iodbc/sql.h:951

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetConnectOption[I16](ConnectionHandle: Pointer[None] tag, Option: U16, Value: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:956
  Original Name: SQLGetCursorName/usr/include/iodbc/sql.h:956

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetCursorName[I16](StatementHandle: Pointer[None] tag, CursorName: Pointer[U8] tag, BufferLength: I16, NameLength: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:962
  Original Name: SQLGetData/usr/include/iodbc/sql.h:962

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLGetData[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, TargetType: I16, TargetValue: Pointer[None] tag, BufferLength: I64, StrLenorInd: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sql.h:971
  Original Name: SQLGetDescField/usr/include/iodbc/sql.h:971

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetDescField[I16](DescriptorHandle: Pointer[None] tag, RecNumber: I16, FieldIdentifier: I16, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sql.h:979
  Original Name: SQLGetDescRec/usr/include/iodbc/sql.h:979

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDescRec[I16](DescriptorHandle: Pointer[None] tag, RecNumber: I16, Name: Pointer[U8] tag, BufferLength: I16, StringLength: Pointer[I16] tag, Type: Pointer[I16] tag, SubType: Pointer[I16] tag, Length: Pointer[I64] tag, Precision: Pointer[I16] tag, Scale: Pointer[I16] tag, Nullable: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:992
  Original Name: SQLGetDiagField/usr/include/iodbc/sql.h:992

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDiagField[I16](HandleType: I16, Handle: Pointer[None] tag, RecNumber: I16, DiagIdentifier: I16, DiagInfo: Pointer[None] tag, BufferLength: I16, StringLength: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:1001
  Original Name: SQLGetDiagRec/usr/include/iodbc/sql.h:1001

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDiagRec[I16](HandleType: I16, Handle: Pointer[None] tag, RecNumber: I16, Sqlstate: Pointer[U8] tag, NativeError: Pointer[I32] tag, MessageText: Pointer[U8] tag, BufferLength: I16, TextLength: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:1011
  Original Name: SQLGetEnvAttr/usr/include/iodbc/sql.h:1011

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sql.h:1019
  Original Name: SQLGetFunctions/usr/include/iodbc/sql.h:1019

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(short unsigned int) size=16]
*/
use @SQLGetFunctions[I16](ConnectionHandle: Pointer[None] tag, FunctionId: U16, Supported: Pointer[U16] tag)



/*
  Source: /usr/include/iodbc/sql.h:1024
  Original Name: SQLGetInfo/usr/include/iodbc/sql.h:1024

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetInfo[I16](ConnectionHandle: Pointer[None] tag, InfoType: U16, InfoValue: Pointer[None] tag, BufferLength: I16, StringLength: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:1032
  Original Name: SQLGetStmtAttr/usr/include/iodbc/sql.h:1032

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetStmtAttr[I16](StatementHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sql.h:1040
  Original Name: SQLGetStmtOption/usr/include/iodbc/sql.h:1040

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetStmtOption[I16](StatementHandle: Pointer[None] tag, Option: U16, Value: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:1045
  Original Name: SQLGetTypeInfo/usr/include/iodbc/sql.h:1045

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLGetTypeInfo[I16](StatementHandle: Pointer[None] tag, DataType: I16)



/*
  Source: /usr/include/iodbc/sql.h:1049
  Original Name: SQLNumResultCols/usr/include/iodbc/sql.h:1049

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLNumResultCols[I16](StatementHandle: Pointer[None] tag, ColumnCount: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sql.h:1053
  Original Name: SQLParamData/usr/include/iodbc/sql.h:1053

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLParamData[I16](StatementHandle: Pointer[None] tag, Value: NullablePointer[Pointer[None]Struct] tag)



/*
  Source: /usr/include/iodbc/sql.h:1057
  Original Name: SQLPrepare/usr/include/iodbc/sql.h:1057

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLPrepare[I16](StatementHandle: Pointer[None] tag, StatementText: Pointer[U8] tag, TextLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1062
  Original Name: SQLPutData/usr/include/iodbc/sql.h:1062

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long int) size=64]
*/
use @SQLPutData[I16](StatementHandle: Pointer[None] tag, Data: Pointer[None] tag, StrLenorInd: I64)



/*
  Source: /usr/include/iodbc/sql.h:1067
  Original Name: SQLRowCount/usr/include/iodbc/sql.h:1067

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLRowCount[I16](StatementHandle: Pointer[None] tag, RowCount: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sql.h:1072
  Original Name: SQLSetConnectAttr/usr/include/iodbc/sql.h:1072

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetConnectAttr[I16](ConnectionHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, StringLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1079
  Original Name: SQLSetConnectOption/usr/include/iodbc/sql.h:1079

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetConnectOption[I16](ConnectionHandle: Pointer[None] tag, Option: U16, Value: U64)



/*
  Source: /usr/include/iodbc/sql.h:1084
  Original Name: SQLSetCursorName/usr/include/iodbc/sql.h:1084

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLSetCursorName[I16](StatementHandle: Pointer[None] tag, CursorName: Pointer[U8] tag, NameLength: I16)



/*
  Source: /usr/include/iodbc/sql.h:1090
  Original Name: SQLSetDescField/usr/include/iodbc/sql.h:1090

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetDescField[I16](DescriptorHandle: Pointer[None] tag, RecNumber: I16, FieldIdentifier: I16, Value: Pointer[None] tag, BufferLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1097
  Original Name: SQLSetDescRec/usr/include/iodbc/sql.h:1097

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(long int) size=64]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLSetDescRec[I16](DescriptorHandle: Pointer[None] tag, RecNumber: I16, Type: I16, SubType: I16, Length: I64, Precision: I16, Scale: I16, Data: Pointer[None] tag, StringLength: Pointer[I64] tag, Indicator: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sql.h:1109
  Original Name: SQLSetEnvAttr/usr/include/iodbc/sql.h:1109

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, StringLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1118
  Original Name: SQLSetStmtAttr/usr/include/iodbc/sql.h:1118

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetStmtAttr[I16](StatementHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, StringLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1125
  Original Name: SQLSetStmtOption/usr/include/iodbc/sql.h:1125

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetStmtOption[I16](StatementHandle: Pointer[None] tag, Option: U16, Value: U64)



/*
  Source: /usr/include/iodbc/sql.h:1130
  Original Name: SQLSpecialColumns/usr/include/iodbc/sql.h:1130

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLSpecialColumns[I16](StatementHandle: Pointer[None] tag, IdentifierType: U16, CatalogName: Pointer[U8] tag, NameLength1: I16, SchemaName: Pointer[U8] tag, NameLength2: I16, TableName: Pointer[U8] tag, NameLength3: I16, Scope: U16, Nullable: U16)



/*
  Source: /usr/include/iodbc/sql.h:1142
  Original Name: SQLStatistics/usr/include/iodbc/sql.h:1142

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLStatistics[I16](StatementHandle: Pointer[None] tag, CatalogName: Pointer[U8] tag, NameLength1: I16, SchemaName: Pointer[U8] tag, NameLength2: I16, TableName: Pointer[U8] tag, NameLength3: I16, Unique: U16, Reserved: U16)



/*
  Source: /usr/include/iodbc/sql.h:1153
  Original Name: SQLTables/usr/include/iodbc/sql.h:1153

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLTables[I16](StatementHandle: Pointer[None] tag, CatalogName: Pointer[U8] tag, NameLength1: I16, SchemaName: Pointer[U8] tag, NameLength2: I16, TableName: Pointer[U8] tag, NameLength3: I16, TableType: Pointer[U8] tag, NameLength4: I16)



/*
  Source: /usr/include/iodbc/sql.h:1164
  Original Name: SQLTransact/usr/include/iodbc/sql.h:1164

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLTransact[I16](EnvironmentHandle: Pointer[None] tag, ConnectionHandle: Pointer[None] tag, CompletionType: U16)



/*
  Source: /usr/include/iodbc/sql.h:1173
  Original Name: SQLSetParam/usr/include/iodbc/sql.h:1173

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(long unsigned int) size=64]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLSetParam[I16](StatementHandle: Pointer[None] tag, ParameterNumber: U16, ValueType: I16, ParameterType: I16, LengthPrecision: U64, ParameterScale: I16, ParameterValue: Pointer[None] tag, StrLenorInd: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2357
  Original Name: SQLDriverConnect/usr/include/iodbc/sqlext.h:2357

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLDriverConnect[I16](hdbc: Pointer[None] tag, hwnd: Pointer[None] tag, szConnStrIn: Pointer[U8] tag, cbConnStrIn: I16, szConnStrOut: Pointer[U8] tag, cbConnStrOutMax: I16, pcbConnStrOut: Pointer[I16] tag, fDriverCompletion: U16)



/*
  Source: /usr/include/iodbc/sqlext.h:2371
  Original Name: SQLBrowseConnect/usr/include/iodbc/sqlext.h:2371

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLBrowseConnect[I16](hdbc: Pointer[None] tag, szConnStrIn: Pointer[U8] tag, cbConnStrIn: I16, szConnStrOut: Pointer[U8] tag, cbConnStrOutMax: I16, pcbConnStrOut: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2380
  Original Name: SQLBulkOperations/usr/include/iodbc/sqlext.h:2380

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLBulkOperations[I16](StatementHandle: Pointer[None] tag, Operation: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2385
  Original Name: SQLColAttributes/usr/include/iodbc/sqlext.h:2385

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLColAttributes[I16](hstmt: Pointer[None] tag, icol: U16, fDescType: U16, rgbDesc: Pointer[None] tag, cbDescMax: I16, pcbDesc: Pointer[I16] tag, pfDesc: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2394
  Original Name: SQLColumnPrivileges/usr/include/iodbc/sqlext.h:2394

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLColumnPrivileges[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16, szColumnName: Pointer[U8] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2405
  Original Name: SQLDescribeParam/usr/include/iodbc/sqlext.h:2405

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDescribeParam[I16](hstmt: Pointer[None] tag, ipar: U16, pfSqlType: Pointer[I16] tag, pcbParamDef: Pointer[U64] tag, pibScale: Pointer[I16] tag, pfNullable: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2413
  Original Name: SQLExtendedFetch/usr/include/iodbc/sqlext.h:2413

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(short unsigned int) size=16]
*/
use @SQLExtendedFetch[I16](hstmt: Pointer[None] tag, fFetchType: U16, irow: I64, pcrow: Pointer[U64] tag, rgfRowStatus: Pointer[U16] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2420
  Original Name: SQLForeignKeys/usr/include/iodbc/sqlext.h:2420

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLForeignKeys[I16](hstmt: Pointer[None] tag, szPkCatalogName: Pointer[U8] tag, cbPkCatalogName: I16, szPkSchemaName: Pointer[U8] tag, cbPkSchemaName: I16, szPkTableName: Pointer[U8] tag, cbPkTableName: I16, szFkCatalogName: Pointer[U8] tag, cbFkCatalogName: I16, szFkSchemaName: Pointer[U8] tag, cbFkSchemaName: I16, szFkTableName: Pointer[U8] tag, cbFkTableName: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2435
  Original Name: SQLMoreResults/usr/include/iodbc/sqlext.h:2435

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLMoreResults[I16](hstmt: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2438
  Original Name: SQLNativeSql/usr/include/iodbc/sqlext.h:2438

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLNativeSql[I16](hdbc: Pointer[None] tag, szSqlStrIn: Pointer[U8] tag, cbSqlStrIn: I32, szSqlStr: Pointer[U8] tag, cbSqlStrMax: I32, pcbSqlStr: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2446
  Original Name: SQLNumParams/usr/include/iodbc/sqlext.h:2446

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLNumParams[I16](hstmt: Pointer[None] tag, pcpar: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2450
  Original Name: SQLParamOptions/usr/include/iodbc/sqlext.h:2450

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
*/
use @SQLParamOptions[I16](hstmt: Pointer[None] tag, crow: U64, pirow: Pointer[U64] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2455
  Original Name: SQLPrimaryKeys/usr/include/iodbc/sqlext.h:2455

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLPrimaryKeys[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2464
  Original Name: SQLProcedureColumns/usr/include/iodbc/sqlext.h:2464

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLProcedureColumns[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szProcName: Pointer[U8] tag, cbProcName: I16, szColumnName: Pointer[U8] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2475
  Original Name: SQLProcedures/usr/include/iodbc/sqlext.h:2475

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLProcedures[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szProcName: Pointer[U8] tag, cbProcName: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2484
  Original Name: SQLSetPos/usr/include/iodbc/sqlext.h:2484

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLSetPos[I16](hstmt: Pointer[None] tag, irow: U16, fOption: U16, fLock: U16)



/*
  Source: /usr/include/iodbc/sqlext.h:2490
  Original Name: SQLTablePrivileges/usr/include/iodbc/sqlext.h:2490

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLTablePrivileges[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2499
  Original Name: SQLDrivers/usr/include/iodbc/sqlext.h:2499

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDrivers[I16](henv: Pointer[None] tag, fDirection: U16, szDriverDesc: Pointer[U8] tag, cbDriverDescMax: I16, pcbDriverDesc: Pointer[I16] tag, szDriverAttributes: Pointer[U8] tag, cbDrvrAttrMax: I16, pcbDrvrAttr: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2509
  Original Name: SQLBindParameter/usr/include/iodbc/sqlext.h:2509

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [FundamentalType(long unsigned int) size=64]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLBindParameter[I16](hstmt: Pointer[None] tag, ipar: U16, fParamType: I16, fCType: I16, fSqlType: I16, cbColDef: U64, ibScale: I16, rgbValue: Pointer[None] tag, cbValueMax: I64, pcbValue: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2524
  Original Name: SQLSetScrollOptions/usr/include/iodbc/sqlext.h:2524

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long int) size=64]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLSetScrollOptions[I16](hstmt: Pointer[None] tag, fConcurrency: U16, crowKeyset: I64, crowRowset: U16)



/*
  Source: /usr/include/iodbc/sqlucode.h:121
  Original Name: SQLColAttributeW/usr/include/iodbc/sqlucode.h:121

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLColAttributeW[I16](hstmt: Pointer[None] tag, iCol: U16, iField: U16, pCharAttr: Pointer[None] tag, cbCharAttrMax: I16, pcbCharAttr: Pointer[I16] tag, pNumAttr: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:130
  Original Name: SQLColAttributesW/usr/include/iodbc/sqlucode.h:130

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLColAttributesW[I16](hstmt: Pointer[None] tag, icol: U16, fDescType: U16, rgbDesc: Pointer[None] tag, cbDescMax: I16, pcbDesc: Pointer[I16] tag, pfDesc: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:139
  Original Name: SQLConnectW/usr/include/iodbc/sqlucode.h:139

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLConnectW[I16](hdbc: Pointer[None] tag, szDSN: Pointer[I32] tag, cbDSN: I16, szUID: Pointer[I32] tag, cbUID: I16, szAuthStr: Pointer[I32] tag, cbAuthStr: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:148
  Original Name: SQLDescribeColW/usr/include/iodbc/sqlucode.h:148

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDescribeColW[I16](hstmt: Pointer[None] tag, icol: U16, szColName: Pointer[I32] tag, cbColNameMax: I16, pcbColName: Pointer[I16] tag, pfSqlType: Pointer[I16] tag, pcbColDef: Pointer[U64] tag, pibScale: Pointer[I16] tag, pfNullable: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:159
  Original Name: SQLErrorW/usr/include/iodbc/sqlucode.h:159

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLErrorW[I16](henv: Pointer[None] tag, hdbc: Pointer[None] tag, hstmt: Pointer[None] tag, szSqlState: Pointer[I32] tag, pfNativeError: Pointer[I32] tag, szErrorMsg: Pointer[I32] tag, cbErrorMsgMax: I16, pcbErrorMsg: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:169
  Original Name: SQLExecDirectW/usr/include/iodbc/sqlucode.h:169

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
*/
use @SQLExecDirectW[I16](hstmt: Pointer[None] tag, szSqlStr: Pointer[I32] tag, cbSqlStr: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:174
  Original Name: SQLGetConnectAttrW/usr/include/iodbc/sqlucode.h:174

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetConnectAttrW[I16](hdbc: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValueMax: I32, pcbValue: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:181
  Original Name: SQLGetCursorNameW/usr/include/iodbc/sqlucode.h:181

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetCursorNameW[I16](hstmt: Pointer[None] tag, szCursor: Pointer[I32] tag, cbCursorMax: I16, pcbCursor: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:188
  Original Name: SQLSetDescFieldW/usr/include/iodbc/sqlucode.h:188

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetDescFieldW[I16](DescriptorHandle: Pointer[None] tag, RecNumber: I16, FieldIdentifier: I16, Value: Pointer[None] tag, BufferLength: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:195
  Original Name: SQLGetDescFieldW/usr/include/iodbc/sqlucode.h:195

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetDescFieldW[I16](hdesc: Pointer[None] tag, iRecord: I16, iField: I16, rgbValue: Pointer[None] tag, cbValueMax: I32, pcbValue: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:203
  Original Name: SQLGetDescRecW/usr/include/iodbc/sqlucode.h:203

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDescRecW[I16](hdesc: Pointer[None] tag, iRecord: I16, szName: Pointer[I32] tag, cbNameMax: I16, pcbName: Pointer[I16] tag, pfType: Pointer[I16] tag, pfSubType: Pointer[I16] tag, pLength: Pointer[I64] tag, pPrecision: Pointer[I16] tag, pScale: Pointer[I16] tag, pNullable: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:216
  Original Name: SQLGetDiagFieldW/usr/include/iodbc/sqlucode.h:216

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDiagFieldW[I16](fHandleType: I16, handle: Pointer[None] tag, iRecord: I16, fDiagField: I16, rgbDiagInfo: Pointer[None] tag, cbDiagInfoMax: I16, pcbDiagInfo: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:225
  Original Name: SQLGetDiagRecW/usr/include/iodbc/sqlucode.h:225

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDiagRecW[I16](fHandleType: I16, handle: Pointer[None] tag, iRecord: I16, szSqlState: Pointer[I32] tag, pfNativeError: Pointer[I32] tag, szErrorMsg: Pointer[I32] tag, cbErrorMsgMax: I16, pcbErrorMsg: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:236
  Original Name: SQLPrepareW/usr/include/iodbc/sqlucode.h:236

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
*/
use @SQLPrepareW[I16](hstmt: Pointer[None] tag, szSqlStr: Pointer[I32] tag, cbSqlStr: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:241
  Original Name: SQLSetConnectAttrW/usr/include/iodbc/sqlucode.h:241

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetConnectAttrW[I16](hdbc: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValue: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:247
  Original Name: SQLSetCursorNameW/usr/include/iodbc/sqlucode.h:247

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLSetCursorNameW[I16](hstmt: Pointer[None] tag, szCursor: Pointer[I32] tag, cbCursor: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:252
  Original Name: SQLColumnsW/usr/include/iodbc/sqlucode.h:252

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLColumnsW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szTableName: Pointer[I32] tag, cbTableName: I16, szColumnName: Pointer[I32] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:263
  Original Name: SQLGetConnectOptionW/usr/include/iodbc/sqlucode.h:263

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetConnectOptionW[I16](hdbc: Pointer[None] tag, fOption: U16, pvParam: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:268
  Original Name: SQLGetInfoW/usr/include/iodbc/sqlucode.h:268

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetInfoW[I16](hdbc: Pointer[None] tag, fInfoType: U16, rgbInfoValue: Pointer[None] tag, cbInfoValueMax: I16, pcbInfoValue: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:275
  Original Name: SQLGetTypeInfoW/usr/include/iodbc/sqlucode.h:275

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLGetTypeInfoW[I16](StatementHandle: Pointer[None] tag, DataType: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:279
  Original Name: SQLSetConnectOptionW/usr/include/iodbc/sqlucode.h:279

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetConnectOptionW[I16](hdbc: Pointer[None] tag, fOption: U16, vParam: U64)



/*
  Source: /usr/include/iodbc/sqlucode.h:284
  Original Name: SQLSpecialColumnsW/usr/include/iodbc/sqlucode.h:284

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLSpecialColumnsW[I16](hstmt: Pointer[None] tag, fColType: U16, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szTableName: Pointer[I32] tag, cbTableName: I16, fScope: U16, fNullable: U16)



/*
  Source: /usr/include/iodbc/sqlucode.h:296
  Original Name: SQLStatisticsW/usr/include/iodbc/sqlucode.h:296

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLStatisticsW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szTableName: Pointer[I32] tag, cbTableName: I16, fUnique: U16, fAccuracy: U16)



/*
  Source: /usr/include/iodbc/sqlucode.h:307
  Original Name: SQLTablesW/usr/include/iodbc/sqlucode.h:307

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLTablesW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szTableName: Pointer[I32] tag, cbTableName: I16, szTableType: Pointer[I32] tag, cbTableType: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:318
  Original Name: SQLDataSourcesW/usr/include/iodbc/sqlucode.h:318

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDataSourcesW[I16](henv: Pointer[None] tag, fDirection: U16, szDSN: Pointer[I32] tag, cbDSNMax: I16, pcbDSN: Pointer[I16] tag, szDescription: Pointer[I32] tag, cbDescriptionMax: I16, pcbDescription: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:328
  Original Name: SQLDriverConnectW/usr/include/iodbc/sqlucode.h:328

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLDriverConnectW[I16](hdbc: Pointer[None] tag, hwnd: Pointer[None] tag, szConnStrIn: Pointer[I32] tag, cbConnStrIn: I16, szConnStrOut: Pointer[I32] tag, cbConnStrOutMax: I16, pcbConnStrOut: Pointer[I16] tag, fDriverCompletion: U16)



/*
  Source: /usr/include/iodbc/sqlucode.h:338
  Original Name: SQLBrowseConnectW/usr/include/iodbc/sqlucode.h:338

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLBrowseConnectW[I16](hdbc: Pointer[None] tag, szConnStrIn: Pointer[I32] tag, cbConnStrIn: I16, szConnStrOut: Pointer[I32] tag, cbConnStrOutMax: I16, pcbConnStrOut: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:346
  Original Name: SQLColumnPrivilegesW/usr/include/iodbc/sqlucode.h:346

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLColumnPrivilegesW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szTableName: Pointer[I32] tag, cbTableName: I16, szColumnName: Pointer[I32] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:357
  Original Name: SQLGetStmtAttrW/usr/include/iodbc/sqlucode.h:357

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetStmtAttrW[I16](hstmt: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValueMax: I32, pcbValue: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:364
  Original Name: SQLSetStmtAttrW/usr/include/iodbc/sqlucode.h:364

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetStmtAttrW[I16](hstmt: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValueMax: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:370
  Original Name: SQLForeignKeysW/usr/include/iodbc/sqlucode.h:370

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLForeignKeysW[I16](hstmt: Pointer[None] tag, szPkCatalogName: Pointer[I32] tag, cbPkCatalogName: I16, szPkSchemaName: Pointer[I32] tag, cbPkSchemaName: I16, szPkTableName: Pointer[I32] tag, cbPkTableName: I16, szFkCatalogName: Pointer[I32] tag, cbFkCatalogName: I16, szFkSchemaName: Pointer[I32] tag, cbFkSchemaName: I16, szFkTableName: Pointer[I32] tag, cbFkTableName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:385
  Original Name: SQLNativeSqlW/usr/include/iodbc/sqlucode.h:385

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLNativeSqlW[I16](hdbc: Pointer[None] tag, szSqlStrIn: Pointer[I32] tag, cbSqlStrIn: I32, szSqlStr: Pointer[I32] tag, cbSqlStrMax: I32, pcbSqlStr: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:393
  Original Name: SQLPrimaryKeysW/usr/include/iodbc/sqlucode.h:393

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLPrimaryKeysW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szTableName: Pointer[I32] tag, cbTableName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:402
  Original Name: SQLProcedureColumnsW/usr/include/iodbc/sqlucode.h:402

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLProcedureColumnsW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szProcName: Pointer[I32] tag, cbProcName: I16, szColumnName: Pointer[I32] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:413
  Original Name: SQLProceduresW/usr/include/iodbc/sqlucode.h:413

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLProceduresW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szProcName: Pointer[I32] tag, cbProcName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:422
  Original Name: SQLTablePrivilegesW/usr/include/iodbc/sqlucode.h:422

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLTablePrivilegesW[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[I32] tag, cbCatalogName: I16, szSchemaName: Pointer[I32] tag, cbSchemaName: I16, szTableName: Pointer[I32] tag, cbTableName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:431
  Original Name: SQLDriversW/usr/include/iodbc/sqlucode.h:431

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDriversW[I16](henv: Pointer[None] tag, fDirection: U16, szDriverDesc: Pointer[I32] tag, cbDriverDescMax: I16, pcbDriverDesc: Pointer[I16] tag, szDriverAttributes: Pointer[I32] tag, cbDrvrAttrMax: I16, pcbDrvrAttr: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:446
  Original Name: SQLColAttributeA/usr/include/iodbc/sqlucode.h:446

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLColAttributeA[I16](hstmt: Pointer[None] tag, iCol: U16, iField: U16, pCharAttr: Pointer[None] tag, cbCharAttrMax: I16, pcbCharAttr: Pointer[I16] tag, pNumAttr: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:455
  Original Name: SQLColAttributesA/usr/include/iodbc/sqlucode.h:455

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLColAttributesA[I16](hstmt: Pointer[None] tag, icol: U16, fDescType: U16, rgbDesc: Pointer[None] tag, cbDescMax: I16, pcbDesc: Pointer[I16] tag, pfDesc: Pointer[I64] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:464
  Original Name: SQLConnectA/usr/include/iodbc/sqlucode.h:464

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLConnectA[I16](hdbc: Pointer[None] tag, szDSN: Pointer[U8] tag, cbDSN: I16, szUID: Pointer[U8] tag, cbUID: I16, szAuthStr: Pointer[U8] tag, cbAuthStr: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:473
  Original Name: SQLDescribeColA/usr/include/iodbc/sqlucode.h:473

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDescribeColA[I16](hstmt: Pointer[None] tag, icol: U16, szColName: Pointer[U8] tag, cbColNameMax: I16, pcbColName: Pointer[I16] tag, pfSqlType: Pointer[I16] tag, pcbColDef: Pointer[U64] tag, pibScale: Pointer[I16] tag, pfNullable: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:484
  Original Name: SQLErrorA/usr/include/iodbc/sqlucode.h:484

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLErrorA[I16](henv: Pointer[None] tag, hdbc: Pointer[None] tag, hstmt: Pointer[None] tag, szSqlState: Pointer[U8] tag, pfNativeError: Pointer[I32] tag, szErrorMsg: Pointer[U8] tag, cbErrorMsgMax: I16, pcbErrorMsg: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:494
  Original Name: SQLExecDirectA/usr/include/iodbc/sqlucode.h:494

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLExecDirectA[I16](hstmt: Pointer[None] tag, szSqlStr: Pointer[U8] tag, cbSqlStr: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:499
  Original Name: SQLGetConnectAttrA/usr/include/iodbc/sqlucode.h:499

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetConnectAttrA[I16](hdbc: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValueMax: I32, pcbValue: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:506
  Original Name: SQLGetCursorNameA/usr/include/iodbc/sqlucode.h:506

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetCursorNameA[I16](hstmt: Pointer[None] tag, szCursor: Pointer[U8] tag, cbCursorMax: I16, pcbCursor: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:513
  Original Name: SQLSetDescFieldA/usr/include/iodbc/sqlucode.h:513

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetDescFieldA[I16](DescriptorHandle: Pointer[None] tag, RecNumber: I16, FieldIdentifier: I16, Value: Pointer[None] tag, BufferLength: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:520
  Original Name: SQLGetDescFieldA/usr/include/iodbc/sqlucode.h:520

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetDescFieldA[I16](hdesc: Pointer[None] tag, iRecord: I16, iField: I16, rgbValue: Pointer[None] tag, cbValueMax: I32, pcbValue: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:528
  Original Name: SQLGetDescRecA/usr/include/iodbc/sqlucode.h:528

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(long int) size=64]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDescRecA[I16](hdesc: Pointer[None] tag, iRecord: I16, szName: Pointer[U8] tag, cbNameMax: I16, pcbName: Pointer[I16] tag, pfType: Pointer[I16] tag, pfSubType: Pointer[I16] tag, pLength: Pointer[I64] tag, pPrecision: Pointer[I16] tag, pScale: Pointer[I16] tag, pNullable: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:541
  Original Name: SQLGetDiagFieldA/usr/include/iodbc/sqlucode.h:541

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDiagFieldA[I16](fHandleType: I16, handle: Pointer[None] tag, iRecord: I16, fDiagField: I16, rgbDiagInfo: Pointer[None] tag, cbDiagInfoMax: I16, pcbDiagInfo: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:550
  Original Name: SQLGetDiagRecA/usr/include/iodbc/sqlucode.h:550

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetDiagRecA[I16](fHandleType: I16, handle: Pointer[None] tag, iRecord: I16, szSqlState: Pointer[U8] tag, pfNativeError: Pointer[I32] tag, szErrorMsg: Pointer[U8] tag, cbErrorMsgMax: I16, pcbErrorMsg: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:561
  Original Name: SQLPrepareA/usr/include/iodbc/sqlucode.h:561

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLPrepareA[I16](hstmt: Pointer[None] tag, szSqlStr: Pointer[U8] tag, cbSqlStr: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:566
  Original Name: SQLSetConnectAttrA/usr/include/iodbc/sqlucode.h:566

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetConnectAttrA[I16](hdbc: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValue: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:572
  Original Name: SQLSetCursorNameA/usr/include/iodbc/sqlucode.h:572

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLSetCursorNameA[I16](hstmt: Pointer[None] tag, szCursor: Pointer[U8] tag, cbCursor: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:577
  Original Name: SQLColumnsA/usr/include/iodbc/sqlucode.h:577

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLColumnsA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16, szColumnName: Pointer[U8] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:588
  Original Name: SQLGetConnectOptionA/usr/include/iodbc/sqlucode.h:588

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetConnectOptionA[I16](hdbc: Pointer[None] tag, fOption: U16, pvParam: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:593
  Original Name: SQLGetInfoA/usr/include/iodbc/sqlucode.h:593

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLGetInfoA[I16](hdbc: Pointer[None] tag, fInfoType: U16, rgbInfoValue: Pointer[None] tag, cbInfoValueMax: I16, pcbInfoValue: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:600
  Original Name: SQLGetTypeInfoA/usr/include/iodbc/sqlucode.h:600

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLGetTypeInfoA[I16](StatementHandle: Pointer[None] tag, DataType: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:604
  Original Name: SQLSetConnectOptionA/usr/include/iodbc/sqlucode.h:604

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetConnectOptionA[I16](hdbc: Pointer[None] tag, fOption: U16, vParam: U64)



/*
  Source: /usr/include/iodbc/sqlucode.h:609
  Original Name: SQLSpecialColumnsA/usr/include/iodbc/sqlucode.h:609

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLSpecialColumnsA[I16](hstmt: Pointer[None] tag, fColType: U16, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16, fScope: U16, fNullable: U16)



/*
  Source: /usr/include/iodbc/sqlucode.h:621
  Original Name: SQLStatisticsA/usr/include/iodbc/sqlucode.h:621

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLStatisticsA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16, fUnique: U16, fAccuracy: U16)



/*
  Source: /usr/include/iodbc/sqlucode.h:632
  Original Name: SQLTablesA/usr/include/iodbc/sqlucode.h:632

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLTablesA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16, szTableType: Pointer[U8] tag, cbTableType: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:643
  Original Name: SQLDataSourcesA/usr/include/iodbc/sqlucode.h:643

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDataSourcesA[I16](henv: Pointer[None] tag, fDirection: U16, szDSN: Pointer[U8] tag, cbDSNMax: I16, pcbDSN: Pointer[I16] tag, szDescription: Pointer[U8] tag, cbDescriptionMax: I16, pcbDescription: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:653
  Original Name: SQLDriverConnectA/usr/include/iodbc/sqlucode.h:653

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLDriverConnectA[I16](hdbc: Pointer[None] tag, hwnd: Pointer[None] tag, szConnStrIn: Pointer[U8] tag, cbConnStrIn: I16, szConnStrOut: Pointer[U8] tag, cbConnStrOutMax: I16, pcbConnStrOut: Pointer[I16] tag, fDriverCompletion: U16)



/*
  Source: /usr/include/iodbc/sqlucode.h:663
  Original Name: SQLBrowseConnectA/usr/include/iodbc/sqlucode.h:663

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLBrowseConnectA[I16](hdbc: Pointer[None] tag, szConnStrIn: Pointer[U8] tag, cbConnStrIn: I16, szConnStrOut: Pointer[U8] tag, cbConnStrOutMax: I16, pcbConnStrOut: Pointer[I16] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:671
  Original Name: SQLColumnPrivilegesA/usr/include/iodbc/sqlucode.h:671

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLColumnPrivilegesA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16, szColumnName: Pointer[U8] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:682
  Original Name: SQLGetStmtAttrA/usr/include/iodbc/sqlucode.h:682

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLGetStmtAttrA[I16](hstmt: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValueMax: I32, pcbValue: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:689
  Original Name: SQLSetStmtAttrA/usr/include/iodbc/sqlucode.h:689

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(int) size=32]
*/
use @SQLSetStmtAttrA[I16](hstmt: Pointer[None] tag, fAttribute: I32, rgbValue: Pointer[None] tag, cbValueMax: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:695
  Original Name: SQLForeignKeysA/usr/include/iodbc/sqlucode.h:695

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLForeignKeysA[I16](hstmt: Pointer[None] tag, szPkCatalogName: Pointer[U8] tag, cbPkCatalogName: I16, szPkSchemaName: Pointer[U8] tag, cbPkSchemaName: I16, szPkTableName: Pointer[U8] tag, cbPkTableName: I16, szFkCatalogName: Pointer[U8] tag, cbFkCatalogName: I16, szFkSchemaName: Pointer[U8] tag, cbFkSchemaName: I16, szFkTableName: Pointer[U8] tag, cbFkTableName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:710
  Original Name: SQLNativeSqlA/usr/include/iodbc/sqlucode.h:710

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
    [PointerType size=64]->[FundamentalType(int) size=32]
*/
use @SQLNativeSqlA[I16](hdbc: Pointer[None] tag, szSqlStrIn: Pointer[U8] tag, cbSqlStrIn: I32, szSqlStr: Pointer[U8] tag, cbSqlStrMax: I32, pcbSqlStr: Pointer[I32] tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:718
  Original Name: SQLPrimaryKeysA/usr/include/iodbc/sqlucode.h:718

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLPrimaryKeysA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:727
  Original Name: SQLProcedureColumnsA/usr/include/iodbc/sqlucode.h:727

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLProcedureColumnsA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szProcName: Pointer[U8] tag, cbProcName: I16, szColumnName: Pointer[U8] tag, cbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:738
  Original Name: SQLProceduresA/usr/include/iodbc/sqlucode.h:738

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLProceduresA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szProcName: Pointer[U8] tag, cbProcName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:747
  Original Name: SQLTablePrivilegesA/usr/include/iodbc/sqlucode.h:747

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLTablePrivilegesA[I16](hstmt: Pointer[None] tag, szCatalogName: Pointer[U8] tag, cbCatalogName: I16, szSchemaName: Pointer[U8] tag, cbSchemaName: I16, szTableName: Pointer[U8] tag, cbTableName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:756
  Original Name: SQLDriversA/usr/include/iodbc/sqlucode.h:756

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLDriversA[I16](henv: Pointer[None] tag, fDirection: U16, szDriverDesc: Pointer[U8] tag, cbDriverDescMax: I16, pcbDriverDesc: Pointer[I16] tag, szDriverAttributes: Pointer[U8] tag, cbDrvrAttrMax: I16, pcbDrvrAttr: Pointer[I16] tag)

