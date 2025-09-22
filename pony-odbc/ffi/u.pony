use ".."

/*
  Source: /usr/include/iodbc/sql.h:781
  Original Name: SQLAllocConnect/usr/include/iodbc/sql.h:781

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocConnect[I16](pEnvironmentHandle: Pointer[None] tag, pConnectionHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:785
  Original Name: SQLAllocEnv/usr/include/iodbc/sql.h:785

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocEnv[I16](pEnvironmentHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:789
  Original Name: SQLAllocHandle/usr/include/iodbc/sql.h:789

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocHandle[I16](pHandleType: I16, pInputHandle: Pointer[None] tag, pOutputHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:795
  Original Name: SQLAllocStmt/usr/include/iodbc/sql.h:795

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLAllocStmt[I16](pConnectionHandle: Pointer[None] tag, pStatementHandle: Pointer[None] tag)



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
use @SQLBindCol[I16](pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pTargetType: I16, pTargetValue: Pointer[U8] tag, pBufferLength: I64, pStrLenorInd: CBoxedI64 tag)



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
use @SQLBindParam[I16](pStatementHandle: Pointer[None] tag, pParameterNumber: U16, pValueType: I16, pParameterType: I16, pLengthPrecision: U64, pParameterScale: I16, pParameterValue: Pointer[U8] tag, pStrLenorInd: CBoxedI64 tag)



/*
  Source: /usr/include/iodbc/sql.h:819
  Original Name: SQLCancel/usr/include/iodbc/sql.h:819

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLCancel[I16](pStatementHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:823
  Original Name: SQLCloseCursor/usr/include/iodbc/sql.h:823

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLCloseCursor[I16](pStatementHandle: Pointer[None] tag)



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
use @SQLColAttribute[I16](pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pFieldIdentifier: U16, pCharacterAttribute: Pointer[None] tag, pBufferLength: I16, pStringLength: CBoxedI16 tag, pNumericAttribute: CBoxedI64 tag)



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
use @SQLColumns[I16](pStatementHandle: Pointer[None] tag, pCatalogName: Pointer[U8] tag, pNameLength1: I16, pSchemaName: Pointer[U8] tag, pNameLength2: I16, pTableName: Pointer[U8] tag, pNameLength3: I16, pColumnName: Pointer[U8] tag, pNameLength4: I16)



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
use @SQLConnect[I16](pConnectionHandle: Pointer[None] tag, pServerName: Pointer[U8] tag, pNameLength1: I16, pUserName: Pointer[U8] tag, pNameLength2: I16, pAuthentication: Pointer[U8] tag, pNameLength3: I16)



/*
  Source: /usr/include/iodbc/sql.h:862
  Original Name: SQLCopyDesc/usr/include/iodbc/sql.h:862

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLCopyDesc[I16](pSourceDescHandle: Pointer[None] tag, pTargetDescHandle: Pointer[None] tag)



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
use @SQLDataSources[I16](pEnvironmentHandle: Pointer[None] tag, pDirection: U16, pServerName: Pointer[U8] tag, pBufferLength1: I16, pNameLength1: CBoxedI16 tag, pDescription: Pointer[U8] tag, pBufferLength2: I16, pNameLength2: CBoxedI16 tag)



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
use @SQLDescribeCol[I16](pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pColumnName: Pointer[U8] tag, pBufferLength: I16, pNameLength: CBoxedI16 tag, pDataType: CBoxedI16 tag, pColumnSize: CBoxedU64 tag, pDecimalDigits: CBoxedI16 tag, pNullable: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sql.h:888
  Original Name: SQLDisconnect/usr/include/iodbc/sql.h:888

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLDisconnect[I16](pConnectionHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:892
  Original Name: SQLEndTran/usr/include/iodbc/sql.h:892

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLEndTran[I16](pHandleType: I16, pHandle: Pointer[None] tag, pCompletionType: I16)



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
use @SQLError[I16](pEnvironmentHandle: Pointer[None] tag, pConnectionHandle: Pointer[None] tag, pStatementHandle: Pointer[None] tag, pSqlstate: Pointer[U8] tag, pNativeError: CBoxedI32 tag, pMessageText: Pointer[U8] tag, pBufferLength: I16, pTextLength: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sql.h:908
  Original Name: SQLExecDirect/usr/include/iodbc/sql.h:908

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLExecDirect[I16](pStatementHandle: Pointer[None] tag, pStatementText: Pointer[U8] tag, pTextLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:913
  Original Name: SQLExecute/usr/include/iodbc/sql.h:913

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLExecute[I16](pStatementHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:916
  Original Name: SQLFetch/usr/include/iodbc/sql.h:916

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFetch[I16](pStatementHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:920
  Original Name: SQLFetchScroll/usr/include/iodbc/sql.h:920

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(long int) size=64]
*/
use @SQLFetchScroll[I16](pStatementHandle: Pointer[None] tag, pFetchOrientation: I16, pFetchOffset: I64)



