export function isPangram(phrase) {
  return phrase
    .toLocaleLowerCase()
    .split('')
    .sort()
    .reduce((acc, e) => (/[^a-z]/.test(e) || acc.includes(e) ? acc : [...acc, e]), [])
    .length === 26;
}
