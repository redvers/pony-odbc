use @SQLAllocHandle[I16](handletype: I16, inputhandle: Pointer[None] tag, outputhandle: Pointer[None] tag)
use @SQLFreeHandle[I16](HandleType: I16, Handle: Pointer[None] tag)
use @SQLGetData[I16](StatementHandle: Pointer[None] tag, ColumnNumber: U16, TargetType: I16, TargetValue: Pointer[None] tag, BufferLength: I64, StrLenorInd: CBoxedI64 tag)
