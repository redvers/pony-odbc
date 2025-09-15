type SQLInfoTypes is (
      SqlDBMSName
    | SqlDBMSVer
    | SqlDataSourceName
    | SqlDriverName
    | SqlServerName
    | SqlDatabaseName
    | SqlUserName
    | SqlCatalogName
    | SqlDriverODBCVer
    | SqlDriverVer
    | SqlODBCVer
    | SqlDMVer
)
primitive \nodoc\ SqlDBMSName fun apply(): U16 => 17
primitive \nodoc\ SqlDBMSVer  fun apply(): U16 => 18
primitive \nodoc\ SqlDataSourceName fun apply(): U16 => 2
primitive \nodoc\ SqlDriverName fun apply(): U16 => 6
primitive \nodoc\ SqlServerName fun apply(): U16 => 13
primitive \nodoc\ SqlDatabaseName fun apply(): U16 => 16
primitive \nodoc\ SqlUserName fun apply(): U16 => 47
primitive \nodoc\ SqlCatalogName fun apply(): U16 => 10003
primitive \nodoc\ SqlDriverODBCVer fun apply(): U16 => 77
primitive \nodoc\ SqlDriverVer fun apply(): U16 => 7
primitive \nodoc\ SqlODBCVer fun apply(): U16 => 10
primitive \nodoc\ SqlDMVer fun apply(): U16 => 171
