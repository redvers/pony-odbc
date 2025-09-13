use "debug"
use "dbc"

trait DBCTrait
  fun ref get_dbc(): ODBCHandleDbc tag
  fun ref set_dbc(h: ODBCHandleDbc tag)
  fun ref get_henv(): ODBCEnv
  fun ref set_henv(henv: ODBCEnv)
  fun ref get_err(): SQLReturn val
  fun ref set_err(err: SQLReturn val)
  fun ref get_errtext(): String val
  fun ref set_errtext(txt: String val)
  fun ref get_valid(): Bool
  fun ref set_valid(valid: Bool)
  fun ref get_call_location(): SourceLoc val
  fun ref set_call_location(sl: SourceLoc val)

  fun ref get_info(i: SQLInfoTypes, sl: SourceLoc val = __loc): (SQLReturn val, String val) =>
    set_call_location(sl)
    ODBCDbcFFI.get_info(get_dbc(), i)


  fun ref set_application_name(appname: String val, sl: SourceLoc val = __loc): Bool =>
    """
    Notifies the database of your application's name. (It does not
    appear in pg_settings, is this a bug? if so where?
    """
    set_call_location(sl)
    set_err(ODBCDbcFFI.set_application_name(get_dbc(), appname))
    _set_valid(get_err())
    get_valid()

  fun ref connect(dsn: String val, sl: SourceLoc val = __loc): Bool =>
    """
    Initiates the database connection to the PostgreSQL database
    defined by the DSN.
    """
    set_call_location(sl)
    set_err(ODBCDbcFFI.connect(get_dbc(), dsn))
    _set_valid(get_err())
    get_valid()

  fun \nodoc\ ref is_valid(): Bool => get_valid()

  fun \nodoc\ ref _set_valid(sqlr: SQLReturn val): Bool =>
    match sqlr
    | let x: SQLSuccess val => set_valid(true) ; return true
    | let x: SQLSuccessWithInfo val => set_valid(true) ; return true
    | let x: SQLError val => set_error_text(x)
                             set_valid(false)
                             return false
    else
      set_valid(false) ; return false
    end

  fun \nodoc\ ref set_error_text(sqlerr: SQLError val) =>
    var errtext: String val =
      "ODBCDbc API Error:\n" +
      get_call_location().file() + ":" + get_call_location().line().string() + ": " +
      get_call_location().type_name() + "." + get_call_location().method_name() + "()\n" +
      "  " + sqlerr.get_err_strings()
      set_errtext(errtext)

