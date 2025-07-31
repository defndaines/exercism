function! Answer(drivel) abort
  if a:drivel ==# toupper(a:drivel) && a:drivel =~ '[A-Z]'
    return 'Whoa, chill out!'
  end
  if a:drivel =~ '?$'
    return 'Sure.'
  endif
  if a:drivel =~ '^\s*$'
    return 'Fine. Be that way!'
  endif
  return 'Whatever.'
endfunction
