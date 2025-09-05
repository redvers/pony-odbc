/*
/*
 *  SQLGetEnvAttr - Attributes
 */
primitive SQLAttrOdbcVersion       fun apply(): I32 => 200
primitive SQLAttrConnectionPooling fun apply(): I16 => 201
primitive SQLAttrCpMatch           fun apply(): I16 => 202


/*
 * SQLGetEnvAttr - SQL_ATTR_ODBC_VERSION
 */
primitive SQLAttrOvOdbc2           fun apply(): I32 => 2
primitive SQLAttrOvOdbc3           fun apply(): I32 => 3


/*
 *  SQLGetEnvAttr - SQL_ATTR_CONNECTION_POOLING
 */
primitive SQLCpOff                 fun apply(): I16 => 0
primitive SQLCpOnePerDriver        fun apply(): I16 => 1
primitive SQLCpOnePerHenv          fun apply(): I16 => 2
primitive SQLCpDefault             fun apply(): I16 => SQLCpOff()


/*
 * SQLGetEnvAttr - SQL_ATTR_CP_MATCH
 */
primitive SQLCpStrictMatch         fun apply(): I16 => 0
primitive SQLCpRelaxedMatch        fun apply(): I16 => 1
primitive SQLCpMatchDefault        fun apply(): I16 => SQLCpStrictMatch()

                                                */
