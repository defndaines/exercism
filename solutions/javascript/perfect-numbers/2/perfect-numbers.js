const allFactors = (n) => {
  let factors = [];
  Array.from({ length: n / 2 + 1 },
    (_, i) => {
      if (n % i === 0) {
        factors = [...factors, i];
      }
    });
  return factors;
};

export function classify(n) {
  if (n <= 0) {
    throw new Error('Classification is only possible for natural numbers.');
  }
  const sum = allFactors(n).reduce((a, b) => a + b, 0);
  if (n === sum) {
    return 'perfect';
  }
  if (n < sum) {
    return 'abundant';
  }
  return 'deficient';
}
