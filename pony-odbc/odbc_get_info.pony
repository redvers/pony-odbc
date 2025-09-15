type _SQLInfoTypes is (
      _SqlDBMSName
    | _SqlDBMSVer
    | _SqlDataSourceName
    | _SqlDriverName
    | _SqlServerName
    | _SqlDatabaseName
    | _SqlUserName
    | _SqlCatalogName
    | _SqlDriverODBCVer
    | _SqlDriverVer
    | _SqlODBCVer
    | _SqlDMVer
)
primitive \nodoc\ _SqlDBMSName fun apply(): U16 => 17
primitive \nodoc\ _SqlDBMSVer  fun apply(): U16 => 18
primitive \nodoc\ _SqlDataSourceName fun apply(): U16 => 2
primitive \nodoc\ _SqlDriverName fun apply(): U16 => 6
primitive \nodoc\ _SqlServerName fun apply(): U16 => 13
primitive \nodoc\ _SqlDatabaseName fun apply(): U16 => 16
primitive \nodoc\ _SqlUserName fun apply(): U16 => 47
primitive \nodoc\ _SqlCatalogName fun apply(): U16 => 10003
primitive \nodoc\ _SqlDriverODBCVer fun apply(): U16 => 77
primitive \nodoc\ _SqlDriverVer fun apply(): U16 => 7
primitive \nodoc\ _SqlODBCVer fun apply(): U16 => 10
primitive \nodoc\ _SqlDMVer fun apply(): U16 => 171
