use "debug"
use ".."
use "../env"
use "../dbc"
use "../stmt"
use "../ctypes"
use "../attributes"
use "../instrumentation"

class \nodoc\ _PCMInI is ODBCQueryParamsIn
  var integera: SQLInteger = SQLInteger(0)

class \nodoc\ _PCMOutI is ODBCQueryParamsOut
  var integer: SQLInteger = SQLInteger(0)

class \nodoc\ _PCMResultI is ODBCResultOut
  var integer: I32 = 0

class \nodoc\ iso _TestIntegerModel is ODBCQueryModel
  var err: SQLReturn val = SQLSuccess
  var pin: _PCMInI = _PCMInI
  var pout: _PCMOutI = _PCMOutI
  var result: _PCMResultI = _PCMResultI

  fun sql(): String val => "select * from integer_tests where i >= ?"

  fun ref bind_params(h: ODBCHandleStmt tag): SQLReturn val => SQLSuccess
    err = pin.integera.bind_parameter(h, 1)
    if (not is_success()) then return err end
    err

  fun ref execute[A: Any val](h: ODBCHandleStmt tag, i: A): SQLReturn val => SQLSuccess
    match i
    | let int: I32 =>
      pin.integera.write(int)
      SQLSuccess
    else
      recover val PonyDriverError("Wrong type provided to _TestIntegerModel.execute()") end
    end


  fun ref bind_columns(h: ODBCHandleStmt tag): SQLReturn val => SQLSuccess
    err = pout.integer.bind_column(h, 1, "i")
    err

  fun ref fetch(h: ODBCHandleStmt tag): (SQLReturn val, _PCMResultI) => (SQLSuccess, _PCMResultI)
    err = ODBCStmtFFI.fetch(h)
    if (not is_success()) then return (err, result) end

    try
      result.integer = pout.integer.read()?
      (err, result)
    else
      (recover val PonyDriverError("_TestIntegerModel.fetch() did not return an I32") end, result)
    end

  fun is_success(): Bool =>
    match err
    | let x: SQLSuccess => true
    else
      false
    end
