use "collections"

trait SqlState
  fun _from_env(h: ODBCHandleEnv tag): Array[(String val, String val)] val =>
    var r: Array[(String val, String val)] trn = Array[(String val, String val)]

    for f in Range[I16](1, 1024) do
      try
        var sdf: SQLDiagFrame = SQLDiagFrame.create_penv(h, f)?
        r.push((sdf.sqlstate.clone(), sdf.msgbuff.clone()))
      else
        break
      end
    end
    consume r

  fun _from_dbc(h: ODBCHandleDbc tag): Array[(String val, String val)] val =>
    var r: Array[(String val, String val)] trn = Array[(String val, String val)]

    for f in Range[I16](1, 1024) do
      try
        var sdf: SQLDiagFrame = SQLDiagFrame.create_pdbc(h, f)?
        r.push((sdf.sqlstate.clone(), sdf.msgbuff.clone()))
      else
        break
      end
    end
    consume r

  fun _from_stmt(h: ODBCHandleStmt tag): Array[(String val, String val)] val =>
    var r: Array[(String val, String val)] trn = Array[(String val, String val)]

    for f in Range[I16](1, 1024) do
      try
        var sdf: SQLDiagFrame = SQLDiagFrame.create_pstmt(h, f)?
        r.push((sdf.sqlstate.clone(), sdf.msgbuff.clone()))
      else
        break
      end
    end
    consume r
