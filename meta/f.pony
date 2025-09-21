primitive T

/*
  Source: /usr/include/iodbc/sql.h:781
  Original Name: SQLAllocConnect/usr/include/iodbc/sql.h:781

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLAllocConnect(pEnvironmentHandle: Pointer[None] tag, pConnectionHandle: Pointer[None] tag): I16 =>
    @SQLAllocConnect(pEnvironmentHandle, pConnectionHandle)


/*
  Source: /usr/include/iodbc/sql.h:785
  Original Name: SQLAllocEnv/usr/include/iodbc/sql.h:785

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLAllocEnv(pEnvironmentHandle: Pointer[None] tag): I16 =>
    @SQLAllocEnv(pEnvironmentHandle)


/*
  Source: /usr/include/iodbc/sql.h:789
  Original Name: SQLAllocHandle/usr/include/iodbc/sql.h:789

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLAllocHandle(pHandleType: I16, pInputHandle: Pointer[None] tag, pOutputHandle: Pointer[None] tag): I16 =>
    @SQLAllocHandle(pHandleType, pInputHandle, pOutputHandle)


/*
  Source: /usr/include/iodbc/sql.h:795
  Original Name: SQLAllocStmt/usr/include/iodbc/sql.h:795

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLAllocStmt(pConnectionHandle: Pointer[None] tag, pStatementHandle: Pointer[None] tag): I16 =>
    @SQLAllocStmt(pConnectionHandle, pStatementHandle)


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
  fun sQLBindCol(pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pTargetType: I16, pTargetValue: Pointer[None] tag, pBufferLength: I64, pStrLenorInd: CBoxedI64): I16 =>
    @SQLBindCol(pStatementHandle, pColumnNumber, pTargetType, pTargetValue, pBufferLength, pStrLenorInd)


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
  fun sQLBindParam(pStatementHandle: Pointer[None] tag, pParameterNumber: U16, pValueType: I16, pParameterType: I16, pLengthPrecision: U64, pParameterScale: I16, pParameterValue: Pointer[None] tag, pStrLenorInd: CBoxedI64): I16 =>
    @SQLBindParam(pStatementHandle, pParameterNumber, pValueType, pParameterType, pLengthPrecision, pParameterScale, pParameterValue, pStrLenorInd)


/*
  Source: /usr/include/iodbc/sql.h:819
  Original Name: SQLCancel/usr/include/iodbc/sql.h:819

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLCancel(pStatementHandle: Pointer[None] tag): I16 =>
    @SQLCancel(pStatementHandle)


/*
  Source: /usr/include/iodbc/sql.h:823
  Original Name: SQLCloseCursor/usr/include/iodbc/sql.h:823

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLCloseCursor(pStatementHandle: Pointer[None] tag): I16 =>
    @SQLCloseCursor(pStatementHandle)


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
  fun sQLColAttribute(pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pFieldIdentifier: U16, pCharacterAttribute: Pointer[None] tag, pBufferLength: I16, pStringLength: CBoxedI16, pNumericAttribute: CBoxedI64): I16 =>
    @SQLColAttribute(pStatementHandle, pColumnNumber, pFieldIdentifier, pCharacterAttribute, pBufferLength, pStringLength, pNumericAttribute)


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
  fun sQLColumns(pStatementHandle: Pointer[None] tag, pCatalogName: String, pNameLength1: I16, pSchemaName: String, pNameLength2: I16, pTableName: String, pNameLength3: I16, pColumnName: String, pNameLength4: I16): I16 =>
    @SQLColumns(pStatementHandle, pCatalogName.cstring(), pNameLength1, pSchemaName.cstring(), pNameLength2, pTableName.cstring(), pNameLength3, pColumnName.cstring(), pNameLength4)


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
  fun sQLConnect(pConnectionHandle: Pointer[None] tag, pServerName: String, pNameLength1: I16, pUserName: String, pNameLength2: I16, pAuthentication: String, pNameLength3: I16): I16 =>
    @SQLConnect(pConnectionHandle, pServerName.cstring(), pNameLength1, pUserName.cstring(), pNameLength2, pAuthentication.cstring(), pNameLength3)


/*
  Source: /usr/include/iodbc/sql.h:862
  Original Name: SQLCopyDesc/usr/include/iodbc/sql.h:862

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLCopyDesc(pSourceDescHandle: Pointer[None] tag, pTargetDescHandle: Pointer[None] tag): I16 =>
    @SQLCopyDesc(pSourceDescHandle, pTargetDescHandle)


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
  fun sQLDataSources(pEnvironmentHandle: Pointer[None] tag, pDirection: U16, pServerName: String, pBufferLength1: I16, pNameLength1: CBoxedI16, pDescription: String, pBufferLength2: I16, pNameLength2: CBoxedI16): I16 =>
    @SQLDataSources(pEnvironmentHandle, pDirection, pServerName.cstring(), pBufferLength1, pNameLength1, pDescription.cstring(), pBufferLength2, pNameLength2)


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
  fun sQLDescribeCol(pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pColumnName: String, pBufferLength: I16, pNameLength: CBoxedI16, pDataType: CBoxedI16, pColumnSize: CBoxedU64, pDecimalDigits: CBoxedI16, pNullable: CBoxedI16): I16 =>
    @SQLDescribeCol(pStatementHandle, pColumnNumber, pColumnName.cstring(), pBufferLength, pNameLength, pDataType, pColumnSize, pDecimalDigits, pNullable)


/*
  Source: /usr/include/iodbc/sql.h:888
  Original Name: SQLDisconnect/usr/include/iodbc/sql.h:888

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLDisconnect(pConnectionHandle: Pointer[None] tag): I16 =>
    @SQLDisconnect(pConnectionHandle)


/*
  Source: /usr/include/iodbc/sql.h:892
  Original Name: SQLEndTran/usr/include/iodbc/sql.h:892

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
  fun sQLEndTran(pHandleType: I16, pHandle: Pointer[None] tag, pCompletionType: I16): I16 =>
    @SQLEndTran(pHandleType, pHandle, pCompletionType)


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
  fun sQLError(pEnvironmentHandle: Pointer[None] tag, pConnectionHandle: Pointer[None] tag, pStatementHandle: Pointer[None] tag, pSqlstate: String, pNativeError: CBoxedI32, pMessageText: String, pBufferLength: I16, pTextLength: CBoxedI16): I16 =>
    @SQLError(pEnvironmentHandle, pConnectionHandle, pStatementHandle, pSqlstate.cstring(), pNativeError, pMessageText.cstring(), pBufferLength, pTextLength)


/*
  Source: /usr/include/iodbc/sql.h:908
  Original Name: SQLExecDirect/usr/include/iodbc/sql.h:908

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
  fun sQLExecDirect(pStatementHandle: Pointer[None] tag, pStatementText: String, pTextLength: I32): I16 =>
    @SQLExecDirect(pStatementHandle, pStatementText.cstring(), pTextLength)


/*
  Source: /usr/include/iodbc/sql.h:913
  Original Name: SQLExecute/usr/include/iodbc/sql.h:913

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLExecute(pStatementHandle: Pointer[None] tag): I16 =>
    @SQLExecute(pStatementHandle)


/*
  Source: /usr/include/iodbc/sql.h:916
  Original Name: SQLFetch/usr/include/iodbc/sql.h:916

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLFetch(pStatementHandle: Pointer[None] tag): I16 =>
    @SQLFetch(pStatementHandle)


/*
  Source: /usr/include/iodbc/sql.h:920
  Original Name: SQLFetchScroll/usr/include/iodbc/sql.h:920

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
    [FundamentalType(long int) size=64]
*/
  fun sQLFetchScroll(pStatementHandle: Pointer[None] tag, pFetchOrientation: I16, pFetchOffset: I64): I16 =>
    @SQLFetchScroll(pStatementHandle, pFetchOrientation, pFetchOffset)


