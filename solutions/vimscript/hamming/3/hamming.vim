function! Hamming(strand1, strand2)
  if len(a:strand1) != len(a:strand2)
    throw 'The two strands must have the same length.'
  endif

  let distance = len(a:strand1)
  for i in range(len(a:strand1))
    let distance -= a:strand1[i] ==# a:strand2[i]
  endfor
  return distance
endfunction
