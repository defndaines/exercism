function! AtbashDecode(cipher) abort
  return s:Translate(a:cipher)
endfunction

function! AtbashEncode(plaintext) abort
  let s:normalized = s:Translate(a:plaintext)
  return join(split(s:normalized, '.\{5}\zs'))
endfunction

function! s:Translate(phrase) abort
  let s:normalized = substitute(tolower(a:phrase), '[^[:alnum:]]', '', 'g')
  return tr(s:normalized, 'abcdefghijklmnopqrstuvwxyz', 'zyxwvutsrqponmlkjihgfedcba')
endfunction
