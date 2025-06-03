/*
use "debug"
use "lib:iodbc"

use @printf[I32](fmt: Pointer[U8] tag, ...)
use @SQLGetInfo[I16](hdbc: Pointer[None] tag, infotype: U16, driverInfo: Pointer[U8] tag, buflen: I16, stringlen: Pointer[I16] tag)
use @SQLDataSources[I16](henv: Pointer[None] tag, direction: U16, servername: Pointer[U8] tag, bufflen1: I16, namelen1: Pointer[I16] tag, description: Pointer[U8] tag, bufflen2: I16, namelen2: Pointer[I16] tag)


class ODBC
  var henv: HandleEnv
  var hdbc: HandleDBC
  new create(connStr: String val) ? =>
    henv = HandleEnv.create()?
           .>set_odbc3()?

    hdbc = HandleDBC.create(henv)?
           .>set_application_name("odbctest")?
           .>connect("mysqlitedb")?

//    var stringlen: I16 = 0
//    if (@SQLGetInfo(hdbc, 171, driverInfo.cstring(), driverInfo.space().i16(), addressof stringlen) != SQLEnum.success()) then error end
//    driverInfo.recalc()
//    Debug.out("Driver Manager: " + driverInfo)

//  fun ref datasources() =>
//    var sn: String ref = ".".repeat_str(32, "")
//    var snlen: I16 = 0
//    var desc: String ref = ".".repeat_str(255, "")
//    var desclen: I16 = 0
//
//    @SQLDataSources[I16](henv, SQLEnum.sql_fetch_first(),
//                         sn.cstring(), sn.size().i16(), addressof snlen,
//                         desc.cstring(), desc.size().i16(), addressof desclen)
//    sn.recalc()
//    desc.recalc()
//
//    Debug.out(sn)
//    Debug.out(desc)






*/

primitive SQLEnum
  fun success(): I16           => 0
//  fun success_with_info(): I16 => 1
//  fun still_executing(): I16   => 2
//  fun err(): I16               => -1
//  fun invalid_handle(): I16    => -2
//  fun need_data(): I16         => 99
//  fun no_data(): I16           => 100

  fun handle_env():  I16  => 1
  fun handle_dbc():  I16  => 2
  fun handle_stmt(): I16  => 3
  fun handle_desc(): I16  => 4

  fun attr_odbc_version(): I32 => 200

//  fun ov_odbc2(): I32 => 2
  fun ov_odbc3(): I32 => 3

//  fun is_pointer(): I32  => -4
//  fun is_uinteger(): I32  => -5
  fun is_integer(): I32  => -6
//  fun is_usmallint(): I32  => -7
//  fun is_smallint(): I32  => -8

  fun sql_application_name(): U16 => 1051

  fun sql_fetch_next(): U16 => 1
  fun sql_fetch_first(): U16 => 2

  fun sql_commit(): I16 => 0
  fun sql_rollback(): I16 => 1