/*
  Source: /usr/include/iodbc/sql.h:926
  Original Name: SQLFreeConnect/usr/include/iodbc/sql.h:926

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLFreeConnect(pConnectionHandle: Pointer[None] tag): I16 =>
    @SQLFreeConnect(pConnectionHandle)


/*
  Source: /usr/include/iodbc/sql.h:929
  Original Name: SQLFreeEnv/usr/include/iodbc/sql.h:929

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLFreeEnv(pEnvironmentHandle: Pointer[None] tag): I16 =>
    @SQLFreeEnv(pEnvironmentHandle)


/*
  Source: /usr/include/iodbc/sql.h:933
  Original Name: SQLFreeHandle/usr/include/iodbc/sql.h:933

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [FundamentalType(short int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLFreeHandle(pHandleType: I16, pHandle: Pointer[None] tag): I16 =>
    @SQLFreeHandle(pHandleType, pHandle)


/*
  Source: /usr/include/iodbc/sql.h:938
  Original Name: SQLFreeStmt/usr/include/iodbc/sql.h:938

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
*/
  fun sQLFreeStmt(pStatementHandle: Pointer[None] tag, pOption: U16): I16 =>
    @SQLFreeStmt(pStatementHandle, pOption)


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
  fun sQLGetConnectAttr(pConnectionHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pBufferLength: I32, pStringLength: CBoxedI32): I16 =>
    @SQLGetConnectAttr(pConnectionHandle, pAttribute, pValue, pBufferLength, pStringLength)


/*
  Source: /usr/include/iodbc/sql.h:951
  Original Name: SQLGetConnectOption/usr/include/iodbc/sql.h:951

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLGetConnectOption(pConnectionHandle: Pointer[None] tag, pOption: U16, pValue: Pointer[None] tag): I16 =>
    @SQLGetConnectOption(pConnectionHandle, pOption, pValue)


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
  fun sQLGetCursorName(pStatementHandle: Pointer[None] tag, pCursorName: String, pBufferLength: I16, pNameLength: CBoxedI16): I16 =>
    @SQLGetCursorName(pStatementHandle, pCursorName.cstring(), pBufferLength, pNameLength)


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
  fun sQLGetData(pStatementHandle: Pointer[None] tag, pColumnNumber: U16, pTargetType: I16, pTargetValue: Pointer[None] tag, pBufferLength: I64, pStrLenorInd: CBoxedI64): I16 =>
    @SQLGetData(pStatementHandle, pColumnNumber, pTargetType, pTargetValue, pBufferLength, pStrLenorInd)


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
  fun sQLGetDescField(pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32, pStringLength: CBoxedI32): I16 =>
    @SQLGetDescField(pDescriptorHandle, pRecNumber, pFieldIdentifier, pValue, pBufferLength, pStringLength)


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
  fun sQLGetDescRec(pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pName: String, pBufferLength: I16, pStringLength: CBoxedI16, pType: CBoxedI16, pSubType: CBoxedI16, pLength: CBoxedI64, pPrecision: CBoxedI16, pScale: CBoxedI16, pNullable: CBoxedI16): I16 =>
    @SQLGetDescRec(pDescriptorHandle, pRecNumber, pName.cstring(), pBufferLength, pStringLength, pType, pSubType, pLength, pPrecision, pScale, pNullable)


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
  fun sQLGetDiagField(pHandleType: I16, pHandle: Pointer[None] tag, pRecNumber: I16, pDiagIdentifier: I16, pDiagInfo: Pointer[None] tag, pBufferLength: I16, pStringLength: CBoxedI16): I16 =>
    @SQLGetDiagField(pHandleType, pHandle, pRecNumber, pDiagIdentifier, pDiagInfo, pBufferLength, pStringLength)


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
  fun sQLGetDiagRec(pHandleType: I16, pHandle: Pointer[None] tag, pRecNumber: I16, pSqlstate: String, pNativeError: CBoxedI32, pMessageText: String, pBufferLength: I16, pTextLength: CBoxedI16): I16 =>
    @SQLGetDiagRec(pHandleType, pHandle, pRecNumber, pSqlstate.cstring(), pNativeError, pMessageText.cstring(), pBufferLength, pTextLength)


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
  fun sQLGetEnvAttr(pEnvironmentHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pBufferLength: I32, pStringLength: CBoxedI32): I16 =>
    @SQLGetEnvAttr(pEnvironmentHandle, pAttribute, pValue, pBufferLength, pStringLength)


/*
  Source: /usr/include/iodbc/sql.h:1019
  Original Name: SQLGetFunctions/usr/include/iodbc/sql.h:1019

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(short unsigned int) size=16]
*/
  fun sQLGetFunctions(pConnectionHandle: Pointer[None] tag, pFunctionId: U16, pSupported: CBoxedU16): I16 =>
    @SQLGetFunctions(pConnectionHandle, pFunctionId, pSupported)


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
  fun sQLGetInfo(pConnectionHandle: Pointer[None] tag, pInfoType: U16, pInfoValue: Pointer[None] tag, pBufferLength: I16, pStringLength: CBoxedI16): I16 =>
    @SQLGetInfo(pConnectionHandle, pInfoType, pInfoValue, pBufferLength, pStringLength)


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
  fun sQLGetStmtAttr(pStatementHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pBufferLength: I32, pStringLength: CBoxedI32): I16 =>
    @SQLGetStmtAttr(pStatementHandle, pAttribute, pValue, pBufferLength, pStringLength)


