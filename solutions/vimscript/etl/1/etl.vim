function! Transform(scores) abort
  let s:ret = {}
  for [key, val] in items(a:scores)
    for ch in val
      let s:ret[tolower(ch)] = str2nr(key)
    endfor
  endfor
  return s:ret
endfunction
