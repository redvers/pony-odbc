
type SQLReturn is (SQLSuccess | SQLSuccessWithInfo | SQLStillExecuting | SQLError | SQLInvalidHandle | SQLNeedData | PonyDriverError | SQLNoData)
  """
  # Return Codes ODBC
Each function in ODBC returns a code, known as its *return code,* which indicates the overall success or failure of the function. Program logic is generally based on return codes.

 The return code SqlInvalidHandle always indicates a programming error and should never be encountered at run time. All other return codes provide run-time information, although SqlError may indicate a programming error.

 The following table defines the return codes.

|Return code|Description|
|-----------------|-----------------|
|SqlSuccess|Function completed successfully. The application calls **SQLGetDiagField** to retrieve additional information from the header record.|
|SqlSuccessWithInfo|Function completed successfully, possibly with a nonfatal error (warning). The application calls **SQLGetDiagRec** or **SQLGetDiagField** to retrieve additional information.|
|SqlError|Function failed. The application calls **SQLGetDiagRec** or **SQLGetDiagField** to retrieve additional information. The contents of any output arguments to the function are undefined.|
|SqlInvalidHandle|Function failed due to an invalid environment, connection, statement, or descriptor handle. This indicates a programming error. No additional information is available from **SQLGetDiagRec** or **SQLGetDiagField**. This code is returned only when the handle is a null pointer or is the wrong type, such as when a statement handle is passed for an argument that requires a connection handle.|
|SqlNoData|No more data was available. The application calls **SQLGetDiagRec** or **SQLGetDiagField** to retrieve additional information. One or more driver-defined status records in class 02xxx may be returned. **Note:**  In ODBC 2.*x*, this return code was named SQL_NO_DATA_FOUND.|
|SqlNeedData|More data is needed, such as when parameter data is sent at execution time or additional connection information is required. The application calls **SQLGetDiagRec** or **SQLGetDiagField** to retrieve additional information, if any.|
|SqlStillExecuting|A function that was started asynchronously is still executing. The application calls **SQLGetDiagRec** or **SQLGetDiagField** to retrieve additional information, if any.|
"""
