use @SQLEndTran[I16](HandleType: I16, Handle: Pointer[None] tag, CompletionType: I16)
//use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[Pointer[None]] tag)
use @SQLAllocHandle[I16](handletype: I16, ...) //inputhandle: Pointer[None] tag, ...) //outputhandle: Pointer[Pointer[None]] tag)
use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)

type ODBCHandle is (HandleENV | HandleDBC | HandleSTMT)