/*
  Source: /usr/include/iodbc/sql.h:1040
  Original Name: SQLGetStmtOption/usr/include/iodbc/sql.h:1040

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLGetStmtOption(pStatementHandle: Pointer[None] tag, pOption: U16, pValue: Pointer[None] tag): I16 =>
    @SQLGetStmtOption(pStatementHandle, pOption, pValue)


/*
  Source: /usr/include/iodbc/sql.h:1045
  Original Name: SQLGetTypeInfo/usr/include/iodbc/sql.h:1045

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
  fun sQLGetTypeInfo(pStatementHandle: Pointer[None] tag, pDataType: I16): I16 =>
    @SQLGetTypeInfo(pStatementHandle, pDataType)


/*
  Source: /usr/include/iodbc/sql.h:1049
  Original Name: SQLNumResultCols/usr/include/iodbc/sql.h:1049

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
  fun sQLNumResultCols(pStatementHandle: Pointer[None] tag, pColumnCount: CBoxedI16): I16 =>
    @SQLNumResultCols(pStatementHandle, pColumnCount)


/*
  Source: /usr/include/iodbc/sql.h:1053
  Original Name: SQLParamData/usr/include/iodbc/sql.h:1053

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLParamData(pStatementHandle: Pointer[None] tag, pValue: Pointer[None] tag): I16 =>
    @SQLParamData(pStatementHandle, pValue)


/*
  Source: /usr/include/iodbc/sql.h:1057
  Original Name: SQLPrepare/usr/include/iodbc/sql.h:1057

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
  fun sQLPrepare(pStatementHandle: Pointer[None] tag, pStatementText: String, pTextLength: I32): I16 =>
    @SQLPrepare(pStatementHandle, pStatementText.cstring(), pTextLength)


/*
  Source: /usr/include/iodbc/sql.h:1062
  Original Name: SQLPutData/usr/include/iodbc/sql.h:1062

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long int) size=64]
*/
  fun sQLPutData(pStatementHandle: Pointer[None] tag, pData: Pointer[None] tag, pStrLenorInd: I64): I16 =>
    @SQLPutData(pStatementHandle, pData, pStrLenorInd)


/*
  Source: /usr/include/iodbc/sql.h:1067
  Original Name: SQLRowCount/usr/include/iodbc/sql.h:1067

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(long int) size=64]
*/
  fun sQLRowCount(pStatementHandle: Pointer[None] tag, pRowCount: CBoxedI64): I16 =>
    @SQLRowCount(pStatementHandle, pRowCount)


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
  fun sQLSetConnectAttr(pConnectionHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pStringLength: I32): I16 =>
    @SQLSetConnectAttr(pConnectionHandle, pAttribute, pValue, pStringLength)


/*
  Source: /usr/include/iodbc/sql.h:1079
  Original Name: SQLSetConnectOption/usr/include/iodbc/sql.h:1079

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
  fun sQLSetConnectOption(pConnectionHandle: Pointer[None] tag, pOption: U16, pValue: U64): I16 =>
    @SQLSetConnectOption(pConnectionHandle, pOption, pValue)


/*
  Source: /usr/include/iodbc/sql.h:1084
  Original Name: SQLSetCursorName/usr/include/iodbc/sql.h:1084

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
  fun sQLSetCursorName(pStatementHandle: Pointer[None] tag, pCursorName: String, pNameLength: I16): I16 =>
    @SQLSetCursorName(pStatementHandle, pCursorName.cstring(), pNameLength)


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
  fun sQLSetDescField(pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32): I16 =>
    @SQLSetDescField(pDescriptorHandle, pRecNumber, pFieldIdentifier, pValue, pBufferLength)


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
  fun sQLSetDescRec(pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pType: I16, pSubType: I16, pLength: I64, pPrecision: I16, pScale: I16, pData: Pointer[None] tag, pStringLength: CBoxedI64, pIndicator: CBoxedI64): I16 =>
    @SQLSetDescRec(pDescriptorHandle, pRecNumber, pType, pSubType, pLength, pPrecision, pScale, pData, pStringLength, pIndicator)


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
  fun sQLSetEnvAttr(pEnvironmentHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pStringLength: I32): I16 =>
    @SQLSetEnvAttr(pEnvironmentHandle, pAttribute, pValue, pStringLength)


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
  fun sQLSetStmtAttr(pStatementHandle: Pointer[None] tag, pAttribute: I32, pValue: Pointer[None] tag, pStringLength: I32): I16 =>
    @SQLSetStmtAttr(pStatementHandle, pAttribute, pValue, pStringLength)


/*
  Source: /usr/include/iodbc/sql.h:1125
  Original Name: SQLSetStmtOption/usr/include/iodbc/sql.h:1125

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
  fun sQLSetStmtOption(pStatementHandle: Pointer[None] tag, pOption: U16, pValue: U64): I16 =>
    @SQLSetStmtOption(pStatementHandle, pOption, pValue)


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
  fun sQLSpecialColumns(pStatementHandle: Pointer[None] tag, pIdentifierType: U16, pCatalogName: String, pNameLength1: I16, pSchemaName: String, pNameLength2: I16, pTableName: String, pNameLength3: I16, pScope: U16, pNullable: U16): I16 =>
    @SQLSpecialColumns(pStatementHandle, pIdentifierType, pCatalogName.cstring(), pNameLength1, pSchemaName.cstring(), pNameLength2, pTableName.cstring(), pNameLength3, pScope, pNullable)


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
  fun sQLStatistics(pStatementHandle: Pointer[None] tag, pCatalogName: String, pNameLength1: I16, pSchemaName: String, pNameLength2: I16, pTableName: String, pNameLength3: I16, pUnique: U16, pReserved: U16): I16 =>
    @SQLStatistics(pStatementHandle, pCatalogName.cstring(), pNameLength1, pSchemaName.cstring(), pNameLength2, pTableName.cstring(), pNameLength3, pUnique, pReserved)


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
  fun sQLTables(pStatementHandle: Pointer[None] tag, pCatalogName: String, pNameLength1: I16, pSchemaName: String, pNameLength2: I16, pTableName: String, pNameLength3: I16, pTableType: String, pNameLength4: I16): I16 =>
    @SQLTables(pStatementHandle, pCatalogName.cstring(), pNameLength1, pSchemaName.cstring(), pNameLength2, pTableName.cstring(), pNameLength3, pTableType.cstring(), pNameLength4)


/*
  Source: /usr/include/iodbc/sql.h:1164
  Original Name: SQLTransact/usr/include/iodbc/sql.h:1164

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
*/
  fun sQLTransact(pEnvironmentHandle: Pointer[None] tag, pConnectionHandle: Pointer[None] tag, pCompletionType: U16): I16 =>
    @SQLTransact(pEnvironmentHandle, pConnectionHandle, pCompletionType)


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
  fun sQLSetParam(pStatementHandle: Pointer[None] tag, pParameterNumber: U16, pValueType: I16, pParameterType: I16, pLengthPrecision: U64, pParameterScale: I16, pParameterValue: Pointer[None] tag, pStrLenorInd: CBoxedI64): I16 =>
    @SQLSetParam(pStatementHandle, pParameterNumber, pValueType, pParameterType, pLengthPrecision, pParameterScale, pParameterValue, pStrLenorInd)


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
  fun sQLDriverConnect(phdbc: Pointer[None] tag, phwnd: Pointer[None] tag, pszConnStrIn: String, pcbConnStrIn: I16, pszConnStrOut: String, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16, pfDriverCompletion: U16): I16 =>
    @SQLDriverConnect(phdbc, phwnd, pszConnStrIn.cstring(), pcbConnStrIn, pszConnStrOut.cstring(), pcbConnStrOutMax, ppcbConnStrOut, pfDriverCompletion)


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
  fun sQLBrowseConnect(phdbc: Pointer[None] tag, pszConnStrIn: String, pcbConnStrIn: I16, pszConnStrOut: String, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16): I16 =>
    @SQLBrowseConnect(phdbc, pszConnStrIn.cstring(), pcbConnStrIn, pszConnStrOut.cstring(), pcbConnStrOutMax, ppcbConnStrOut)


