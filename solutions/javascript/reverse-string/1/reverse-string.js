export function reverseString(str) {
  return str.split('')
    .reduceRight((acc, e) => [...acc, e], [])
    .join('');
}
