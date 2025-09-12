type SqlFetchOrientation is (
    SqlFetchNext
  | SqlFetchFirst
  | SqlFetchLast
  | SqlFetchPrior
  | SqlFetchAbsolute
  | SqlFetchRelative
  | SqlFetchBookmark
)

primitive SqlFetchNext      fun apply(): I16 => 1
primitive SqlFetchFirst     fun apply(): I16 => 2
primitive SqlFetchLast      fun apply(): I16 => 3
primitive SqlFetchPrior     fun apply(): I16 => 4
primitive SqlFetchAbsolute  fun apply(): I16 => 5
primitive SqlFetchRelative  fun apply(): I16 => 6
primitive SqlFetchBookmark  fun apply(): I16 => 8