/*
  Source: /usr/include/iodbc/sqlext.h:2380
  Original Name: SQLBulkOperations/usr/include/iodbc/sqlext.h:2380

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
  fun sQLBulkOperations(pStatementHandle: Pointer[None] tag, pOperation: I16): I16 =>
    @SQLBulkOperations(pStatementHandle, pOperation)


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
  fun sQLColAttributes(phstmt: Pointer[None] tag, picol: U16, pfDescType: U16, prgbDesc: Pointer[None] tag, pcbDescMax: I16, ppcbDesc: CBoxedI16, ppfDesc: CBoxedI64): I16 =>
    @SQLColAttributes(phstmt, picol, pfDescType, prgbDesc, pcbDescMax, ppcbDesc, ppfDesc)


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
  fun sQLColumnPrivileges(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16, pszColumnName: String, pcbColumnName: I16): I16 =>
    @SQLColumnPrivileges(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName, pszColumnName.cstring(), pcbColumnName)


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
  fun sQLDescribeParam(phstmt: Pointer[None] tag, pipar: U16, ppfSqlType: CBoxedI16, ppcbParamDef: CBoxedU64, ppibScale: CBoxedI16, ppfNullable: CBoxedI16): I16 =>
    @SQLDescribeParam(phstmt, pipar, ppfSqlType, ppcbParamDef, ppibScale, ppfNullable)


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
  fun sQLExtendedFetch(phstmt: Pointer[None] tag, pfFetchType: U16, pirow: I64, ppcrow: CBoxedU64, prgfRowStatus: CBoxedU16): I16 =>
    @SQLExtendedFetch(phstmt, pfFetchType, pirow, ppcrow, prgfRowStatus)


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
  fun sQLForeignKeys(phstmt: Pointer[None] tag, pszPkCatalogName: String, pcbPkCatalogName: I16, pszPkSchemaName: String, pcbPkSchemaName: I16, pszPkTableName: String, pcbPkTableName: I16, pszFkCatalogName: String, pcbFkCatalogName: I16, pszFkSchemaName: String, pcbFkSchemaName: I16, pszFkTableName: String, pcbFkTableName: I16): I16 =>
    @SQLForeignKeys(phstmt, pszPkCatalogName.cstring(), pcbPkCatalogName, pszPkSchemaName.cstring(), pcbPkSchemaName, pszPkTableName.cstring(), pcbPkTableName, pszFkCatalogName.cstring(), pcbFkCatalogName, pszFkSchemaName.cstring(), pcbFkSchemaName, pszFkTableName.cstring(), pcbFkTableName)


/*
  Source: /usr/include/iodbc/sqlext.h:2435
  Original Name: SQLMoreResults/usr/include/iodbc/sqlext.h:2435

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLMoreResults(phstmt: Pointer[None] tag): I16 =>
    @SQLMoreResults(phstmt)


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
  fun sQLNativeSql(phdbc: Pointer[None] tag, pszSqlStrIn: String, pcbSqlStrIn: I32, pszSqlStr: String, pcbSqlStrMax: I32, ppcbSqlStr: CBoxedI32): I16 =>
    @SQLNativeSql(phdbc, pszSqlStrIn.cstring(), pcbSqlStrIn, pszSqlStr.cstring(), pcbSqlStrMax, ppcbSqlStr)


/*
  Source: /usr/include/iodbc/sqlext.h:2446
  Original Name: SQLNumParams/usr/include/iodbc/sqlext.h:2446

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(short int) size=16]
*/
  fun sQLNumParams(phstmt: Pointer[None] tag, ppcpar: CBoxedI16): I16 =>
    @SQLNumParams(phstmt, ppcpar)


/*
  Source: /usr/include/iodbc/sqlext.h:2450
  Original Name: SQLParamOptions/usr/include/iodbc/sqlext.h:2450

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(long unsigned int) size=64]
    [PointerType size=64]->[FundamentalType(long unsigned int) size=64]
*/
  fun sQLParamOptions(phstmt: Pointer[None] tag, pcrow: U64, ppirow: CBoxedU64): I16 =>
    @SQLParamOptions(phstmt, pcrow, ppirow)


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
  fun sQLPrimaryKeys(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16): I16 =>
    @SQLPrimaryKeys(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName)


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
  fun sQLProcedureColumns(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszProcName: String, pcbProcName: I16, pszColumnName: String, pcbColumnName: I16): I16 =>
    @SQLProcedureColumns(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszProcName.cstring(), pcbProcName, pszColumnName.cstring(), pcbColumnName)


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
  fun sQLProcedures(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszProcName: String, pcbProcName: I16): I16 =>
    @SQLProcedures(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszProcName.cstring(), pcbProcName)


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
  fun sQLSetPos(phstmt: Pointer[None] tag, pirow: U16, pfOption: U16, pfLock: U16): I16 =>
    @SQLSetPos(phstmt, pirow, pfOption, pfLock)


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
  fun sQLTablePrivileges(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16): I16 =>
    @SQLTablePrivileges(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName)


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
  fun sQLDrivers(phenv: Pointer[None] tag, pfDirection: U16, pszDriverDesc: String, pcbDriverDescMax: I16, ppcbDriverDesc: CBoxedI16, pszDriverAttributes: String, pcbDrvrAttrMax: I16, ppcbDrvrAttr: CBoxedI16): I16 =>
    @SQLDrivers(phenv, pfDirection, pszDriverDesc.cstring(), pcbDriverDescMax, ppcbDriverDesc, pszDriverAttributes.cstring(), pcbDrvrAttrMax, ppcbDrvrAttr)


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
  fun sQLBindParameter(phstmt: Pointer[None] tag, pipar: U16, pfParamType: I16, pfCType: I16, pfSqlType: I16, pcbColDef: U64, pibScale: I16, prgbValue: Pointer[None] tag, pcbValueMax: I64, ppcbValue: CBoxedI64): I16 =>
    @SQLBindParameter(phstmt, pipar, pfParamType, pfCType, pfSqlType, pcbColDef, pibScale, prgbValue, pcbValueMax, ppcbValue)


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
  fun sQLSetScrollOptions(phstmt: Pointer[None] tag, pfConcurrency: U16, pcrowKeyset: I64, pcrowRowset: U16): I16 =>
    @SQLSetScrollOptions(phstmt, pfConcurrency, pcrowKeyset, pcrowRowset)


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
  fun sQLColAttributeW(phstmt: Pointer[None] tag, piCol: U16, piField: U16, ppCharAttr: Pointer[None] tag, pcbCharAttrMax: I16, ppcbCharAttr: CBoxedI16, ppNumAttr: CBoxedI64): I16 =>
    @SQLColAttributeW(phstmt, piCol, piField, ppCharAttr, pcbCharAttrMax, ppcbCharAttr, ppNumAttr)


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
  fun sQLColAttributesW(phstmt: Pointer[None] tag, picol: U16, pfDescType: U16, prgbDesc: Pointer[None] tag, pcbDescMax: I16, ppcbDesc: CBoxedI16, ppfDesc: CBoxedI64): I16 =>
    @SQLColAttributesW(phstmt, picol, pfDescType, prgbDesc, pcbDescMax, ppcbDesc, ppfDesc)


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
  fun sQLConnectW(phdbc: Pointer[None] tag, pszDSN: CBoxedI32, pcbDSN: I16, pszUID: CBoxedI32, pcbUID: I16, pszAuthStr: CBoxedI32, pcbAuthStr: I16): I16 =>
    @SQLConnectW(phdbc, pszDSN, pcbDSN, pszUID, pcbUID, pszAuthStr, pcbAuthStr)


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
  fun sQLDescribeColW(phstmt: Pointer[None] tag, picol: U16, pszColName: CBoxedI32, pcbColNameMax: I16, ppcbColName: CBoxedI16, ppfSqlType: CBoxedI16, ppcbColDef: CBoxedU64, ppibScale: CBoxedI16, ppfNullable: CBoxedI16): I16 =>
    @SQLDescribeColW(phstmt, picol, pszColName, pcbColNameMax, ppcbColName, ppfSqlType, ppcbColDef, ppibScale, ppfNullable)


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
  fun sQLErrorW(phenv: Pointer[None] tag, phdbc: Pointer[None] tag, phstmt: Pointer[None] tag, pszSqlState: CBoxedI32, ppfNativeError: CBoxedI32, pszErrorMsg: CBoxedI32, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16): I16 =>
    @SQLErrorW(phenv, phdbc, phstmt, pszSqlState, ppfNativeError, pszErrorMsg, pcbErrorMsgMax, ppcbErrorMsg)


