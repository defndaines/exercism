export function validate(n) {
  const asString = String(n);
  const len = asString.length;
  return n === [...asString].reduce((acc, e) => acc + (Number(e) ** len), 0);
}