/*
  Source: /usr/include/iodbc/sql.h:926
  Original Name: SQLFreeConnect/usr/include/iodbc/sql.h:926

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFreeConnect[I16](pConnectionHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:929
  Original Name: SQLFreeEnv/usr/include/iodbc/sql.h:929

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFreeEnv[I16](pEnvironmentHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:933
  Original Name: SQLFreeHandle/usr/include/iodbc/sql.h:933

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLFreeHandle[I16](pHandleType: I16, pHandle: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:938
  Original Name: SQLFreeStmt/usr/include/iodbc/sql.h:938

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLFreeStmt[I16](pStatementHandle: Pointer[None] tag, pOption: U16)



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
use @SQLGetConnectAttr[I16](pConnectionHandle: Pointer[None] tag, pAttribute: I32, pValue: CBoxedI32 tag, pBufferLength: I32, pStringLength: CBoxedI32 tag)



/*
  Source: /usr/include/iodbc/sql.h:951
  Original Name: SQLGetConnectOption/usr/include/iodbc/sql.h:951

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetConnectOption[I16](pConnectionHandle: Pointer[None] tag, pOption: U16, pValue: Pointer[None] tag)



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
use @SQLGetCursorName[I16](pStatementHandle: Pointer[None] tag, pCursorName: Pointer[U8] tag, pBufferLength: I16, pNameLength: CBoxedI16 tag)



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
use @SQLGetData[I16](pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pTargetType: I16, pTargetValue: Pointer[U8] tag, pBufferLength: I64, pStrLenorInd: CBoxedI64 tag)



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
use @SQLGetDescField[I16](pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32, pStringLength: CBoxedI32 tag)



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
use @SQLGetDescRec[I16](pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pName: Pointer[U8] tag, pBufferLength: I16, pStringLength: CBoxedI16 tag, pType: CBoxedI16 tag, pSubType: CBoxedI16 tag, pLength: CBoxedI64 tag, pPrecision: CBoxedI16 tag, pScale: CBoxedI16 tag, pNullable: CBoxedI16 tag)



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
use @SQLGetDiagField[I16](pHandleType: I16, pHandle: Pointer[None] tag, pRecNumber: I16, pDiagIdentifier: I16, pDiagInfo: Pointer[None] tag, pBufferLength: I16, pStringLength: CBoxedI16 tag)



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
use @SQLGetDiagRec[I16](pHandleType: I16, pHandle: Pointer[None] tag, pRecNumber: I16, pSqlstate: Pointer[U8] tag, pNativeError: CBoxedI32 tag, pMessageText: Pointer[U8] tag, pBufferLength: I16, pTextLength: CBoxedI16 tag)



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
use @SQLGetEnvAttr[I16](pEnvironmentHandle: Pointer[None] tag, pAttribute: I32, pValue: CBoxedI32 tag, pBufferLength: I32, pStringLength: CBoxedI32 tag)



/*
  Source: /usr/include/iodbc/sql.h:1019
  Original Name: SQLGetFunctions/usr/include/iodbc/sql.h:1019

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(short unsigned int) size=16]
*/
use @SQLGetFunctions[I16](pConnectionHandle: Pointer[None] tag, pFunctionId: U16, pSupported: CBoxedU16 tag)



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
use @SQLGetInfo[I16](pConnectionHandle: Pointer[None] tag, pInfoType: U16, pInfoValue: Pointer[None] tag, pBufferLength: I16, pStringLength: CBoxedI16 tag)



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
use @SQLGetStmtAttr[I16](pStatementHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pBufferLength: I32, pStringLength: CBoxedI32 tag)