/*
  Source: /usr/include/iodbc/sqlucode.h:169
  Original Name: SQLExecDirectW/usr/include/iodbc/sqlucode.h:169

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
*/
  fun sQLExecDirectW(phstmt: Pointer[None] tag, pszSqlStr: CBoxedI32, pcbSqlStr: I32): I16 =>
    @SQLExecDirectW(phstmt, pszSqlStr, pcbSqlStr)


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
  fun sQLGetConnectAttrW(phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32): I16 =>
    @SQLGetConnectAttrW(phdbc, pfAttribute, prgbValue, pcbValueMax, ppcbValue)


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
  fun sQLGetCursorNameW(phstmt: Pointer[None] tag, pszCursor: CBoxedI32, pcbCursorMax: I16, ppcbCursor: CBoxedI16): I16 =>
    @SQLGetCursorNameW(phstmt, pszCursor, pcbCursorMax, ppcbCursor)


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
  fun sQLSetDescFieldW(pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32): I16 =>
    @SQLSetDescFieldW(pDescriptorHandle, pRecNumber, pFieldIdentifier, pValue, pBufferLength)


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
  fun sQLGetDescFieldW(phdesc: Pointer[None] tag, piRecord: I16, piField: I16, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32): I16 =>
    @SQLGetDescFieldW(phdesc, piRecord, piField, prgbValue, pcbValueMax, ppcbValue)


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
  fun sQLGetDescRecW(phdesc: Pointer[None] tag, piRecord: I16, pszName: CBoxedI32, pcbNameMax: I16, ppcbName: CBoxedI16, ppfType: CBoxedI16, ppfSubType: CBoxedI16, ppLength: CBoxedI64, ppPrecision: CBoxedI16, ppScale: CBoxedI16, ppNullable: CBoxedI16): I16 =>
    @SQLGetDescRecW(phdesc, piRecord, pszName, pcbNameMax, ppcbName, ppfType, ppfSubType, ppLength, ppPrecision, ppScale, ppNullable)


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
  fun sQLGetDiagFieldW(pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pfDiagField: I16, prgbDiagInfo: Pointer[None] tag, pcbDiagInfoMax: I16, ppcbDiagInfo: CBoxedI16): I16 =>
    @SQLGetDiagFieldW(pfHandleType, phandle, piRecord, pfDiagField, prgbDiagInfo, pcbDiagInfoMax, ppcbDiagInfo)


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
  fun sQLGetDiagRecW(pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pszSqlState: CBoxedI32, ppfNativeError: CBoxedI32, pszErrorMsg: CBoxedI32, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16): I16 =>
    @SQLGetDiagRecW(pfHandleType, phandle, piRecord, pszSqlState, ppfNativeError, pszErrorMsg, pcbErrorMsgMax, ppcbErrorMsg)


/*
  Source: /usr/include/iodbc/sqlucode.h:236
  Original Name: SQLPrepareW/usr/include/iodbc/sqlucode.h:236

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(int) size=32]
*/
  fun sQLPrepareW(phstmt: Pointer[None] tag, pszSqlStr: CBoxedI32, pcbSqlStr: I32): I16 =>
    @SQLPrepareW(phstmt, pszSqlStr, pcbSqlStr)


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
  fun sQLSetConnectAttrW(phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValue: I32): I16 =>
    @SQLSetConnectAttrW(phdbc, pfAttribute, prgbValue, pcbValue)


/*
  Source: /usr/include/iodbc/sqlucode.h:247
  Original Name: SQLSetCursorNameW/usr/include/iodbc/sqlucode.h:247

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(int) size=32]
    [FundamentalType(short int) size=16]
*/
  fun sQLSetCursorNameW(phstmt: Pointer[None] tag, pszCursor: CBoxedI32, pcbCursor: I16): I16 =>
    @SQLSetCursorNameW(phstmt, pszCursor, pcbCursor)


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
  fun sQLColumnsW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszTableName: CBoxedI32, pcbTableName: I16, pszColumnName: CBoxedI32, pcbColumnName: I16): I16 =>
    @SQLColumnsW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszTableName, pcbTableName, pszColumnName, pcbColumnName)


