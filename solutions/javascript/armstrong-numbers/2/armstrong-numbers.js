const reducer = (acc, e, _, src) => acc + (Number(e) ** src.length);

export function validate(n) {
  return n === [...String(n)].reduce(reducer, 0);
}
