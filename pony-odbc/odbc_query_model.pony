use "env"
use "dbc"
use "stmt"
use "ctypes"
use "attributes"
use "instrumentation"


trait ODBCQueryModel
  """
  The trait you must match in order for your Query Model
  to function.
  """
  fun sql(): (String val | SQLReturn val)
    """
    Returns either your SQL Statement, or a SQLReturn.
    The SQLReturn option exists in case you wish to call any
    of the internal ODBC APIs which appear like a query.

    (This may end up not being exposed in the end)
    """

  fun ref bind_params(h: ODBCHandleStmt tag): SQLReturn val
    """
    This function is called on your model when you bind
    parameters to your query.  Since pony is statically typed
    and SQL is, umm, not... This is some of the required
    ceremony to get this to work.
    """

  fun ref bind_columns(h: ODBCHandleStmt tag): SQLReturn val
    """
    This function is called on your model when you bind
    columns to your query.  Since pony is statically typed
    and SQL is, umm, not... This is some of the required
    ceremony to get this to work.
    """

  fun ref fetch(h: ODBCHandleStmt tag): (SQLReturn val, ODBCResultOut)
    """
    This executes a fetch on your query and automatically
    populates the buffers you defined earlier.
    """

  fun ref execute[A: Any val](h: ODBCHandleStmt tag, i: A): SQLReturn val
    """
    This executes a fetch on your query and automatically
    populates the buffers you defined earlier.
    """

trait ODBCQueryParamsIn
    """
    This trait exists so your model can be passed the
    parameters to your query.  Since pony is statically typed
    and SQL is, umm, not... This is some of the required
    ceremony to get this to work.
    """

trait ODBCQueryParamsOut
    """
    This trait exists so your model can be passed the
    columns to your query.  Since pony is statically typed
    and SQL is, umm, not... This is some of the required
    ceremony to get this to work.
    """

trait ODBCResultOut
    """
    This trait exists so your model can return pony native types
    for the columns to your query.  Since pony is statically typed
    and SQL is, umm, not... This is some of the required
    ceremony to get this to work.
    """


class ODBCResultOutNull is ODBCResultOut
class ODBCQueryModelNull is ODBCQueryModel
  fun sql(): (String val | SQLReturn val) => ""
  fun ref bind_params(h: ODBCHandleStmt tag): SQLReturn val => recover val PonyDriverError("ODBCQueryModelNull.bind_params shouldn't be called" ) end
  fun ref bind_columns(h: ODBCHandleStmt tag): SQLReturn val => recover val PonyDriverError("ODBCQueryModelNull.bind_columns shouldn't be called") end
  fun ref fetch(h: ODBCHandleStmt tag): (SQLReturn val, ODBCResultOut) => (recover val PonyDriverError("ODBCQueryModelNull.fetch shouldn't be called") end, ODBCResultOutNull)
  fun ref execute[A: Any val](h: ODBCHandleStmt tag, i: A): SQLReturn val => recover val PonyDriverError("ODBCQueryModelNull.execute shouldn't be called") end
