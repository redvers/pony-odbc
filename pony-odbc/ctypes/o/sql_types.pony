/*
use @SQLGetTypeInfo[I16](StatementHandle: Pointer[None] tag, DataType: I16)

class SQLTypeInfo
  var typename: CBoxedArray = CBoxedArray
  var data_type: SQLCSShort = SQLCSShort
  var column_size: SQLCSLong = SQLCSLong
  var literal_prefix: CBoxedArray = CBoxedArray
  var literal_suffix: CBoxedArray = CBoxedArray
  var create_params: CBoxedArray = CBoxedArray
  var nullable: SQLCSShort = SQLCSShort
  var case_sensitive: SQLCSShort = SQLCSShort
  var searchable: SQLCSShort = SQLCSShort
  var unsigned_attribute: SQLCSShort = SQLCSShort
  var fixed_prec_scale: SQLCSShort = SQLCSShort
  var auto_unique_value: SQLCSShort = SQLCSShort
  var local_type_name: CBoxedArray = CBoxedArray
  var minimum_scale: SQLCSShort = SQLCSShort
  var maximum_scale: SQLCSShort = SQLCSShort
  var sql_data_type: SQLCSShort = SQLCSShort
  var sql_datetime_sub: SQLCSShort = SQLCSShort
  var num_prec_radix: SQLCSLong = SQLCSLong
  var interval_precision: SQLCSShort = SQLCSShort
*/

/*
primitive SQLNullData
  fun apply(): I64 => -1


trait SQLPrimitiveType
  fun resolve(id: I16): SQLPrimitiveType val =>
    match id
    | 0 => SQLUnknownType
    | 1 => SQLChar
    | 2 => SQLNumeric
    | 3 => SQLDecimal
    | 4 => SQLInteger
    | 5 => SQLSmallInt
    | 6 => SQLFloat
    | 7 => SQLReal
    | 8 => SQLDouble
    | 9 => SQLDateTime
    |12 => SQLVarChar
    else
      SQLUnknownType
    end

  fun apply(): I16

primitive SQLUnknownType   is SQLPrimitiveType fun apply(): I16 => 0
primitive SQLChar          is SQLPrimitiveType fun apply(): I16 => 1 /* fixed len string */
primitive SQLNumeric       is SQLPrimitiveType fun apply(): I16 => 2 /* f64? */
primitive SQLDecimal       is SQLPrimitiveType fun apply(): I16 => 3 /* signed, exact, numeric, precision */
primitive SQLInteger       is SQLPrimitiveType fun apply(): I16 => 4 /* I32 */
primitive SQLSmallInt      is SQLPrimitiveType fun apply(): I16 => 5 /* I16 */
primitive SQLFloat         is SQLPrimitiveType fun apply(): I16 => 6 /* F32 */
primitive SQLReal          is SQLPrimitiveType fun apply(): I16 => 7 /* F64 */
primitive SQLDouble        is SQLPrimitiveType fun apply(): I16 => 8 /* F64 */
primitive SQLDateTime      is SQLPrimitiveType fun apply(): I16 => 9
primitive SQLVarChar       is SQLPrimitiveType fun apply(): I16 => 12

primitive SQLDate          is SQLPrimitiveType fun apply(): I16 => 9
primitive SQLInterval      is SQLPrimitiveType fun apply(): I16 => 10
primitive SQLTime          is SQLPrimitiveType fun apply(): I16 => 10
primitive SQLTimestamp     is SQLPrimitiveType fun apply(): I16 => 11
primitive SQLLongVarChar   is SQLPrimitiveType fun apply(): I16 => (-1)
primitive SQLBinary        is SQLPrimitiveType fun apply(): I16 => (-2)
primitive SQLVarBinary     is SQLPrimitiveType fun apply(): I16 => (-3)
primitive SQLLongVarBinary is SQLPrimitiveType fun apply(): I16 => (-4)
primitive SQLBigInt        is SQLPrimitiveType fun apply(): I16 => (-5)
primitive SQLTinyInt       is SQLPrimitiveType fun apply(): I16 => (-6)
primitive SQLBit           is SQLPrimitiveType fun apply(): I16 => (-7)
primitive SQLGuid          is SQLPrimitiveType fun apply(): I16 =>  (-11)

primitive SQLSignedOffset                      fun apply(): I16 => -20
primitive SQLUnsignedOffset                    fun apply(): I16 => -22

/*
 * #define SQL_C_CHAR    SQL_CHAR             /* CHAR, VARCHAR, DECIMAL, NUMERIC */
 * #define SQL_C_LONG    SQL_INTEGER          /* INTEGER                      */
 * #define SQL_C_SHORT   SQL_SMALLINT         /* SMALLINT                     */
 * #define SQL_C_FLOAT   SQL_REAL             /* REAL                         */
 * #define SQL_C_DOUBLE  SQL_DOUBLE           /* FLOAT, DOUBLE                */
 * #define SQL_C_NUMERIC   SQL_NUMERIC
 * #define SQL_C_DEFAULT 99
 *
 * #define SQL_C_SLONG      (SQL_C_LONG+SQL_SIGNED_OFFSET)    /* SIGNED INTEGER  */
 * #define SQL_C_SSHORT     (SQL_C_SHORT+SQL_SIGNED_OFFSET)   /* SIGNED SMALLINT */
 * #define SQL_C_STINYINT   (SQL_TINYINT+SQL_SIGNED_OFFSET)   /* SIGNED TINYINT  */
 * #define SQL_C_ULONG      (SQL_C_LONG+SQL_UNSIGNED_OFFSET)  /* UNSIGNED INTEGER*/
 * #define SQL_C_USHORT     (SQL_C_SHORT+SQL_UNSIGNED_OFFSET) /* UNSIGNED SMALLINT*/
 * #define SQL_C_UTINYINT   (SQL_TINYINT+SQL_UNSIGNED_OFFSET) /* UNSIGNED TINYINT*/
 */
*/
