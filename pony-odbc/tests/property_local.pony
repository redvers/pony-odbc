use "pony_check"
use "pony_test"
use ".."
use "collections"

class \nodoc\ iso _PropertySQLTypeRoundtrip is UnitTest
  fun name(): String val => "_PropertySQLTypeRoundtrip"

  fun apply(h: TestHelper) ? =>
    // I16 roundtrip
    PonyCheck.for_all[I16](recover Generators.i16() end, h)(
      {(sample: I16, ph: PropertyHelper) ? =>
        var si = SQLSmallInteger
        ph.assert_true(si.write(sample))
        ph.assert_eq[I16](sample, si.read()?)
      })?

    // I32 roundtrip
    PonyCheck.for_all[I32](recover Generators.i32() end, h)(
      {(sample: I32, ph: PropertyHelper) ? =>
        var si = SQLInteger
        ph.assert_true(si.write(sample))
        ph.assert_eq[I32](sample, si.read()?)
      })?

    // I64 roundtrip
    PonyCheck.for_all[I64](recover Generators.i64() end, h)(
      {(sample: I64, ph: PropertyHelper) ? =>
        var bi = SQLBigInteger
        ph.assert_true(bi.write(sample))
        ph.assert_eq[I64](sample, bi.read()?)
      })?

    // F32 roundtrip
    PonyCheck.for_all[F32](PropertyGenerators.finite_f32(), h)(
      {(sample: F32, ph: PropertyHelper) ? =>
        var sf = SQLFloat
        ph.assert_true(sf.write(sample))
        ph.assert_eq[F32](sample, sf.read()?)
      })?

    // F64 roundtrip
    PonyCheck.for_all[F64](PropertyGenerators.finite_f64(), h)(
      {(sample: F64, ph: PropertyHelper) ? =>
        var sr = SQLReal
        ph.assert_true(sr.write(sample))
        ph.assert_eq[F64](sample, sr.read()?)
      })?

    // String roundtrip
    PonyCheck.for_all[String](recover Generators.ascii_printable(0, 127) end, h)(
      {(sample: String, ph: PropertyHelper) ? =>
        var sv = SQLVarchar(128)
        ph.assert_true(sv.write(sample))
        ph.assert_eq[String val](sample, sv.read()?)
      })?


class \nodoc\ iso _PropertySQLTypeNulls is UnitTest
  fun name(): String val => "_PropertySQLTypeNulls"

  fun apply(h: TestHelper) ? =>
    PonyCheck.for_all[I16](recover Generators.i16() end, h)(
      {(sample: I16, ph: PropertyHelper) =>
        // SQLSmallInteger: new -> null, write -> not null, null() -> null
        var ssi = SQLSmallInteger
        ph.assert_true(ssi.is_null(), "new SQLSmallInteger should be null")
        ssi.write(sample)
        ph.assert_false(ssi.is_null(), "after write should not be null")
        ssi.null()
        ph.assert_true(ssi.is_null(), "after null() should be null")

        // SQLInteger: new -> null, write -> not null, reset() -> null
        var si = SQLInteger
        ph.assert_true(si.is_null())
        si.write(sample.i32())
        ph.assert_false(si.is_null())
        si.reset()
        ph.assert_true(si.is_null(), "after reset() should be null")

        // SQLBigInteger
        var bi = SQLBigInteger
        ph.assert_true(bi.is_null())
        bi.write(sample.i64())
        ph.assert_false(bi.is_null())
        bi.null()
        ph.assert_true(bi.is_null())

        // SQLFloat
        var sf = SQLFloat
        ph.assert_true(sf.is_null())
        sf.write(sample.f32())
        ph.assert_false(sf.is_null())
        sf.reset()
        ph.assert_true(sf.is_null())

        // SQLReal
        var sr = SQLReal
        ph.assert_true(sr.is_null())
        sr.write(sample.f64())
        ph.assert_false(sr.is_null())
        sr.null()
        ph.assert_true(sr.is_null())

        // SQLVarchar
        var sv = SQLVarchar(128)
        ph.assert_true(sv.is_null())
        sv.write(sample.string())
        ph.assert_false(sv.is_null())
        sv.reset()
        ph.assert_true(sv.is_null())
      })?


