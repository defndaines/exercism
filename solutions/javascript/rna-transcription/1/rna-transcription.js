const rnaMap = {
  A: 'U',
  C: 'G',
  G: 'C',
  T: 'A',
};

export function toRna(seq) {
  if (/[^ACGT]/.test(seq)) {
    throw new Error('Invalid input DNA.');
  }
  return seq.split('')
    .map(ch => rnaMap[ch])
    .join('');
}
