type SQLReturn is (SQLSuccess |
                 SQLSuccessWithInfo |
                 SQLStillExecuting |
                 SQLError |
                 SQLInvalidHandle |
                 SQLNeedData |
                 SQLNoData)



primitive SQLSuccess
  fun apply(): I16 => 0
  fun string(): String val => "SQLSuccess"

primitive SQLSuccessWithInfo
  fun apply(): I16 => 1
  fun string(): String val => "SQLSuccessWithInfo"

primitive SQLStillExecuting
  fun apply(): I16 => 2
  fun string(): String val => "SQLStillExecuting"

primitive SQLInvalidHandle
  fun apply(): I16 => -2
  fun string(): String val => "SQLInvalidHandle"

primitive SQLNeedData
  fun apply(): I16 => 99
  fun string(): String val => "SQLNeedData"

primitive SQLNoData
  fun apply(): I16 => 100
  fun string(): String val => "SQLNoData"


