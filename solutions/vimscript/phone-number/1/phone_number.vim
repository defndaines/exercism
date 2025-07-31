let s:phone_regex = '\v^[+1 (]*([2-9]\d{2})[). ]*([2-9]\d{2})[-. ]*(\d{4})$'

function! ToNANP(number) abort
  return match(a:number, s:phone_regex) > -1
        \ ? substitute(a:number, s:phone_regex, '\1\2\3', '')
        \ : ''
endfunction
