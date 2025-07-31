function! WordCount(phrase) abort
  let s:normalized = split(substitute(tolower(a:phrase), "[^A-Za-z0-9' ]", ' ', 'g'), '\s\+')
  let s:freq = {}
  for word in s:normalized
    let s:count = get(s:freq, word, 0) + 1
    let s:word = substitute(substitute(word, "^'", '', ''), "'$", '', '')
    execute 'let s:freq["' . s:word . '"] = s:count'
  endfor
  return s:freq
endfunction
