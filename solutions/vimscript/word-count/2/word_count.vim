function! WordCount(phrase) abort
  let s:normalized = split(substitute(tolower(a:phrase), "[^A-Za-z0-9' ]", ' ', 'g'), '\s\+')
  let s:freq = {}
  for word in s:normalized
    let s:word = substitute(word, "^'\\(.*\\)'$", '\1', '')
    let s:freq[s:word] = get(s:freq, word, 0) + 1
  endfor
  return s:freq
endfunction
