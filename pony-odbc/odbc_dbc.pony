use "debug"
use "dbc"

class ODBCDbc is DBCTrait
  var _dbc: ODBCHandleDbc tag
  var _henv: ODBCEnv
  var _err: SQLReturn val
  var _valid: Bool = true
  var _errtext: String val = ""
  var _call_location: SourceLoc val = __loc

  fun ref get_dbc(): ODBCHandleDbc tag => _dbc
  fun ref set_dbc(h: ODBCHandleDbc tag) => _dbc = h
  fun ref get_henv(): ODBCEnv => _henv
  fun ref set_henv(henv: ODBCEnv) => _henv = henv
  fun ref get_err(): SQLReturn val => _err
  fun ref set_err(err: SQLReturn val) => _err = err
  fun ref get_errtext(): String val => _errtext
  fun ref set_errtext(txt: String val) => _errtext = txt
  fun ref get_valid(): Bool => _valid
  fun ref set_valid(valid: Bool) => _valid = valid
  fun ref get_call_location(): SourceLoc val => _call_location
  fun ref set_call_location(sl: SourceLoc val) => _call_location = sl

  new create(henv': ODBCEnv = ODBCEnv.>set_odbc3(), sl: SourceLoc val = __loc) =>
    """
    Creates a new ODBC Database Object.
    """
    _henv = henv'
    _call_location = sl

    (_err, _dbc) = ODBCDbcFFI.alloc(_henv.odbcenv)
    _set_valid(_err)

  fun _final() =>
    ODBCDbcFFI.free(_dbc)