/*
  Source: /usr/include/iodbc/sql.h:1040
  Original Name: SQLGetStmtOption/usr/include/iodbc/sql.h:1040

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetStmtOption[I16](pStatementHandle: Pointer[None] tag, pOption: U16, pValue: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:1045
  Original Name: SQLGetTypeInfo/usr/include/iodbc/sql.h:1045

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLGetTypeInfo[I16](pStatementHandle: Pointer[None] tag, pDataType: I16)



/*
  Source: /usr/include/iodbc/sql.h:1049
  Original Name: SQLNumResultCols/usr/include/iodbc/sql.h:1049

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLNumResultCols[I16](pStatementHandle: Pointer[None] tag, pColumnCount: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sql.h:1053
  Original Name: SQLParamData/usr/include/iodbc/sql.h:1053

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLParamData[I16](pStatementHandle: Pointer[None] tag, pValue: Pointer[None] tag)



/*
  Source: /usr/include/iodbc/sql.h:1057
  Original Name: SQLPrepare/usr/include/iodbc/sql.h:1057

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLPrepare[I16](pStatementHandle: Pointer[None] tag, pStatementText: Pointer[U8] tag, pTextLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1062
  Original Name: SQLPutData/usr/include/iodbc/sql.h:1062

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long int) size=64]
*/
use @SQLPutData[I16](pStatementHandle: Pointer[None] tag, pData: Pointer[None] tag, pStrLenorInd: I64)



