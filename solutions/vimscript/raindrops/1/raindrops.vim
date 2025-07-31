function! Raindrops(number) abort
  let s:factors = []
  if fmod(a:number, 3) == 0.0
    call add(s:factors, 'Pling')
  endif
  if fmod(a:number, 5) == 0.0
    call add(s:factors, 'Plang')
  endif
  if fmod(a:number, 7) == 0.0
    call add(s:factors, 'Plong')
  endif

  if empty(s:factors)
    return string(a:number)
  else
    return join(s:factors, '')
  endif
endfunction
