use "../instrumentation"

type SQLReturn is (SQLSuccess |
                 SQLSuccessWithInfo |
                 SQLStillExecuting |
                 SQLError |
                 SQLInvalidHandle |
                 SQLNeedData |
                 PonyDriverError |
                 SQLNoData)



primitive SQLSuccess
  fun apply(): I16 => 0
  fun string(): String val => "SQLSuccess"

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

primitive PonyDriverError
  fun string(): String val => "SQLNoData"

