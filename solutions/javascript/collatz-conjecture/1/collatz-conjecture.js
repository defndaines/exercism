export function steps(n) {
  if (n < 1) {
    throw new Error('Only positive numbers are allowed');
  }
  let x = n;
  let s = 0;
  while (x !== 1) {
    if (x % 2 === 0) {
      x /= 2;
      s += 1;
    } else {
      x = 3 * x + 1;
      s += 1;
    }
  }
  return s;
}
