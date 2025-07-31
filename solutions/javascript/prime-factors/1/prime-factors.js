export function primeFactors(n) {
  let factors = [];
  let val = n;

  while (val % 2 === 0) {
    factors = [...factors, 2];
    val /= 2;
  }

  let factor = 3;
  while (val > 1) {
    if (val % factor === 0) {
      factors = [...factors, factor];
      val /= factor;
    } else {
      factor += 2;
    }
  }

  return factors;
}
