type SqlFetchOrientation is ( SqlFetchNext | SqlFetchFirst | SqlFetchLast | SqlFetchPrior | SqlFetchAbsolute | SqlFetchRelative | SqlFetchBookmark)
  """
  # SqlFetchOrientation

  |SqlFetchOrientation|Meaning|  
  |----------------------|-------------|  
  |SqlFetchNext|Return the next rowset. This is equivalent to calling **SQLFetch**.<br /><br /> **SQLFetchScroll** ignores the value of *FetchOffset*.|  
  |SqlFetchPrior|Return the prior rowset.<br /><br /> **SQLFetchScroll** ignores the value of *FetchOffset*.|  
  |SqlFetchRelative|Return the rowset *FetchOffset* from the start of the current rowset.|  
  |SqlFetchAbsolute|Return the rowset starting at row *FetchOffset*.|  
  |SqlFetchFirst|Return the first rowset in the result set.<br /><br /> **SQLFetchScroll** ignores the value of *FetchOffset*.|  
  |SqlFetchLast|Return the last complete rowset in the result set.<br /><br /> **SQLFetchScroll** ignores the value of *FetchOffset*.|  
  |SqlFetchBookmark|Return the rowset FetchOffset rows from the bookmark specified by the SQL_ATTR_FETCH_BOOKMARK_PTR statement attribute.|  
  """

primitive \nodoc\ SqlFetchNext      fun apply(): I16 => 1
primitive \nodoc\ SqlFetchFirst     fun apply(): I16 => 2
primitive \nodoc\ SqlFetchLast      fun apply(): I16 => 3
primitive \nodoc\ SqlFetchPrior     fun apply(): I16 => 4
primitive \nodoc\ SqlFetchAbsolute  fun apply(): I16 => 5
primitive \nodoc\ SqlFetchRelative  fun apply(): I16 => 6
primitive \nodoc\ SqlFetchBookmark  fun apply(): I16 => 8
