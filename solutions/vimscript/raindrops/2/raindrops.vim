function! Raindrops(number) abort
  let s:phrase = ''
  if a:number % 3 == 0
    let s:phrase .= 'Pling'
  endif
  if a:number % 5 == 0
    let s:phrase .= 'Plang'
  endif
  if a:number % 7 == 0
    let s:phrase .= 'Plong'
  endif

  if empty(s:phrase)
    return string(a:number)
  else
    return s:phrase
  endif
endfunction