class \nodoc\ iso _PropertyCBoxedArray is UnitTest
  fun name(): String val => "_PropertyCBoxedArray"

  fun apply(h: TestHelper) ? =>
    // String write/read roundtrip
    PonyCheck.for_all[String](recover Generators.ascii_printable(0, 50) end, h)(
      {(sample: String, ph: PropertyHelper) ? =>
        var ba = CBoxedArray
        ba.alloc(64)
        ph.assert_true(ba.write(sample))
        ph.assert_false(ba.is_null())
        ph.assert_eq[String val](sample, ba.string()?)
      })?

    // Oversized string rejected, buffer stays null
    PonyCheck.for_all[String](recover Generators.ascii_printable(11, 50) end, h)(
      {(sample: String, ph: PropertyHelper) =>
        var ba = CBoxedArray
        ba.alloc(10)
        ph.assert_false(ba.write(sample), "oversized write should return false")
        ph.assert_true(ba.is_null(), "buffer should remain null after rejected write")
      })?

    // Null lifecycle: fresh->null, write->non-null, null()->null, write->non-null, reset()->null
    PonyCheck.for_all[String](recover Generators.ascii_printable(1, 30) end, h)(
      {(sample: String, ph: PropertyHelper) =>
        var ba = CBoxedArray
        ba.alloc(64)
        ph.assert_true(ba.is_null(), "fresh alloc should be null")
        ba.write(sample)
        ph.assert_false(ba.is_null(), "after write should not be null")
        ba.null()
        ph.assert_true(ba.is_null(), "after null() should be null")
        ba.write(sample)
        ph.assert_false(ba.is_null(), "after second write should not be null")
        ba.reset()
        ph.assert_true(ba.is_null(), "after reset() should be null")
      })?

    // Double alloc fails
    PonyCheck.for_all[USize](recover Generators.usize(1, 100) end, h)(
      {(size: USize, ph: PropertyHelper) =>
        var ba = CBoxedArray
        ph.assert_true(ba.alloc(size), "first alloc should succeed")
        ph.assert_false(ba.alloc(size), "second alloc should fail")
      })?


class \nodoc\ iso _PropertyErrorChain is UnitTest
  fun name(): String val => "_PropertyErrorChain"

  fun apply(h: TestHelper) ? =>
    // Size tracks pushes
    PonyCheck.for_all[USize](recover Generators.usize(1, 50) end, h)(
      {(n: USize, ph: PropertyHelper) =>
        let chain = ODBCErrorChain
        for i in Range(0, n) do
          let frame = ODBCErrorFrame("op", __loc, SQLError,
            recover val Array[(String val, String val)] end, i)
          chain.push(frame)
        end
        ph.assert_eq[USize](n, chain.size())
      })?

    // Eviction is oldest-first when at capacity
    PonyCheck.for_all[USize](recover Generators.usize(3, 20) end, h)(
      {(max: USize, ph: PropertyHelper) =>
        let chain = ODBCErrorChain
        chain.set_max_frames(max)
        let total = max + 10
        for i in Range(0, total) do
          let frame = ODBCErrorFrame("op", __loc, SQLError,
            recover val Array[(String val, String val)] end, i)
          chain.push(frame)
        end
        ph.assert_eq[USize](max, chain.size())
        match chain.first()
        | let f: ODBCErrorFrame val =>
          ph.assert_eq[USize](10, f.sequence,
            "oldest surviving should be sequence 10")
        else
          ph.fail("first() should not be None")
        end
        match chain.last()
        | let f: ODBCErrorFrame val =>
          ph.assert_eq[USize](total - 1, f.sequence,
            "last should be most recently pushed")
        else
          ph.fail("last() should not be None")
        end
      })?

    // Sequence counter is monotonically increasing
    PonyCheck.for_all[USize](recover Generators.usize(2, 50) end, h)(
      {(n: USize, ph: PropertyHelper) =>
        let chain = ODBCErrorChain
        var prev = chain.next_sequence()
        for _ in Range(1, n) do
          let curr = chain.next_sequence()
          ph.assert_true(curr > prev, "sequence must be monotonically increasing")
          prev = curr
        end
      })?

    // Clear empties chain but preserves sequence counter
    PonyCheck.for_all[USize](recover Generators.usize(1, 20) end, h)(
      {(n: USize, ph: PropertyHelper) =>
        let chain = ODBCErrorChain
        for i in Range(0, n) do
          let frame = ODBCErrorFrame("op", __loc, SQLError,
            recover val Array[(String val, String val)] end,
            chain.next_sequence())
          chain.push(frame)
        end
        let seq_before = chain.current_sequence()
        chain.clear()
        ph.assert_eq[USize](0, chain.size(), "clear should empty chain")
        ph.assert_eq[USize](seq_before, chain.current_sequence(),
          "clear should preserve sequence counter")
      })?

    // set_max_frames reduction evicts oldest frames
    PonyCheck.for_all[USize](recover Generators.usize(6, 30) end, h)(
      {(n: USize, ph: PropertyHelper) =>
        let chain = ODBCErrorChain
        for i in Range(0, n) do
          let frame = ODBCErrorFrame("op", __loc, SQLError,
            recover val Array[(String val, String val)] end, i)
          chain.push(frame)
        end
        let keep = n / 2
        chain.set_max_frames(keep)
        ph.assert_eq[USize](keep, chain.size())
        match chain.first()
        | let f: ODBCErrorFrame val =>
          ph.assert_eq[USize](n - keep, f.sequence,
            "oldest surviving should be (n - keep)")
        else
          ph.fail("first() should not be None after reduction")
        end
      })?

    // errors_only filters out success frames
    PonyCheck.for_all[USize](recover Generators.usize(2, 20) end, h)(
      {(n: USize, ph: PropertyHelper) =>
        let chain = ODBCErrorChain
        var error_count: USize = 0
        for i in Range(0, n) do
          let is_success = (i % 2) == 0
          if not is_success then error_count = error_count + 1 end
          let frame = ODBCErrorFrame("op", __loc, SQLError,
            recover val Array[(String val, String val)] end, i,
            None, "stmt", is_success)
          chain.push(frame)
        end
        ph.assert_eq[USize](error_count, chain.errors_only().size())
      })?


