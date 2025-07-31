function! Hamming(strand1, strand2)
  if len(a:strand1) != len(a:strand2)
    throw 'The two strands must have the same length.'
  endif

  let s:distance = len(a:strand1)
  for s:i in range(len(a:strand1))
    let s:distance -= a:strand1[s:i] ==# a:strand2[s:i]
  endfor
  return s:distance
endfunction