/*
  Source: /usr/include/iodbc/sqlucode.h:263
  Original Name: SQLGetConnectOptionW/usr/include/iodbc/sqlucode.h:263

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLGetConnectOptionW(phdbc: Pointer[None] tag, pfOption: U16, ppvParam: Pointer[None] tag): I16 =>
    @SQLGetConnectOptionW(phdbc, pfOption, ppvParam)


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
  fun sQLGetInfoW(phdbc: Pointer[None] tag, pfInfoType: U16, prgbInfoValue: Pointer[None] tag, pcbInfoValueMax: I16, ppcbInfoValue: CBoxedI16): I16 =>
    @SQLGetInfoW(phdbc, pfInfoType, prgbInfoValue, pcbInfoValueMax, ppcbInfoValue)


/*
  Source: /usr/include/iodbc/sqlucode.h:275
  Original Name: SQLGetTypeInfoW/usr/include/iodbc/sqlucode.h:275

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
  fun sQLGetTypeInfoW(pStatementHandle: Pointer[None] tag, pDataType: I16): I16 =>
    @SQLGetTypeInfoW(pStatementHandle, pDataType)


/*
  Source: /usr/include/iodbc/sqlucode.h:279
  Original Name: SQLSetConnectOptionW/usr/include/iodbc/sqlucode.h:279

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
  fun sQLSetConnectOptionW(phdbc: Pointer[None] tag, pfOption: U16, pvParam: U64): I16 =>
    @SQLSetConnectOptionW(phdbc, pfOption, pvParam)


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
  fun sQLSpecialColumnsW(phstmt: Pointer[None] tag, pfColType: U16, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszTableName: CBoxedI32, pcbTableName: I16, pfScope: U16, pfNullable: U16): I16 =>
    @SQLSpecialColumnsW(phstmt, pfColType, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszTableName, pcbTableName, pfScope, pfNullable)


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
  fun sQLStatisticsW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszTableName: CBoxedI32, pcbTableName: I16, pfUnique: U16, pfAccuracy: U16): I16 =>
    @SQLStatisticsW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszTableName, pcbTableName, pfUnique, pfAccuracy)


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
  fun sQLTablesW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszTableName: CBoxedI32, pcbTableName: I16, pszTableType: CBoxedI32, pcbTableType: I16): I16 =>
    @SQLTablesW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszTableName, pcbTableName, pszTableType, pcbTableType)


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
  fun sQLDataSourcesW(phenv: Pointer[None] tag, pfDirection: U16, pszDSN: CBoxedI32, pcbDSNMax: I16, ppcbDSN: CBoxedI16, pszDescription: CBoxedI32, pcbDescriptionMax: I16, ppcbDescription: CBoxedI16): I16 =>
    @SQLDataSourcesW(phenv, pfDirection, pszDSN, pcbDSNMax, ppcbDSN, pszDescription, pcbDescriptionMax, ppcbDescription)


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
  fun sQLDriverConnectW(phdbc: Pointer[None] tag, phwnd: Pointer[None] tag, pszConnStrIn: CBoxedI32, pcbConnStrIn: I16, pszConnStrOut: CBoxedI32, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16, pfDriverCompletion: U16): I16 =>
    @SQLDriverConnectW(phdbc, phwnd, pszConnStrIn, pcbConnStrIn, pszConnStrOut, pcbConnStrOutMax, ppcbConnStrOut, pfDriverCompletion)


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
  fun sQLBrowseConnectW(phdbc: Pointer[None] tag, pszConnStrIn: CBoxedI32, pcbConnStrIn: I16, pszConnStrOut: CBoxedI32, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16): I16 =>
    @SQLBrowseConnectW(phdbc, pszConnStrIn, pcbConnStrIn, pszConnStrOut, pcbConnStrOutMax, ppcbConnStrOut)


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
  fun sQLColumnPrivilegesW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszTableName: CBoxedI32, pcbTableName: I16, pszColumnName: CBoxedI32, pcbColumnName: I16): I16 =>
    @SQLColumnPrivilegesW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszTableName, pcbTableName, pszColumnName, pcbColumnName)


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
  fun sQLGetStmtAttrW(phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32): I16 =>
    @SQLGetStmtAttrW(phstmt, pfAttribute, prgbValue, pcbValueMax, ppcbValue)


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
  fun sQLSetStmtAttrW(phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32): I16 =>
    @SQLSetStmtAttrW(phstmt, pfAttribute, prgbValue, pcbValueMax)


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
  fun sQLForeignKeysW(phstmt: Pointer[None] tag, pszPkCatalogName: CBoxedI32, pcbPkCatalogName: I16, pszPkSchemaName: CBoxedI32, pcbPkSchemaName: I16, pszPkTableName: CBoxedI32, pcbPkTableName: I16, pszFkCatalogName: CBoxedI32, pcbFkCatalogName: I16, pszFkSchemaName: CBoxedI32, pcbFkSchemaName: I16, pszFkTableName: CBoxedI32, pcbFkTableName: I16): I16 =>
    @SQLForeignKeysW(phstmt, pszPkCatalogName, pcbPkCatalogName, pszPkSchemaName, pcbPkSchemaName, pszPkTableName, pcbPkTableName, pszFkCatalogName, pcbFkCatalogName, pszFkSchemaName, pcbFkSchemaName, pszFkTableName, pcbFkTableName)


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
  fun sQLNativeSqlW(phdbc: Pointer[None] tag, pszSqlStrIn: CBoxedI32, pcbSqlStrIn: I32, pszSqlStr: CBoxedI32, pcbSqlStrMax: I32, ppcbSqlStr: CBoxedI32): I16 =>
    @SQLNativeSqlW(phdbc, pszSqlStrIn, pcbSqlStrIn, pszSqlStr, pcbSqlStrMax, ppcbSqlStr)


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
  fun sQLPrimaryKeysW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszTableName: CBoxedI32, pcbTableName: I16): I16 =>
    @SQLPrimaryKeysW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszTableName, pcbTableName)


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
  fun sQLProcedureColumnsW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszProcName: CBoxedI32, pcbProcName: I16, pszColumnName: CBoxedI32, pcbColumnName: I16): I16 =>
    @SQLProcedureColumnsW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszProcName, pcbProcName, pszColumnName, pcbColumnName)


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
  fun sQLProceduresW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszProcName: CBoxedI32, pcbProcName: I16): I16 =>
    @SQLProceduresW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszProcName, pcbProcName)


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
  fun sQLTablePrivilegesW(phstmt: Pointer[None] tag, pszCatalogName: CBoxedI32, pcbCatalogName: I16, pszSchemaName: CBoxedI32, pcbSchemaName: I16, pszTableName: CBoxedI32, pcbTableName: I16): I16 =>
    @SQLTablePrivilegesW(phstmt, pszCatalogName, pcbCatalogName, pszSchemaName, pcbSchemaName, pszTableName, pcbTableName)


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
  fun sQLDriversW(phenv: Pointer[None] tag, pfDirection: U16, pszDriverDesc: CBoxedI32, pcbDriverDescMax: I16, ppcbDriverDesc: CBoxedI16, pszDriverAttributes: CBoxedI32, pcbDrvrAttrMax: I16, ppcbDrvrAttr: CBoxedI16): I16 =>
    @SQLDriversW(phenv, pfDirection, pszDriverDesc, pcbDriverDescMax, ppcbDriverDesc, pszDriverAttributes, pcbDrvrAttrMax, ppcbDrvrAttr)


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
  fun sQLColAttributeA(phstmt: Pointer[None] tag, piCol: U16, piField: U16, ppCharAttr: Pointer[None] tag, pcbCharAttrMax: I16, ppcbCharAttr: CBoxedI16, ppNumAttr: CBoxedI64): I16 =>
    @SQLColAttributeA(phstmt, piCol, piField, ppCharAttr, pcbCharAttrMax, ppcbCharAttr, ppNumAttr)


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
  fun sQLColAttributesA(phstmt: Pointer[None] tag, picol: U16, pfDescType: U16, prgbDesc: Pointer[None] tag, pcbDescMax: I16, ppcbDesc: CBoxedI16, ppfDesc: CBoxedI64): I16 =>
    @SQLColAttributesA(phstmt, picol, pfDescType, prgbDesc, pcbDescMax, ppcbDesc, ppfDesc)


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
  fun sQLConnectA(phdbc: Pointer[None] tag, pszDSN: String, pcbDSN: I16, pszUID: String, pcbUID: I16, pszAuthStr: String, pcbAuthStr: I16): I16 =>
    @SQLConnectA(phdbc, pszDSN.cstring(), pcbDSN, pszUID.cstring(), pcbUID, pszAuthStr.cstring(), pcbAuthStr)


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
  fun sQLDescribeColA(phstmt: Pointer[None] tag, picol: U16, pszColName: String, pcbColNameMax: I16, ppcbColName: CBoxedI16, ppfSqlType: CBoxedI16, ppcbColDef: CBoxedU64, ppibScale: CBoxedI16, ppfNullable: CBoxedI16): I16 =>
    @SQLDescribeColA(phstmt, picol, pszColName.cstring(), pcbColNameMax, ppcbColName, ppfSqlType, ppcbColDef, ppibScale, ppfNullable)


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
  fun sQLErrorA(phenv: Pointer[None] tag, phdbc: Pointer[None] tag, phstmt: Pointer[None] tag, pszSqlState: String, ppfNativeError: CBoxedI32, pszErrorMsg: String, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16): I16 =>
    @SQLErrorA(phenv, phdbc, phstmt, pszSqlState.cstring(), ppfNativeError, pszErrorMsg.cstring(), pcbErrorMsgMax, ppcbErrorMsg)


/*
  Source: /usr/include/iodbc/sqlucode.h:494
  Original Name: SQLExecDirectA/usr/include/iodbc/sqlucode.h:494

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
  fun sQLExecDirectA(phstmt: Pointer[None] tag, pszSqlStr: String, pcbSqlStr: I32): I16 =>
    @SQLExecDirectA(phstmt, pszSqlStr.cstring(), pcbSqlStr)


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
  fun sQLGetConnectAttrA(phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32): I16 =>
    @SQLGetConnectAttrA(phdbc, pfAttribute, prgbValue, pcbValueMax, ppcbValue)


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
  fun sQLGetCursorNameA(phstmt: Pointer[None] tag, pszCursor: String, pcbCursorMax: I16, ppcbCursor: CBoxedI16): I16 =>
    @SQLGetCursorNameA(phstmt, pszCursor.cstring(), pcbCursorMax, ppcbCursor)


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
  fun sQLSetDescFieldA(pDescriptorHandle: Pointer[None] tag, pRecNumber: I16, pFieldIdentifier: I16, pValue: Pointer[None] tag, pBufferLength: I32): I16 =>
    @SQLSetDescFieldA(pDescriptorHandle, pRecNumber, pFieldIdentifier, pValue, pBufferLength)


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
  fun sQLGetDescFieldA(phdesc: Pointer[None] tag, piRecord: I16, piField: I16, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32): I16 =>
    @SQLGetDescFieldA(phdesc, piRecord, piField, prgbValue, pcbValueMax, ppcbValue)


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
  fun sQLGetDescRecA(phdesc: Pointer[None] tag, piRecord: I16, pszName: String, pcbNameMax: I16, ppcbName: CBoxedI16, ppfType: CBoxedI16, ppfSubType: CBoxedI16, ppLength: CBoxedI64, ppPrecision: CBoxedI16, ppScale: CBoxedI16, ppNullable: CBoxedI16): I16 =>
    @SQLGetDescRecA(phdesc, piRecord, pszName.cstring(), pcbNameMax, ppcbName, ppfType, ppfSubType, ppLength, ppPrecision, ppScale, ppNullable)


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
  fun sQLGetDiagFieldA(pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pfDiagField: I16, prgbDiagInfo: Pointer[None] tag, pcbDiagInfoMax: I16, ppcbDiagInfo: CBoxedI16): I16 =>
    @SQLGetDiagFieldA(pfHandleType, phandle, piRecord, pfDiagField, prgbDiagInfo, pcbDiagInfoMax, ppcbDiagInfo)


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
  fun sQLGetDiagRecA(pfHandleType: I16, phandle: Pointer[None] tag, piRecord: I16, pszSqlState: String, ppfNativeError: CBoxedI32, pszErrorMsg: String, pcbErrorMsgMax: I16, ppcbErrorMsg: CBoxedI16): I16 =>
    @SQLGetDiagRecA(pfHandleType, phandle, piRecord, pszSqlState.cstring(), ppfNativeError, pszErrorMsg.cstring(), pcbErrorMsgMax, ppcbErrorMsg)


/*
  Source: /usr/include/iodbc/sqlucode.h:561
  Original Name: SQLPrepareA/usr/include/iodbc/sqlucode.h:561

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(int) size=32]
*/
  fun sQLPrepareA(phstmt: Pointer[None] tag, pszSqlStr: String, pcbSqlStr: I32): I16 =>
    @SQLPrepareA(phstmt, pszSqlStr.cstring(), pcbSqlStr)


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
  fun sQLSetConnectAttrA(phdbc: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValue: I32): I16 =>
    @SQLSetConnectAttrA(phdbc, pfAttribute, prgbValue, pcbValue)


