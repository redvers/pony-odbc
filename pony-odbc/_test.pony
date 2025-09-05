use "debug"
use "pony_test"

actor \nodoc\ Main is TestList
  let env: Env

  new create(env': Env) =>
    env = env'
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    test(_TestPostgreSQL)



class \nodoc\ iso _TestPostgreSQL is UnitTest
  fun name(): String val => "_TestPostgreSQL"

  fun apply(h: TestHelper) =>
    h.assert_true(true)
/*
    var henv: HandleENV = HandleENV.create()?
                          .>set_odbc3()?

    var hdbc: HandleDBC = HandleDBC.create(henv)?
                          .>set_application_name("_TestPostgreSQL")?
                          .>connect("psqlred")?
                          .>get_commit_mode()

    var sqltypeinfo: SQLTypeInfo = SQLTypeInfo
    var stmt: HandleSTMT = HandleSTMT.create_type_info(hdbc, sqltypeinfo, -5)?

    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_string(1,  sqltypeinfo.typename)) /* varchar */
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(2,     sqltypeinfo.data_type))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i32(3,     sqltypeinfo.column_size))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_string(4,  sqltypeinfo.literal_prefix))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_string(5,  sqltypeinfo.literal_suffix))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_string(6,  sqltypeinfo.create_params))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(7,     sqltypeinfo.nullable))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(8,     sqltypeinfo.case_sensitive))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(9,     sqltypeinfo.searchable))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(10,    sqltypeinfo.unsigned_attribute))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(11,    sqltypeinfo.fixed_prec_scale))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(12,    sqltypeinfo.auto_unique_value))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_string(13, sqltypeinfo.local_type_name))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(14,    sqltypeinfo.minimum_scale))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(15,    sqltypeinfo.maximum_scale))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(16,    sqltypeinfo.sql_data_type))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(17,    sqltypeinfo.sql_datetime_sub))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i32(18,    sqltypeinfo.num_prec_radix))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(19,    sqltypeinfo.interval_precision))

    let res: SQLReturn = stmt.fetch()
    match res
    | let x: SQLSuccess => Debug.out("Response: SQLSuccess")
    | let x: SQLSuccessWithInfo =>
          Debug.out("SQLSuccessWithInfo: " + x.records.size().string() + " record(s)")
          for (i, str) in x.records.values() do
            Debug.out(i.string() + ": " + str.msgbuff)
          end
    | let x: SQLStillExecuting => h.fail("Response: SQLStillExecuting")
    | let x: SQLError => h.fail("Response: SQLError")
    | let x: SQLInvalidHandle => h.fail("Response: SQLInvalidHandle")
    | let x: SQLNeedData => h.fail("Response: SQLNeedData")
    | let x: SQLNoData => h.fail("Response: SQLNoData")
    end

    match sqltypeinfo.typename.string_or_null()?
    | let x: SQLNullData => Debug.out("typename: NULL")
    | let x: String val => Debug.out("typename: " + x)
    end
//    Debug.out("typename size: " +      sqltypeinfo.typename.writtensize.string())
    Debug.out("data_type: " +          sqltypeinfo.data_type.value.string())
    Debug.out("column_size: " +        sqltypeinfo.column_size.value.string())
//    Debug.out("literal_prefix: " +     sqltypeinfo.literal_prefix.string()?)
//    Debug.out("literal_suffix: " +     sqltypeinfo.literal_suffix)
//    Debug.out("create_params: " +      sqltypeinfo.create_params)
    Debug.out("nullable: " +           sqltypeinfo.nullable.value.string())
    Debug.out("case_sensitive: " +     sqltypeinfo.case_sensitive.value.string())
    Debug.out("searchable: " +         sqltypeinfo.searchable.value.string())
    Debug.out("unsigned_attribute: " + sqltypeinfo.unsigned_attribute.value.string())
    Debug.out("fixed_prec_scale: " +   sqltypeinfo.fixed_prec_scale.value.string())
    Debug.out("auto_unique_value: " +  sqltypeinfo.auto_unique_value.value.string())
