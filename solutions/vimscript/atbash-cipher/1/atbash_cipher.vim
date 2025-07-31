function! AtbashDecode(cipher) abort
  return tr(substitute(tolower(a:cipher), ' ', '', 'g'), 'abcdefghijklmnopqrstuvwxyz', 'zyxwvutsrqponmlkjihgfedcba')
endfunction

function! AtbashEncode(plaintext) abort
  let s:normalized = substitute(tolower(a:plaintext), '[^[:alnum:]]', '', 'g')
  let s:normalized = tr(s:normalized, 'abcdefghijklmnopqrstuvwxyz', 'zyxwvutsrqponmlkjihgfedcba')
  let s:chunks = []
  for n in range(0, len(s:normalized) - 1, 5)
    call add(s:chunks, s:normalized[n:n + 4])
  endfor
  return join(s:chunks)
endfunction
