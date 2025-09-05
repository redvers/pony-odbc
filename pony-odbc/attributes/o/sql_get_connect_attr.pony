/*
 *  SQLGetConnectAttr - ODBC 3.0 attributes
 */

/*
primitive SQLAttrAccessMode         fun apply(): I16 => 101
primitive SQLAttrAutocommit         fun apply(): I16 => 102
primitive SQLAttrLoginTimeout       fun apply(): I16 => 103
primitive SQLAttrTrace              fun apply(): I16 => 104
primitive SQLAttrTracefile          fun apply(): I16 => 105
primitive SQLAttrTranslateLib       fun apply(): I16 => 106
primitive SQLAttrTranslateOption    fun apply(): I16 => 107
primitive SQLAttrTxnIsolation       fun apply(): I16 => 108
primitive SQLAttrCurrentCatalog     fun apply(): I16 => 109
primitive SQLAttrOdbcCursors        fun apply(): I16 => 110
primitive SQLAttrQuietMode          fun apply(): I16 => 111
primitive SQLAttrPacketSize         fun apply(): I16 => 112
primitive SQLAttrConnectionTimeout  fun apply(): I16 => 113
primitive SQLAttrDisconnectBehavior fun apply(): I16 => 114

primitive SQLAttrEnlistInDtc        fun apply(): I16 => 1207
primitive SQLAttrEnlistInXa         fun apply(): I16 => 1208
primitive SQLAttrConnectionDead     fun apply(): I16 => 1209

primitive SQLModeReadWrite          fun apply(): I16 => 0
primitive SQLModeReadOnly           fun apply(): I16 => 1
primitive SQLModeReadDefault        fun apply(): I16 => SQLModeReadWrite()


/*
 *  SQLGetConnectAttr - SQL_AUTOCOMMIT
 */
primitive SQLAutoCommitOff          fun apply(): I16 => 0
primitive SQLAutoCommitOn           fun apply(): I16 => 1
primitive SQLAutoCommitDefault      fun apply(): I16 => SQLAutoCommitOn()


/*
 *  SQLGetConnectAttr - SQL_LOGIN_TIMEOUT
 */
primitive SQLLoginTimeoutDefault    fun apply(): I16 => 15


/*
 *  SQLGetConnectAttr - SQL_ODBC_CURSORS
 */
primitive SQLCurUseIfNeeded         fun apply(): I16 => 0
primitive SQLCurUseOdbc             fun apply(): I16 => 1
primitive SQLCurUseDriver           fun apply(): I16 => 2
primitive SQLCurUseDefault          fun apply(): I16 => SQLCurUseDriver()


/*
 *  SQLGetConnectAttr - SQL_OPT_TRACE
 */
primitive SQLOptTraceOff            fun apply(): I16 => 0
primitive SQLOptTraceOn             fun apply(): I16 => 1
primitive SQLOptTraceDefault        fun apply(): I16 => SQLOptTraceOff()


/*
 *  SQLGetConnectAttr - SQL_ATTR_ANSI_APP
 */
primitive SQLAATrue                 fun apply(): I16 => 1
primitive SQLAAFalse                fun apply(): I16 => 0


/*
 *  SQLGetConnectAttr - SQL_ATTR_CONNECTION_DEAD
 */
primitive SQLCdTrue                 fun apply(): I16 => 1 /* closed/dead */
primitive SQLCdFalse                fun apply(): I16 => 0 /* open/available */


/*
 *  SQLGetConnectAttr - SQL_ATTR_DISCONNECT_BEHAVIOR
 */
primitive SQLDbReturnToPool         fun apply(): I16 => 0
primitive SQLDbDisconnect           fun apply(): I16 => 1
primitive SQLDbDefault              fun apply(): I16 => SQLDbReturnToPool()


/*
 *  SQLGetConnectAttr - SQL_ATTR_ENLIST_IN_DTC
 */
primitive SQLDtcDone                fun apply(): I16 => 0


/*
 *   SQLGetConnectAttr - Unicode drivers
 */
primitive SQLAttrAnsiApp            fun apply(): I16 => 115

primitive SQLAttrApplicationName    fun apply(): I32 => 1051
*/
