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
primitive SqlDBMSName fun apply(): U16 => 17
primitive SqlDBMSVer  fun apply(): U16 => 18
primitive SqlDataSourceName fun apply(): U16 => 2
primitive SqlDriverName fun apply(): U16 => 6
primitive SqlServerName fun apply(): U16 => 13
primitive SqlDatabaseName fun apply(): U16 => 16
primitive SqlUserName fun apply(): U16 => 47
primitive SqlCatalogName fun apply(): U16 => 10003
primitive SqlDriverODBCVer fun apply(): U16 => 77
primitive SqlDriverVer fun apply(): U16 => 7
primitive SqlODBCVer fun apply(): U16 => 10
primitive SqlDMVer fun apply(): U16 => 171