class \nodoc\ iso _PropertyErrorFrame is UnitTest
  fun name(): String val => "_PropertyErrorFrame"

  fun apply(h: TestHelper) ? =>
    // Ordering: lower sequence < higher sequence, equal sequence == equal
    PonyCheck.for_all2[USize, USize](
      recover Generators.usize(0, 1000) end,
      recover Generators.usize(0, 1000) end, h)(
      {(a: USize, b: USize, ph: PropertyHelper) =>
        let frame_a = ODBCErrorFrame("op", __loc, SQLError,
          recover val Array[(String val, String val)] end, a)
        let frame_b = ODBCErrorFrame("op", __loc, SQLError,
          recover val Array[(String val, String val)] end, b)
        if a < b then
          ph.assert_true(frame_a < frame_b)
          ph.assert_false(frame_a == frame_b)
        elseif a == b then
          ph.assert_true(frame_a == frame_b)
          ph.assert_false(frame_a < frame_b)
        else
          ph.assert_true(frame_b < frame_a)
          ph.assert_false(frame_a == frame_b)
        end
      })?

    // sqlstate and message with/without diagnostics
    PonyCheck.for_all[Bool](recover Generators.bool() end, h)(
      {(has_diags: Bool, ph: PropertyHelper) =>
        if has_diags then
          let diags = recover val
            let d = Array[(String val, String val)]
            d.push(("42S02", "Table not found"))
            d
          end
          let frame = ODBCErrorFrame("op", __loc, SQLError, diags, 0)
          ph.assert_eq[String val]("42S02", frame.sqlstate())
          ph.assert_eq[String val]("Table not found", frame.message())
        else
          let frame = ODBCErrorFrame("op", __loc, SQLError,
            recover val Array[(String val, String val)] end, 0)
          ph.assert_eq[String val]("", frame.sqlstate())
          ph.assert_eq[String val]("SQLError", frame.message())
        end
      })?

    // Success frame string contains "OK", handle_type, and operation
    PonyCheck.for_all[USize](recover Generators.usize(0, 100) end, h)(
      {(seq: USize, ph: PropertyHelper) =>
        let frame = ODBCErrorFrame("test_op", __loc, SQLSuccess,
          recover val Array[(String val, String val)] end, seq,
          None, "stmt", true)
        ph.assert_true(frame.string().contains("OK"),
          "success frame string should contain OK")
        ph.assert_true(frame.string().contains("stmt"),
          "frame string should contain handle type")
        ph.assert_true(frame.string().contains("test_op"),
          "frame string should contain operation")
      })?

    // Error frame string contains handle_type, operation, and SQLSTATE
    PonyCheck.for_all[USize](recover Generators.usize(0, 100) end, h)(
      {(seq: USize, ph: PropertyHelper) =>
        let diags = recover val
          let d = Array[(String val, String val)]
          d.push(("HY000", "General error"))
          d
        end
        let frame = ODBCErrorFrame("execute", __loc, SQLError,
          diags, seq, None, "dbc")
        let s = frame.string()
        ph.assert_true(s.contains("dbc"),
          "error string should contain handle type")
        ph.assert_true(s.contains("execute"),
          "error string should contain operation")
        ph.assert_true(s.contains("HY000"),
          "error string should contain SQLSTATE")
      })?
