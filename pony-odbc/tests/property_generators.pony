use "pony_check"
use ".."

primitive PropertyGenerators
  fun finite_f32(): Generator[F32] val =>
    """
    Generate arbitrary finite F32 values via bit reinterpretation.
    Filters out NaN and Inf.
    """
    recover val
      Generators.u32().map[F32]({(bits: U32): F32 => F32.from_bits(bits)})
        .filter({(f: F32): (F32, Bool) => (f, f.finite())})
        .map[F32]({(f: F32): F32 =>
          try f.string().f32()? else F32(0) end
        })
    end

  fun finite_f64(): Generator[F64] val =>
    """
    Generate arbitrary finite F64 values via bit reinterpretation.
    Filters out NaN and Inf.
    """
    recover val
      Generators.u64().map[F64]({(bits: U64): F64 => F64.from_bits(bits)})
        .filter({(f: F64): (F64, Bool) => (f, f.finite())})
        .map[F64]({(f: F64): F64 =>
          try f.string().f64()? else F64(0) end
        })
    end