/*
  Source: /usr/include/iodbc/sqlucode.h:572
  Original Name: SQLSetCursorNameA/usr/include/iodbc/sqlucode.h:572

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [PointerType size=64]->[FundamentalType(unsigned char) size=8]
    [FundamentalType(short int) size=16]
*/
  fun sQLSetCursorNameA(phstmt: Pointer[None] tag, pszCursor: String, pcbCursor: I16): I16 =>
    @SQLSetCursorNameA(phstmt, pszCursor.cstring(), pcbCursor)


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
  fun sQLColumnsA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16, pszColumnName: String, pcbColumnName: I16): I16 =>
    @SQLColumnsA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName, pszColumnName.cstring(), pcbColumnName)


/*
  Source: /usr/include/iodbc/sqlucode.h:588
  Original Name: SQLGetConnectOptionA/usr/include/iodbc/sqlucode.h:588

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [PointerType size=64]->[FundamentalType(void) size=0]
*/
  fun sQLGetConnectOptionA(phdbc: Pointer[None] tag, pfOption: U16, ppvParam: Pointer[None] tag): I16 =>
    @SQLGetConnectOptionA(phdbc, pfOption, ppvParam)


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
  fun sQLGetInfoA(phdbc: Pointer[None] tag, pfInfoType: U16, prgbInfoValue: Pointer[None] tag, pcbInfoValueMax: I16, ppcbInfoValue: CBoxedI16): I16 =>
    @SQLGetInfoA(phdbc, pfInfoType, prgbInfoValue, pcbInfoValueMax, ppcbInfoValue)


