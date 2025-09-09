use @SQLSetEnvAttr[I16](henv: Pointer[None] tag, attr: I32, v: I32, sl: I32)
use @SQLGetEnvAttr[I16](EnvironmentHandle: Pointer[None] tag, Attribute: I32, Value: Pointer[None] tag, BufferLength: I32, StringLength: CBoxedI32 tag)
use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[ODBCHandleEnv tag] tag)
use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)

use "../ctypes"
use "../attributes"
use "../instrumentation"

struct \nodoc\ ODBCHandleEnv

primitive ODBCEnvFFI
  """
  |*Attribute*|*ValuePtr* contents|
|-----------------|-------------------------|
|SQL_ATTR_CONNECTION_POOLING (ODBC 3.8)|A 32-bit SQLUINTEGER value that enables or disables connection pooling at the environment level. The following values are used:<br /><br /> SQL_CP_OFF = Connection pooling is turned off. This is the default.<br /><br /> SQL_CP_ONE_PER_DRIVER = A single connection pool is supported for each driver. Every connection in a pool is associated with one driver.<br /><br /> SQL_CP_ONE_PER_HENV = A single connection pool is supported for each environment. Every connection in a pool is associated with one environment.<br /><br /> SQL_CP_DRIVER_AWARE = Use the connection-pool awareness feature of the driver, if it is available. If the driver does not support connection-pool awareness, SQL_CP_DRIVER_AWARE is ignored and SQL_CP_ONE_PER_HENV is used. For more information, see [Driver-Aware Connection Pooling](../../../odbc/reference/develop-app/driver-aware-connection-pooling.md). In an environment where some drivers support and some drivers do not support connection-pool awareness, SQL_CP_DRIVER_AWARE can enable the connection-pool awareness feature on those supporting drivers, but it is equivalent to setting to SQL_CP_ONE_PER_HENV on those drivers that do not support connection-pool awareness feature.<br /><br /> Connection pooling is enabled by calling **SQLSetEnvAttr** to set the SQL_ATTR_CONNECTION_POOLING attribute to SQL_CP_ONE_PER_DRIVER or SQL_CP_ONE_PER_HENV. This call must be made before the application allocates the shared environment for which connection pooling is to be enabled. The environment handle in the call to **SQLSetEnvAttr** is set to null, which makes SQL_ATTR_CONNECTION_POOLING a process-level attribute. After connection pooling is enabled, the application then allocates an implicit shared environment by calling **SQLAllocHandle** with the *InputHandle* argument set to SQL_HANDLE_ENV.<br /><br /> After connection pooling has been enabled and a shared environment has been selected for an application, SQL_ATTR_CONNECTION_POOLING cannot be reset for that environment, because **SQLSetEnvAttr** is called with a null environment handle when setting this attribute. If this attribute is set while connection pooling is already enabled on a shared environment, the attribute affects only shared environments that are allocated subsequently.<br /><br /> It is also possible to enable connection pooling on an environment. Note the following about environment connection pooling:<br /><br /> -   Enabling connection pooling on a NULL handle is a process-level attribute. Subsequently allocated environments will be a shared environment, and will inherit the process-level connection pooling setting.<br />-   After an environment is allocated, an application can still change its connection pool setting.<br />-   If environment connection pooling is enabled and the connection's driver uses driver pooling, environment pooling takes preference.<br /><br /> SQL_ATTR_CONNECTION_POOLING is implemented inside the Driver Manager. A driver does not need to implement SQL_ATTR_CONNECTION_POOLING. ODBC 2.0 and 3.0 applications can set this environment attribute.<br /><br /> For more information, see [ODBC Connection Pooling](../../../odbc/reference/develop-app/driver-manager-connection-pooling.md).|
|SQL_ATTR_CP_MATCH (ODBC 3.0)|A 32-bit SQLUINTEGER value that determines how a connection is chosen from a connection pool. When **SQLConnect** or **SQLDriverConnect** is called, the Driver Manager determines which connection is reused from the pool. The Driver Manager tries to match the connection options in the call and the connection attributes set by the application to the keywords and connection attributes of the connections in the pool. The value of this attribute determines the level of precision of the matching criteria.<br /><br /> The following values are used to set the value of this attribute:<br /><br /> SQL_CP_STRICT_MATCH = Only connections that exactly match the connection options in the call and the connection attributes set by the application are reused. This is the default.<br /><br /> SQL_CP_RELAXED_MATCH = Connections with matching connection string keywords can be used. Keywords must match, but not all connection attributes must match.<br /><br /> For more information about how the Driver Manager performs the match in connecting to a pooled connection, see [SQLConnect](../../../odbc/reference/syntax/sqlconnect-function.md). For more information about connection pooling, see [ODBC Connection Pooling](../../../odbc/reference/develop-app/driver-manager-connection-pooling.md).|
|SQL_ATTR_ODBC_VERSION (ODBC 3.0)|A 32-bit integer that determines whether certain functionality exhibits ODBC *2.x* behavior or ODBC *3.x* behavior. The following values are used to set the value of this attribute:<br /><br /> SQL_OV_ODBC3_80 = The Driver Manager and driver exhibit the following ODBC 3.8 behavior:<br /><br /> -   The driver returns and expects ODBC *3.x* codes for date, time, and timestamp.<br />-   The driver returns ODBC *3.x* SQLSTATE codes when **SQLError**, **SQLGetDiagField**, or **SQLGetDiagRec** is called.<br />-   The *CatalogName* argument in a call to **SQLTables** accepts a search pattern.<br />-   The Driver Manager supports C data type extensibility. For more information about C data type extensibility, see [C Data Types in ODBC](../../../odbc/reference/develop-app/c-data-types-in-odbc.md).<br /><br /> For more information, see [What's New in ODBC 3.8](../../../odbc/reference/what-s-new-in-odbc-3-8.md).<br /><br /> SQL_OV_ODBC3 = The Driver Manager and driver exhibit the following ODBC *3.x* behavior:<br /><br /> -   The driver returns and expects ODBC *3.x* codes for date, time, and timestamp.<br />-   The driver returns ODBC *3.x* SQLSTATE codes when **SQLError**, **SQLGetDiagField**, or **SQLGetDiagRec** is called.<br />-   The *CatalogName* argument in a call to **SQLTables** accepts a search pattern.<br />-   The Driver Manager does not support C data type extensibility.<br /><br /> SQL_OV_ODBC2 = The Driver Manager and driver exhibit the following ODBC *2.x* behavior. This is especially useful for an ODBC *2.x* application working with an ODBC *3.x* driver.<br /><br /> -   The driver returns and expects ODBC *2.x* codes for date, time, and timestamp.<br />-   The driver returns ODBC *2.x* SQLSTATE codes when **SQLError**, **SQLGetDiagField**, or **SQLGetDiagRec** is called.<br />-   The *CatalogName* argument in a call to **SQLTables** does not accept a search pattern.<br />-   The Driver Manager does not support C data type extensibility.<br /><br /> An application must set this environment attribute before it calls any function that has an SQLHENV argument, or the call will return SQLSTATE HY010 (Function sequence error). It is driver-specific whether additional behavior exists for these environmental flags.<br /><br /> -   For more information, see [Declaring the Application's ODBC Version](../../../odbc/reference/develop-app/declaring-the-application-s-odbc-version.md) and [Behavioral Changes](../../../odbc/reference/develop-app/behavioral-changes.md).|
|SQL_ATTR_OUTPUT_NTS (ODBC 3.0)|A 32-bit integer that determines how the driver returns string data. If SQL_TRUE, the driver returns string data null-terminated. If SQL_FALSE, the driver does not return string data null-terminated.<br /><br /> This attribute defaults to SQL_TRUE. A call to **SQLSetEnvAttr** to set it to SQL_TRUE returns SQL_SUCCESS. A call to **SQLSetEnvAttr** to set it to SQL_FALSE returns SQL_ERROR and SQLSTATE HYC00 (Optional feature not implemented).|
"""
  fun alloc(): (SQLReturn val, ODBCHandleEnv tag) =>
    """
    Returns an ODBCHandleEnv, used by the ODBC FFI calls to represent
    your environment.
    """
    ODBCEnvFFI.sql_alloc_handle()

  fun set_odbc2(h: ODBCHandleEnv tag): SQLReturn val =>
    """
    Sets the Environment to version ODBC2.  I should probably remove this
    since I've not implemented any of those functionsi (yet).
    """
    var rv: I16 = @SQLSetEnvAttr(NullablePointer[ODBCHandleEnv tag](h), SQLAttrOdbcVersion(), SQLAttrOvOdbc2(), SQLIsInteger())
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_penv(h) end
    | -1 => return recover val SQLError.create_penv(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCEnvFFI.set_odbc2() got invalid return code: " + rv.string()) end
    end

  fun set_odbc3(h: ODBCHandleEnv tag): SQLReturn val =>
    """
    Sets the Environment to version ODBC3.  You should always call
    this, since version 3 is the only one implemented thus far.
    """
    var rv: I16 = @SQLSetEnvAttr(NullablePointer[ODBCHandleEnv tag](h), SQLAttrOdbcVersion(), SQLAttrOvOdbc3(), SQLIsInteger())
    match rv
    | 0 => return SQLSuccess
    | 1 => return recover val SQLSuccessWithInfo.create_penv(h) end
    | -1 => return recover val SQLError.create_penv(h) end
    | -2 => return SQLInvalidHandle
    else
      recover val PonyDriverError("ODBCEnvFFI.set_odbc3() got invalid return code: " + rv.string()) end
    end

  fun sql_alloc_handle(): (SQLReturn val, ODBCHandleEnv tag) =>
    var rv: ODBCHandleEnv tag = ODBCHandleEnv
    var rvv: I16 = @SQLAllocHandle(1, Pointer[None], addressof rv)
    match rvv
    | 0 => return (SQLSuccess, rv)
    | 1 => return (recover val SQLSuccessWithInfo.create_penv(rv) end, rv)
    | -1 => return (recover val SQLError.create_penv(rv) end, rv)
    | -2 => return (SQLInvalidHandle, rv)
    else
      (recover val PonyDriverError("ODBCEnvFFI.set_odbc2() got invalid return code: " + rvv.string()) end, rv)
    end

  fun free(h: ODBCHandleEnv tag) => @SQLFreeHandle(1, NullablePointer[ODBCHandleEnv tag](h))