//    Debug.out("local_type_name: " +    sqltypeinfo.local_type_name)
    Debug.out("minimum_scale: " +      sqltypeinfo.minimum_scale.value.string())
    Debug.out("maximum_scale: " +      sqltypeinfo.maximum_scale.value.string())
    Debug.out("sql_data_type: " +      sqltypeinfo.sql_data_type.value.string())
    Debug.out("sql_datetime_sub: " +   sqltypeinfo.sql_datetime_sub.value.string())
    Debug.out("num_prec_radix: " +     sqltypeinfo.num_prec_radix.value.string())
    Debug.out("interval_precision: " + sqltypeinfo.interval_precision.value.string())
    Debug.out("\n")

    stmt.dispose()
    h.assert_is[SQLReturn](SQLInvalidHandle, stmt.num_result_cols())


    stmt = HandleSTMT.create(hdbc)?

    h.assert_is[SQLReturn](SQLSuccess, stmt.prepare("drop table if exists numerictable"))
    match stmt.execute()
    | let x: SQLSuccess => h.assert_true(true)
    | let x: SQLSuccessWithInfo => h.assert_true(true)
    else
      h.fail()
    end

    stmt = HandleSTMT.create(hdbc)?
    h.assert_is[SQLReturn](SQLSuccess, stmt.prepare(PostgreSQL.numerictable()))
    h.assert_is[SQLReturn](SQLSuccess, stmt.execute())

    stmt = HandleSTMT.create(hdbc)?
    h.assert_is[SQLReturn](SQLSuccess, stmt.prepare(PostgreSQL.numerictable_alter()))
    h.assert_is[SQLReturn](SQLSuccess, stmt.execute())

    stmt = HandleSTMT.create(hdbc)?
    h.assert_is[SQLReturn](SQLSuccess, stmt.prepare(PostgreSQL.numerictable_insert_direct()))
    h.assert_is[SQLReturn](SQLSuccess, stmt.execute())

    stmt = HandleSTMT.create(hdbc)?
    h.assert_is[SQLReturn](SQLSuccess, stmt.prepare(PostgreSQL.numerictable_select_star()))
    h.assert_is[SQLReturn](SQLSuccess, stmt.execute())
    h.assert_is[SQLReturn](SQLSuccess, stmt.num_result_cols())
    h.assert_eq[I16](10, stmt.numresultcols)

    /* Check the names of the columns are correct */
    h.assert_eq[String box]("id", SQLColumn(stmt, 1)?.columnname)
    h.assert_eq[String box]("integerfield", SQLColumn(stmt, 2)?.columnname)
    h.assert_eq[String box]("smallintegerfield", SQLColumn(stmt, 3)?.columnname)
    h.assert_eq[String box]("bigintegerfield", SQLColumn(stmt, 4)?.columnname)
    h.assert_eq[String box]("decimalfield", SQLColumn(stmt, 5)?.columnname)
    h.assert_eq[String box]("serialfield", SQLColumn(stmt, 6)?.columnname)
    h.assert_eq[String box]("smallserialfield", SQLColumn(stmt, 7)?.columnname)
    h.assert_eq[String box]("bigserialfield", SQLColumn(stmt, 8)?.columnname)
    h.assert_eq[String box]("bigint", SQLColumn(stmt, 9)?.columnname)
    h.assert_eq[String box]("singleprecisionfield", SQLColumn(stmt, 10)?.columnname)

    h.assert_true(true)

    /* The binding of the columns */
    var id: SQLCSBigInt = SQLCSBigInt
    var integerfield: SQLCSLong = SQLCSLong
    var smallintegerfield: SQLCSShort = SQLCSShort
    var bigintegerfield: SQLCSBigInt = SQLCSBigInt
    var decimalfield: SQLCFloat = SQLCFloat
    var serialfield: SQLCSLong = SQLCSLong
    var smallserialfield: SQLCSShort = SQLCSShort
    var bigserialfield: SQLCSBigInt = SQLCSBigInt
    var bigint: SQLCSBigInt = SQLCSBigInt
    var singleprecisionfield: SQLCFloat = SQLCFloat
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i64(1,  id))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i32(2,  integerfield))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(3,  smallintegerfield))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i64(4,  bigintegerfield))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_f32(5,  decimalfield))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i32(6,  serialfield))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i16(7,  smallserialfield))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i64(8,  bigserialfield))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_i64(9,  bigint))
    h.assert_is[SQLReturn](SQLSuccess, stmt.bind_col_f32(10, singleprecisionfield))

    /* Fetch the data */
    h.assert_is[SQLReturn](SQLSuccess, stmt.fetch())
    h.assert_eq[I64](1, id.value)
    h.assert_eq[I32](10, integerfield.value)
    h.assert_eq[I16](20, smallintegerfield.value)
    h.assert_eq[I64](30, bigintegerfield.value)
    h.assert_eq[F32](40, decimalfield.value)
    h.assert_eq[I32](1, serialfield.value)
    h.assert_eq[I16](1, smallserialfield.value)
    h.assert_eq[I64](1, bigserialfield.value)
    h.assert_eq[I64](50, bigint.value)
    h.assert_eq[F32](60.9, singleprecisionfield.value)

    h.assert_is[SQLReturn](SQLSuccess, stmt.fetch())
    h.assert_eq[I64](2, id.value)
    h.assert_eq[I32](-10, integerfield.value)
    h.assert_eq[I16](-20, smallintegerfield.value)
    h.assert_eq[I64](-30, bigintegerfield.value)
    h.assert_eq[F32](-40, decimalfield.value)
    h.assert_eq[I32](2, serialfield.value)
    h.assert_eq[I16](2, smallserialfield.value)
    h.assert_eq[I64](2, bigserialfield.value)
    h.assert_eq[I64](-50, bigint.value)
    h.assert_eq[F32](-60.9, singleprecisionfield.value)

    h.assert_is[SQLReturn](SQLNoData, stmt.fetch())



primitive PostgreSQL
  fun numerictable(): String val =>
    """
    CREATE TABLE numerictable (
      id BIGSERIAL,
      integerfield INTEGER,
      smallintegerfield SMALLINT,
      bigintegerfield BIGINT,
      decimalfield DECIMAL,
      serialfield SERIAL,
      smallserialfield SMALLSERIAL,
      bigserialfield BIGSERIAL,
      bigint BIGINT,
      singleprecisionfield FLOAT
   );
   """

  fun numerictable_alter(): String val =>
    """
    ALTER TABLE numerictable ADD CONSTRAINT numerictable_pkey PRIMARY KEY (id);
    """
  fun numerictable_insert_direct(): String val =>
    """
    insert into numerictable (integerfield, smallintegerfield, bigintegerfield, decimalfield, bigint, singleprecisionfield) values (10,20,30,40,50,60.9);
    insert into numerictable (integerfield, smallintegerfield, bigintegerfield, decimalfield, bigint, singleprecisionfield) values (-10,-20,-30,-40,-50,-60.9);
    """

  fun numerictable_select_star(): String val =>
    """
    select * from numerictable;
    """

  fun numerictable_select_prepare(): String val =>
    """
    select * from numerictable where id = ?;
    """
    */