/*
  Source: /usr/include/iodbc/sqlucode.h:600
  Original Name: SQLGetTypeInfoA/usr/include/iodbc/sqlucode.h:600

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short int) size=16]
*/
  fun sQLGetTypeInfoA(pStatementHandle: Pointer[None] tag, pDataType: I16): I16 =>
    @SQLGetTypeInfoA(pStatementHandle, pDataType)


/*
  Source: /usr/include/iodbc/sqlucode.h:604
  Original Name: SQLSetConnectOptionA/usr/include/iodbc/sqlucode.h:604

  Return Value: [FundamentalType(short int) size=16]

  Arguments:
    [PointerType size=64]->[FundamentalType(void) size=0]
    [FundamentalType(short unsigned int) size=16]
    [FundamentalType(long unsigned int) size=64]
*/
  fun sQLSetConnectOptionA(phdbc: Pointer[None] tag, pfOption: U16, pvParam: U64): I16 =>
    @SQLSetConnectOptionA(phdbc, pfOption, pvParam)


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
  fun sQLSpecialColumnsA(phstmt: Pointer[None] tag, pfColType: U16, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16, pfScope: U16, pfNullable: U16): I16 =>
    @SQLSpecialColumnsA(phstmt, pfColType, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName, pfScope, pfNullable)


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
  fun sQLStatisticsA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16, pfUnique: U16, pfAccuracy: U16): I16 =>
    @SQLStatisticsA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName, pfUnique, pfAccuracy)


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
  fun sQLTablesA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16, pszTableType: String, pcbTableType: I16): I16 =>
    @SQLTablesA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName, pszTableType.cstring(), pcbTableType)


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
  fun sQLDataSourcesA(phenv: Pointer[None] tag, pfDirection: U16, pszDSN: String, pcbDSNMax: I16, ppcbDSN: CBoxedI16, pszDescription: String, pcbDescriptionMax: I16, ppcbDescription: CBoxedI16): I16 =>
    @SQLDataSourcesA(phenv, pfDirection, pszDSN.cstring(), pcbDSNMax, ppcbDSN, pszDescription.cstring(), pcbDescriptionMax, ppcbDescription)


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
  fun sQLDriverConnectA(phdbc: Pointer[None] tag, phwnd: Pointer[None] tag, pszConnStrIn: String, pcbConnStrIn: I16, pszConnStrOut: String, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16, pfDriverCompletion: U16): I16 =>
    @SQLDriverConnectA(phdbc, phwnd, pszConnStrIn.cstring(), pcbConnStrIn, pszConnStrOut.cstring(), pcbConnStrOutMax, ppcbConnStrOut, pfDriverCompletion)


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
  fun sQLBrowseConnectA(phdbc: Pointer[None] tag, pszConnStrIn: String, pcbConnStrIn: I16, pszConnStrOut: String, pcbConnStrOutMax: I16, ppcbConnStrOut: CBoxedI16): I16 =>
    @SQLBrowseConnectA(phdbc, pszConnStrIn.cstring(), pcbConnStrIn, pszConnStrOut.cstring(), pcbConnStrOutMax, ppcbConnStrOut)


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
  fun sQLColumnPrivilegesA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16, pszColumnName: String, pcbColumnName: I16): I16 =>
    @SQLColumnPrivilegesA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName, pszColumnName.cstring(), pcbColumnName)


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
  fun sQLGetStmtAttrA(phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32, ppcbValue: CBoxedI32): I16 =>
    @SQLGetStmtAttrA(phstmt, pfAttribute, prgbValue, pcbValueMax, ppcbValue)


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
  fun sQLSetStmtAttrA(phstmt: Pointer[None] tag, pfAttribute: I32, prgbValue: Pointer[None] tag, pcbValueMax: I32): I16 =>
    @SQLSetStmtAttrA(phstmt, pfAttribute, prgbValue, pcbValueMax)


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
  fun sQLForeignKeysA(phstmt: Pointer[None] tag, pszPkCatalogName: String, pcbPkCatalogName: I16, pszPkSchemaName: String, pcbPkSchemaName: I16, pszPkTableName: String, pcbPkTableName: I16, pszFkCatalogName: String, pcbFkCatalogName: I16, pszFkSchemaName: String, pcbFkSchemaName: I16, pszFkTableName: String, pcbFkTableName: I16): I16 =>
    @SQLForeignKeysA(phstmt, pszPkCatalogName.cstring(), pcbPkCatalogName, pszPkSchemaName.cstring(), pcbPkSchemaName, pszPkTableName.cstring(), pcbPkTableName, pszFkCatalogName.cstring(), pcbFkCatalogName, pszFkSchemaName.cstring(), pcbFkSchemaName, pszFkTableName.cstring(), pcbFkTableName)


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
  fun sQLNativeSqlA(phdbc: Pointer[None] tag, pszSqlStrIn: String, pcbSqlStrIn: I32, pszSqlStr: String, pcbSqlStrMax: I32, ppcbSqlStr: CBoxedI32): I16 =>
    @SQLNativeSqlA(phdbc, pszSqlStrIn.cstring(), pcbSqlStrIn, pszSqlStr.cstring(), pcbSqlStrMax, ppcbSqlStr)


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
  fun sQLPrimaryKeysA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16): I16 =>
    @SQLPrimaryKeysA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName)


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
  fun sQLProcedureColumnsA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszProcName: String, pcbProcName: I16, pszColumnName: String, pcbColumnName: I16): I16 =>
    @SQLProcedureColumnsA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszProcName.cstring(), pcbProcName, pszColumnName.cstring(), pcbColumnName)


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
  fun sQLProceduresA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszProcName: String, pcbProcName: I16): I16 =>
    @SQLProceduresA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszProcName.cstring(), pcbProcName)


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
  fun sQLTablePrivilegesA(phstmt: Pointer[None] tag, pszCatalogName: String, pcbCatalogName: I16, pszSchemaName: String, pcbSchemaName: I16, pszTableName: String, pcbTableName: I16): I16 =>
    @SQLTablePrivilegesA(phstmt, pszCatalogName.cstring(), pcbCatalogName, pszSchemaName.cstring(), pcbSchemaName, pszTableName.cstring(), pcbTableName)


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
  fun sQLDriversA(phenv: Pointer[None] tag, pfDirection: U16, pszDriverDesc: String, pcbDriverDescMax: I16, ppcbDriverDesc: CBoxedI16, pszDriverAttributes: String, pcbDrvrAttrMax: I16, ppcbDrvrAttr: CBoxedI16): I16 =>
    @SQLDriversA(phenv, pfDirection, pszDriverDesc.cstring(), pcbDriverDescMax, ppcbDriverDesc, pszDriverAttributes.cstring(), pcbDrvrAttrMax, ppcbDrvrAttr)
