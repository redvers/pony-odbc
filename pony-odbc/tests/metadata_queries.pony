use "debug"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _TestMetadataQueries is UnitTest
  """
  Tests ODBC metadata query functions:
  - SQLGetTypeInfo (database type information)
  - SQLTables (list tables)
  - SQLColumns (list columns)
  - SQLNumResultCols (result set column count)
  """
  var dsn: String val
  fun name(): String val => "_TestMetadataQueries(" + dsn + ")"

  new create(dsn': String val) => dsn = dsn'

  fun apply(h: TestHelper) =>
    var env: ODBCEnv = ODBCEnv
    try
      var dbc: ODBCDbc = env.dbc()?
      h.assert_true(dbc.connect(dsn)?)

      test_get_type_info(h, dbc)
      test_tables_query(h, dbc)
      test_columns_query(h, dbc)
      test_num_result_cols(h, dbc)
    else
      h.fail("Failed to connect or run metadata tests")
    end

  fun test_get_type_info(h: TestHelper, dbc: ODBCDbc) =>
    """Test SQLGetTypeInfo - retrieves information about supported data types"""
    try
      var stm: ODBCStmt = dbc.stmt()?

      // Get all type info (SQL_ALL_TYPES = 0)
      stm.get_type_info(0)?

      var type_name: SQLVarchar = SQLVarchar(128)
      var data_type: SQLSmallInteger = SQLSmallInteger

      // Bind some columns from the type info result set
      stm.bind_column(type_name)?  // TYPE_NAME
      stm.bind_column(data_type)?  // DATA_TYPE

      var row_count: USize = 0
      while stm.fetch()? do
        row_count = row_count + 1
        // Just verify we can read the data without errors
        if not type_name.is_null() then
          let type_name_str = type_name.read()?
          // Type name should not be empty
          h.assert_true(type_name_str.size() > 0)
        end
      end

      // Should have at least a few data types
      h.assert_true(row_count > 0)

      stm.finish()?
    else
      h.fail("test_get_type_info failed")
    end

  fun test_tables_query(h: TestHelper, dbc: ODBCDbc) =>
    """Test SQLTables - lists tables in the database"""
    try
      var stm_setup: ODBCStmt = dbc.stmt()?

      // Create some temporary tables to query
      stm_setup.direct_exec("CREATE TEMPORARY TABLE test_metadata_table1 (id INTEGER)")?
      stm_setup.direct_exec("CREATE TEMPORARY TABLE test_metadata_table2 (id INTEGER)")?

      var stm: ODBCStmt = dbc.stmt()?

      // Query all tables (empty strings = wildcard)
      stm.tables("", "", "", "")?

      var table_catalog: SQLVarchar = SQLVarchar(128)
      var table_schema: SQLVarchar = SQLVarchar(128)
      var table_name: SQLVarchar = SQLVarchar(128)
      var table_type: SQLVarchar = SQLVarchar(128)

      stm.bind_column(table_catalog)?  // TABLE_CAT
      stm.bind_column(table_schema)?   // TABLE_SCHEM
      stm.bind_column(table_name)?     // TABLE_NAME
      stm.bind_column(table_type)?     // TABLE_TYPE

      var found_count: USize = 0
      while stm.fetch()? do
        found_count = found_count + 1
        // Verify we can read table names
        if not table_name.is_null() then
          let table_name_str = table_name.read()?
          h.assert_true(table_name_str.size() > 0)
        end
      end

      // Should find at least our temporary tables
      h.assert_true(found_count > 0)

      stm.finish()?
    else
      h.fail("test_tables_query failed")
    end

  fun test_columns_query(h: TestHelper, dbc: ODBCDbc) =>
    """Test SQLColumns - lists columns in tables"""
    try
      var stm_setup: ODBCStmt = dbc.stmt()?

      // Use a regular table instead of temporary
      // Drop if exists first (ignore error)
      try stm_setup.direct_exec("DROP TABLE test_metadata_cols")? end

      stm_setup.direct_exec("CREATE TABLE test_metadata_cols (
        id INTEGER,
        name VARCHAR(100),
        value FLOAT,
        created BIGINT
      )")?

      var stm: ODBCStmt = dbc.stmt()?

      // Query columns for our table
      stm.columns("", "", "test_metadata_cols", "")?

      var column_name: SQLVarchar = SQLVarchar(128)
      var data_type: SQLSmallInteger = SQLSmallInteger
      var type_name: SQLVarchar = SQLVarchar(128)

      // Skip first 3 columns (catalog, schema, table_name)
      var skip1: SQLVarchar = SQLVarchar(128)
      var skip2: SQLVarchar = SQLVarchar(128)
      var skip3: SQLVarchar = SQLVarchar(128)

      stm.bind_column(skip1)?       // TABLE_CAT
      stm.bind_column(skip2)?       // TABLE_SCHEM
      stm.bind_column(skip3)?       // TABLE_NAME
      stm.bind_column(column_name)? // COLUMN_NAME
      stm.bind_column(data_type)?   // DATA_TYPE
      stm.bind_column(type_name)?   // TYPE_NAME

      var column_names: Array[String] = Array[String]

      while stm.fetch()? do
        if not column_name.is_null() then
          column_names.push(column_name.read()?)
        end
      end

      // We should have found 4 columns
      // Note: Some databases may return columns in different order or with different names
      h.assert_true(column_names.size() >= 4)

      stm.finish()?

      // Clean up
      stm_setup.direct_exec("DROP TABLE test_metadata_cols")?
    else
      // Try to clean up even on failure
      try
        var cleanup: ODBCStmt = dbc.stmt()?
        cleanup.direct_exec("DROP TABLE test_metadata_cols")?
      end
      h.fail("test_columns_query failed")
    end

  fun test_num_result_cols(h: TestHelper, dbc: ODBCDbc) =>
    """Test SQLNumResultCols - gets the number of columns in a result set"""
    try
      var stm: ODBCStmt = dbc.stmt()?

      // Create and populate a test table
      stm.direct_exec("CREATE TEMPORARY TABLE test_num_cols (
        col1 INTEGER,
        col2 VARCHAR(50),
        col3 FLOAT,
        col4 BIGINT,
        col5 SMALLINT
      )")?

      var id_in: SQLInteger = SQLInteger
      var str_in: SQLVarchar = SQLVarchar(50)
      var flt_in: SQLFloat = SQLFloat
      var big_in: SQLBigInteger = SQLBigInteger
      var small_in: SQLSmallInteger = SQLSmallInteger

      stm.prepare("INSERT INTO test_num_cols VALUES (?, ?, ?, ?, ?)")?
      stm.bind_parameter(id_in)?
      stm.bind_parameter(str_in)?
      stm.bind_parameter(flt_in)?
      stm.bind_parameter(big_in)?
      stm.bind_parameter(small_in)?

      id_in.write(1)
      str_in.write("test")
      flt_in.write(1.5)
      big_in.write(1000000)
      small_in.write(42)

      stm.execute()?
      stm.finish()?

      // Query and check column count
      stm.prepare("SELECT * FROM test_num_cols")?
      stm.execute()?

      var col_count: CBoxedI16 = CBoxedI16
      stm.num_result_cols(col_count)?

      // Should have 5 columns
      h.assert_eq[I16](5, col_count.value)

      stm.finish()?

      // Test with subset of columns
      stm.prepare("SELECT col1, col2 FROM test_num_cols")?
      stm.execute()?

      stm.num_result_cols(col_count)?

      // Should have 2 columns
      h.assert_eq[I16](2, col_count.value)

      stm.finish()?
    else
      h.fail("test_num_result_cols failed")
    end
