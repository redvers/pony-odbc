use "pony_check"
use ".."

primitive PropertyGenerators
  fun finite_f32(): Generator[F32] val =>
    """
    Generate F32 values from I16 range for exact binary representation
    and guaranteed fit in SQLFloat's 20-byte buffer when stringified.
    """
    recover val
      Generators.i16().map[F32]({(i: I16): F32^ => i.f32()})
    end

  fun finite_f64(): Generator[F64] val =>
    """
    Generate F64 values from a constrained I32 range for exact roundtrip
    through F64.string(). Values are limited to 6 significant digits
    so that the default %g format preserves them exactly.
    """
    recover val
      Generators.i32(-999999, 999999).map[F64]({(i: I32): F64^ => i.f64()})
    end
