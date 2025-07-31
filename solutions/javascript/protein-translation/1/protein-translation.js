const codonToProtein = {
  AUG: 'Methionine',
  UAA: 'STOP',
  UAC: 'Tyrosine',
  UAG: 'STOP',
  UAU: 'Tyrosine',
  UCA: 'Serine',
  UCC: 'Serine',
  UCG: 'Serine',
  UCU: 'Serine',
  UGA: 'STOP',
  UGC: 'Cysteine',
  UGG: 'Tryptophan',
  UGU: 'Cysteine',
  UUA: 'Leucine',
  UUC: 'Phenylalanine',
  UUG: 'Leucine',
  UUU: 'Phenylalanine',
};

export default function translate(rna) {
  if (rna === undefined) { return []; }

  const polypeptide = rna.match(/.{3}/g)
    .map(codon => codonToProtein[codon]);

  if (polypeptide.indexOf(undefined) === 0) {
    throw new Error('Invalid codon');
  }

  const stop = polypeptide.indexOf('STOP');
  if (stop > -1) {
    return polypeptide.slice(0, stop);
  }

  return polypeptide;
}
