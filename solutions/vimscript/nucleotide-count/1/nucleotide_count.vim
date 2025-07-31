function! NucleotideCount(strand) abort
  if a:strand !~# '^[ACGT]*$'
    throw 'invalid nucleotide in strand'
  endif
  let s:freq = {'A': 0, 'C': 0, 'G': 0, 'T': 0}
  for nucleotide in split(a:strand, '\zs')
    let s:freq[nucleotide] = get(s:freq, nucleotide) + 1
  endfor
  return s:freq
endfunction