/*
  Source: /usr/include/iodbc/sql.h:1067
  Original Name: SQLRowCount/usr/include/iodbc/sql.h:1067

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
use @SQLRowCount[I16](pStatementHandle: Pointer[None] tag, pRowCount: CBoxedI64 tag)



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
use @SQLSetConnectAttr[I16](pConnectionHandle: Pointer[None] tag, pAttribute: I32, pValue: I32, pStringLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1079
  Original Name: SQLSetConnectOption/usr/include/iodbc/sql.h:1079

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetConnectOption[I16](pConnectionHandle: Pointer[None] tag, pOption: U16, pValue: U64)



/*
  Source: /usr/include/iodbc/sql.h:1084
  Original Name: SQLSetCursorName/usr/include/iodbc/sql.h:1084

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLSetCursorName[I16](pStatementHandle: Pointer[None] tag, pCursorName: Pointer[U8] tag, pNameLength: I16)



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
use @SQLSetDescField[I16](pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32)



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
use @SQLSetDescRec[I16](pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pType: I16, pSubType: I16, pLength: I64, pPrecision: I16, pScale: I16, pData: Pointer[None] tag, pStringLength: CBoxedI64 tag, pIndicator: CBoxedI64 tag)



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
use @SQLSetEnvAttr[I16](pEnvironmentHandle: Pointer[None] tag, pAttribute: I32, pValue: I32, pStringLength: I32)



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
use @SQLSetStmtAttr[I16](pStatementHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pStringLength: I32)



/*
  Source: /usr/include/iodbc/sql.h:1125
  Original Name: SQLSetStmtOption/usr/include/iodbc/sql.h:1125

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetStmtOption[I16](pStatementHandle: Pointer[None] tag, pOption: U16, pValue: U64)



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
use @SQLSpecialColumns[I16](pStatementHandle: Pointer[None] tag, pIdentifierType: U16, pCatalogName: Pointer[U8] tag, pNameLength1: I16, pSchemaName: Pointer[U8] tag, pNameLength2: I16, pTableName: Pointer[U8] tag, pNameLength3: I16, pScope: U16, pNullable: U16)



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
use @SQLStatistics[I16](pStatementHandle: Pointer[None] tag, pCatalogName: Pointer[U8] tag, pNameLength1: I16, pSchemaName: Pointer[U8] tag, pNameLength2: I16, pTableName: Pointer[U8] tag, pNameLength3: I16, pUnique: U16, pReserved: U16)



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
use @SQLTables[I16](pStatementHandle: Pointer[None] tag, pCatalogName: Pointer[U8] tag, pNameLength1: I16, pSchemaName: Pointer[U8] tag, pNameLength2: I16, pTableName: Pointer[U8] tag, pNameLength3: I16, pTableType: Pointer[U8] tag, pNameLength4: I16)



/*
  Source: /usr/include/iodbc/sql.h:1164
  Original Name: SQLTransact/usr/include/iodbc/sql.h:1164

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
*/
use @SQLTransact[I16](pEnvironmentHandle: Pointer[None] tag, pConnectionHandle: Pointer[None] tag, pCompletionType: U16)



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
use @SQLSetParam[I16](pStatementHandle: Pointer[None] tag, pParameterNumber: U16, pValueType: I16, pParameterType: I16, pLengthPrecision: U64, pParameterScale: I16, pParameterValue: Pointer[None] tag, pStrLenorInd: CBoxedI64 tag)



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
use @SQLDriverConnect[I16](phdbc: Pointer[None] tag, phwnd: Pointer[None] tag, pszConnStrIn: Pointer[U8] tag, pcbConnStrIn: I16, pszConnStrOut: Pointer[U8] tag, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16 tag, pfDriverCompletion: U16)



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
use @SQLBrowseConnect[I16](phdbc: Pointer[None] tag, pszConnStrIn: Pointer[U8] tag, pcbConnStrIn: I16, pszConnStrOut: Pointer[U8] tag, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2380
  Original Name: SQLBulkOperations/usr/include/iodbc/sqlext.h:2380

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLBulkOperations[I16](pStatementHandle: Pointer[None] tag, pOperation: I16)



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
use @SQLColAttributes[I16](phstmt: Pointer[None] tag, picol: U16, pfDescType: U16, prgbDesc: Pointer[None] tag, pcbDescMax: I16, ppcbDesc: CBoxedI16 tag, ppfDesc: CBoxedI64 tag)



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
use @SQLColumnPrivileges[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16, pszColumnName: Pointer[U8] tag, pcbColumnName: I16)



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
use @SQLDescribeParam[I16](phstmt: Pointer[None] tag, pipar: U16, ppfSqlType: CBoxedI16 tag, ppcbParamDef: CBoxedU64 tag, ppibScale: CBoxedI16 tag, ppfNullable: CBoxedI16 tag)



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
use @SQLExtendedFetch[I16](phstmt: Pointer[None] tag, pfFetchType: U16, pirow: I64, ppcrow: CBoxedU64 tag, prgfRowStatus: CBoxedU16 tag)



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
use @SQLForeignKeys[I16](phstmt: Pointer[None] tag, pszPkCatalogName: Pointer[U8] tag, pcbPkCatalogName: I16, pszPkSchemaName: Pointer[U8] tag, pcbPkSchemaName: I16, pszPkTableName: Pointer[U8] tag, pcbPkTableName: I16, pszFkCatalogName: Pointer[U8] tag, pcbFkCatalogName: I16, pszFkSchemaName: Pointer[U8] tag, pcbFkSchemaName: I16, pszFkTableName: Pointer[U8] tag, pcbFkTableName: I16)



/*
  Source: /usr/include/iodbc/sqlext.h:2435
  Original Name: SQLMoreResults/usr/include/iodbc/sqlext.h:2435

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLMoreResults[I16](phstmt: Pointer[None] tag)



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
use @SQLNativeSql[I16](phdbc: Pointer[None] tag, pszSqlStrIn: Pointer[U8] tag, pcbSqlStrIn: I32, pszSqlStr: Pointer[U8] tag, pcbSqlStrMax: I32, ppcbSqlStr: CBoxedI32 tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2446
  Original Name: SQLNumParams/usr/include/iodbc/sqlext.h:2446

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
use @SQLNumParams[I16](phstmt: Pointer[None] tag, ppcpar: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlext.h:2450
  Original Name: SQLParamOptions/usr/include/iodbc/sqlext.h:2450

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
*/
use @SQLParamOptions[I16](phstmt: Pointer[None] tag, pcrow: U64, ppirow: CBoxedU64 tag)



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
use @SQLPrimaryKeys[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16)



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
use @SQLProcedureColumns[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszProcName: Pointer[U8] tag, pcbProcName: I16, pszColumnName: Pointer[U8] tag, pcbColumnName: I16)



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
use @SQLProcedures[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszProcName: Pointer[U8] tag, pcbProcName: I16)



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
use @SQLSetPos[I16](phstmt: Pointer[None] tag, pirow: U16, pfOption: U16, pfLock: U16)



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
use @SQLTablePrivileges[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16)



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
use @SQLDrivers[I16](phenv: Pointer[None] tag, pfDirection: U16, pszDriverDesc: Pointer[U8] tag, pcbDriverDescMax: I16, ppcbDriverDesc: CBoxedI16 tag, pszDriverAttributes: Pointer[U8] tag, pcbDrvrAttrMax: I16, ppcbDrvrAttr: CBoxedI16 tag)



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
use @SQLBindParameter[I16](phstmt: Pointer[None] tag, pipar: U16, pfParamType: I16, pfCType: I16, pfSqlType: I16, pcbColDef: U64, pibScale: I16, prgbValue: Pointer[None] tag, pcbValueMax: I64, ppcbValue: CBoxedI64 tag)



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
use @SQLSetScrollOptions[I16](phstmt: Pointer[None] tag, pfConcurrency: U16, pcrowKeyset: I64, pcrowRowset: U16)



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
use @SQLColAttributeW[I16](phstmt: Pointer[None] tag, piCol: U16, piField: U16, ppCharAttr: Pointer[None] tag, pcbCharAttrMax: I16, ppcbCharAttr: CBoxedI16 tag, ppNumAttr: CBoxedI64 tag)



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
use @SQLColAttributesW[I16](phstmt: Pointer[None] tag, picol: U16, pfDescType: U16, prgbDesc: Pointer[None] tag, pcbDescMax: I16, ppcbDesc: CBoxedI16 tag, ppfDesc: CBoxedI64 tag)



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
use @SQLConnectW[I16](phdbc: Pointer[None] tag, pszDSN: CBoxedI32 tag, pcbDSN: I16, pszUID: CBoxedI32 tag, pcbUID: I16, pszAuthStr: CBoxedI32 tag, pcbAuthStr: I16)



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
use @SQLDescribeColW[I16](phstmt: Pointer[None] tag, picol: U16, pszColName: CBoxedI32 tag, pcbColNameMax: I16, ppcbColName: CBoxedI16 tag, ppfSqlType: CBoxedI16 tag, ppcbColDef: CBoxedU64 tag, ppibScale: CBoxedI16 tag, ppfNullable: CBoxedI16 tag)



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
use @SQLErrorW[I16](phenv: Pointer[None] tag, phdbc: Pointer[None] tag, phstmt: Pointer[None] tag, pszSqlState: CBoxedI32 tag, ppfNativeError: CBoxedI32 tag, pszErrorMsg: CBoxedI32 tag, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:169
  Original Name: SQLExecDirectW/usr/include/iodbc/sqlucode.h:169

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
*/
use @SQLExecDirectW[I16](phstmt: Pointer[None] tag, pszSqlStr: CBoxedI32 tag, pcbSqlStr: I32)



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
use @SQLGetConnectAttrW[I16](phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32 tag)



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
use @SQLGetCursorNameW[I16](phstmt: Pointer[None] tag, pszCursor: CBoxedI32 tag, pcbCursorMax: I16, ppcbCursor: CBoxedI16 tag)



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
use @SQLSetDescFieldW[I16](pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32)



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
use @SQLGetDescFieldW[I16](phdesc: Pointer[None] tag, piRecord: I16, piField: I16, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32 tag)



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
use @SQLGetDescRecW[I16](phdesc: Pointer[None] tag, piRecord: I16, pszName: CBoxedI32 tag, pcbNameMax: I16, ppcbName: CBoxedI16 tag, ppfType: CBoxedI16 tag, ppfSubType: CBoxedI16 tag, ppLength: CBoxedI64 tag, ppPrecision: CBoxedI16 tag, ppScale: CBoxedI16 tag, ppNullable: CBoxedI16 tag)



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
use @SQLGetDiagFieldW[I16](pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pfDiagField: I16, prgbDiagInfo: Pointer[None] tag, pcbDiagInfoMax: I16, ppcbDiagInfo: CBoxedI16 tag)



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
use @SQLGetDiagRecW[I16](pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pszSqlState: CBoxedI32 tag, ppfNativeError: CBoxedI32 tag, pszErrorMsg: CBoxedI32 tag, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:236
  Original Name: SQLPrepareW/usr/include/iodbc/sqlucode.h:236

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
*/
use @SQLPrepareW[I16](phstmt: Pointer[None] tag, pszSqlStr: CBoxedI32 tag, pcbSqlStr: I32)



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
use @SQLSetConnectAttrW[I16](phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValue: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:247
  Original Name: SQLSetCursorNameW/usr/include/iodbc/sqlucode.h:247

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
use @SQLSetCursorNameW[I16](phstmt: Pointer[None] tag, pszCursor: CBoxedI32 tag, pcbCursor: I16)



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
use @SQLColumnsW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszTableName: CBoxedI32 tag, pcbTableName: I16, pszColumnName: CBoxedI32 tag, pcbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:263
  Original Name: SQLGetConnectOptionW/usr/include/iodbc/sqlucode.h:263

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetConnectOptionW[I16](phdbc: Pointer[None] tag, pfOption: U16, ppvParam: Pointer[None] tag)



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
use @SQLGetInfoW[I16](phdbc: Pointer[None] tag, pfInfoType: U16, prgbInfoValue: Pointer[None] tag, pcbInfoValueMax: I16, ppcbInfoValue: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:275
  Original Name: SQLGetTypeInfoW/usr/include/iodbc/sqlucode.h:275

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLGetTypeInfoW[I16](pStatementHandle: Pointer[None] tag, pDataType: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:279
  Original Name: SQLSetConnectOptionW/usr/include/iodbc/sqlucode.h:279

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetConnectOptionW[I16](phdbc: Pointer[None] tag, pfOption: U16, pvParam: U64)



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
use @SQLSpecialColumnsW[I16](phstmt: Pointer[None] tag, pfColType: U16, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszTableName: CBoxedI32 tag, pcbTableName: I16, pfScope: U16, pfNullable: U16)



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
use @SQLStatisticsW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszTableName: CBoxedI32 tag, pcbTableName: I16, pfUnique: U16, pfAccuracy: U16)



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
use @SQLTablesW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszTableName: CBoxedI32 tag, pcbTableName: I16, pszTableType: CBoxedI32 tag, pcbTableType: I16)



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
use @SQLDataSourcesW[I16](phenv: Pointer[None] tag, pfDirection: U16, pszDSN: CBoxedI32 tag, pcbDSNMax: I16, ppcbDSN: CBoxedI16 tag, pszDescription: CBoxedI32 tag, pcbDescriptionMax: I16, ppcbDescription: CBoxedI16 tag)



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
use @SQLDriverConnectW[I16](phdbc: Pointer[None] tag, phwnd: Pointer[None] tag, pszConnStrIn: CBoxedI32 tag, pcbConnStrIn: I16, pszConnStrOut: CBoxedI32 tag, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16 tag, pfDriverCompletion: U16)



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
use @SQLBrowseConnectW[I16](phdbc: Pointer[None] tag, pszConnStrIn: CBoxedI32 tag, pcbConnStrIn: I16, pszConnStrOut: CBoxedI32 tag, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16 tag)



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
use @SQLColumnPrivilegesW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszTableName: CBoxedI32 tag, pcbTableName: I16, pszColumnName: CBoxedI32 tag, pcbColumnName: I16)



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
use @SQLGetStmtAttrW[I16](phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32 tag)



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
use @SQLSetStmtAttrW[I16](phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32)



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
use @SQLForeignKeysW[I16](phstmt: Pointer[None] tag, pszPkCatalogName: CBoxedI32 tag, pcbPkCatalogName: I16, pszPkSchemaName: CBoxedI32 tag, pcbPkSchemaName: I16, pszPkTableName: CBoxedI32 tag, pcbPkTableName: I16, pszFkCatalogName: CBoxedI32 tag, pcbFkCatalogName: I16, pszFkSchemaName: CBoxedI32 tag, pcbFkSchemaName: I16, pszFkTableName: CBoxedI32 tag, pcbFkTableName: I16)



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
use @SQLNativeSqlW[I16](phdbc: Pointer[None] tag, pszSqlStrIn: CBoxedI32 tag, pcbSqlStrIn: I32, pszSqlStr: CBoxedI32 tag, pcbSqlStrMax: I32, ppcbSqlStr: CBoxedI32 tag)



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
use @SQLPrimaryKeysW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszTableName: CBoxedI32 tag, pcbTableName: I16)



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
use @SQLProcedureColumnsW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszProcName: CBoxedI32 tag, pcbProcName: I16, pszColumnName: CBoxedI32 tag, pcbColumnName: I16)



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
use @SQLProceduresW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszProcName: CBoxedI32 tag, pcbProcName: I16)



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
use @SQLTablePrivilegesW[I16](phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32 tag, pcbCatalogName: I16, pszSchemaName: CBoxedI32 tag, pcbSchemaName: I16, pszTableName: CBoxedI32 tag, pcbTableName: I16)



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
use @SQLDriversW[I16](phenv: Pointer[None] tag, pfDirection: U16, pszDriverDesc: CBoxedI32 tag, pcbDriverDescMax: I16, ppcbDriverDesc: CBoxedI16 tag, pszDriverAttributes: CBoxedI32 tag, pcbDrvrAttrMax: I16, ppcbDrvrAttr: CBoxedI16 tag)



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
use @SQLColAttributeA[I16](phstmt: Pointer[None] tag, piCol: U16, piField: U16, ppCharAttr: Pointer[None] tag, pcbCharAttrMax: I16, ppcbCharAttr: CBoxedI16 tag, ppNumAttr: CBoxedI64 tag)



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
use @SQLColAttributesA[I16](phstmt: Pointer[None] tag, picol: U16, pfDescType: U16, prgbDesc: Pointer[None] tag, pcbDescMax: I16, ppcbDesc: CBoxedI16 tag, ppfDesc: CBoxedI64 tag)



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
use @SQLConnectA[I16](phdbc: Pointer[None] tag, pszDSN: Pointer[U8] tag, pcbDSN: I16, pszUID: Pointer[U8] tag, pcbUID: I16, pszAuthStr: Pointer[U8] tag, pcbAuthStr: I16)



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
use @SQLDescribeColA[I16](phstmt: Pointer[None] tag, picol: U16, pszColName: Pointer[U8] tag, pcbColNameMax: I16, ppcbColName: CBoxedI16 tag, ppfSqlType: CBoxedI16 tag, ppcbColDef: CBoxedU64 tag, ppibScale: CBoxedI16 tag, ppfNullable: CBoxedI16 tag)



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
use @SQLErrorA[I16](phenv: Pointer[None] tag, phdbc: Pointer[None] tag, phstmt: Pointer[None] tag, pszSqlState: Pointer[U8] tag, ppfNativeError: CBoxedI32 tag, pszErrorMsg: Pointer[U8] tag, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:494
  Original Name: SQLExecDirectA/usr/include/iodbc/sqlucode.h:494

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLExecDirectA[I16](phstmt: Pointer[None] tag, pszSqlStr: Pointer[U8] tag, pcbSqlStr: I32)



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
use @SQLGetConnectAttrA[I16](phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32 tag)



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
use @SQLGetCursorNameA[I16](phstmt: Pointer[None] tag, pszCursor: Pointer[U8] tag, pcbCursorMax: I16, ppcbCursor: CBoxedI16 tag)



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
use @SQLSetDescFieldA[I16](pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32)



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
use @SQLGetDescFieldA[I16](phdesc: Pointer[None] tag, piRecord: I16, piField: I16, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32 tag)



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
use @SQLGetDescRecA[I16](phdesc: Pointer[None] tag, piRecord: I16, pszName: Pointer[U8] tag, pcbNameMax: I16, ppcbName: CBoxedI16 tag, ppfType: CBoxedI16 tag, ppfSubType: CBoxedI16 tag, ppLength: CBoxedI64 tag, ppPrecision: CBoxedI16 tag, ppScale: CBoxedI16 tag, ppNullable: CBoxedI16 tag)



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
use @SQLGetDiagFieldA[I16](pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pfDiagField: I16, prgbDiagInfo: Pointer[None] tag, pcbDiagInfoMax: I16, ppcbDiagInfo: CBoxedI16 tag)



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
use @SQLGetDiagRecA[I16](pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pszSqlState: Pointer[U8] tag, ppfNativeError: CBoxedI32 tag, pszErrorMsg: Pointer[U8] tag, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:561
  Original Name: SQLPrepareA/usr/include/iodbc/sqlucode.h:561

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
use @SQLPrepareA[I16](phstmt: Pointer[None] tag, pszSqlStr: Pointer[U8] tag, pcbSqlStr: I32)



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
use @SQLSetConnectAttrA[I16](phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValue: I32)



/*
  Source: /usr/include/iodbc/sqlucode.h:572
  Original Name: SQLSetCursorNameA/usr/include/iodbc/sqlucode.h:572

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
use @SQLSetCursorNameA[I16](phstmt: Pointer[None] tag, pszCursor: Pointer[U8] tag, pcbCursor: I16)



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
use @SQLColumnsA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16, pszColumnName: Pointer[U8] tag, pcbColumnName: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:588
  Original Name: SQLGetConnectOptionA/usr/include/iodbc/sqlucode.h:588

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
use @SQLGetConnectOptionA[I16](phdbc: Pointer[None] tag, pfOption: U16, ppvParam: Pointer[None] tag)



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
use @SQLGetInfoA[I16](phdbc: Pointer[None] tag, pfInfoType: U16, prgbInfoValue: Pointer[None] tag, pcbInfoValueMax: I16, ppcbInfoValue: CBoxedI16 tag)



/*
  Source: /usr/include/iodbc/sqlucode.h:600
  Original Name: SQLGetTypeInfoA/usr/include/iodbc/sqlucode.h:600

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
use @SQLGetTypeInfoA[I16](pStatementHandle: Pointer[None] tag, pDataType: I16)



/*
  Source: /usr/include/iodbc/sqlucode.h:604
  Original Name: SQLSetConnectOptionA/usr/include/iodbc/sqlucode.h:604

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
use @SQLSetConnectOptionA[I16](phdbc: Pointer[None] tag, pfOption: U16, pvParam: U64)



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
use @SQLSpecialColumnsA[I16](phstmt: Pointer[None] tag, pfColType: U16, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16, pfScope: U16, pfNullable: U16)



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
use @SQLStatisticsA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16, pfUnique: U16, pfAccuracy: U16)



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
use @SQLTablesA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16, pszTableType: Pointer[U8] tag, pcbTableType: I16)



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
use @SQLDataSourcesA[I16](phenv: Pointer[None] tag, pfDirection: U16, pszDSN: Pointer[U8] tag, pcbDSNMax: I16, ppcbDSN: CBoxedI16 tag, pszDescription: Pointer[U8] tag, pcbDescriptionMax: I16, ppcbDescription: CBoxedI16 tag)



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
use @SQLDriverConnectA[I16](phdbc: Pointer[None] tag, phwnd: Pointer[None] tag, pszConnStrIn: Pointer[U8] tag, pcbConnStrIn: I16, pszConnStrOut: Pointer[U8] tag, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16 tag, pfDriverCompletion: U16)



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
use @SQLBrowseConnectA[I16](phdbc: Pointer[None] tag, pszConnStrIn: Pointer[U8] tag, pcbConnStrIn: I16, pszConnStrOut: Pointer[U8] tag, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16 tag)



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
use @SQLColumnPrivilegesA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16, pszColumnName: Pointer[U8] tag, pcbColumnName: I16)



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
use @SQLGetStmtAttrA[I16](phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32 tag)



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
use @SQLSetStmtAttrA[I16](phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32)



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
use @SQLForeignKeysA[I16](phstmt: Pointer[None] tag, pszPkCatalogName: Pointer[U8] tag, pcbPkCatalogName: I16, pszPkSchemaName: Pointer[U8] tag, pcbPkSchemaName: I16, pszPkTableName: Pointer[U8] tag, pcbPkTableName: I16, pszFkCatalogName: Pointer[U8] tag, pcbFkCatalogName: I16, pszFkSchemaName: Pointer[U8] tag, pcbFkSchemaName: I16, pszFkTableName: Pointer[U8] tag, pcbFkTableName: I16)



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
use @SQLNativeSqlA[I16](phdbc: Pointer[None] tag, pszSqlStrIn: Pointer[U8] tag, pcbSqlStrIn: I32, pszSqlStr: Pointer[U8] tag, pcbSqlStrMax: I32, ppcbSqlStr: CBoxedI32 tag)



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
use @SQLPrimaryKeysA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16)



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
use @SQLProcedureColumnsA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszProcName: Pointer[U8] tag, pcbProcName: I16, pszColumnName: Pointer[U8] tag, pcbColumnName: I16)



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
use @SQLProceduresA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszProcName: Pointer[U8] tag, pcbProcName: I16)



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
use @SQLTablePrivilegesA[I16](phstmt: Pointer[None] tag, pszCatalogName: Pointer[U8] tag, pcbCatalogName: I16, pszSchemaName: Pointer[U8] tag, pcbSchemaName: I16, pszTableName: Pointer[U8] tag, pcbTableName: I16)



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
use @SQLDriversA[I16](phenv: Pointer[None] tag, pfDirection: U16, pszDriverDesc: Pointer[U8] tag, pcbDriverDescMax: I16, ppcbDriverDesc: CBoxedI16 tag, pszDriverAttributes: Pointer[U8] tag, pcbDrvrAttrMax: I16, ppcbDrvrAttr: CBoxedI16 tag)

