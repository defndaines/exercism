export function compute(left, right) {
  if (left.length !== right.length) {
    throw new Error('left and right strands must be of equal length');
  }
  return [...left]
    .map((e, i) => (e === right[i] ? 0 : 1))
    .reduce((a, b) => a + b, 0);
}
