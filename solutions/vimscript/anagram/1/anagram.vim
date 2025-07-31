function! Anagram(word, candidates) abort
  let s:base = sort(split(tolower(a:word), '\zs'))
  return sort(filter(a:candidates, {_, val -> sort(split(tolower(val), '\zs')) == s:base && tolower(val) !=? a:word}))
endfunction
