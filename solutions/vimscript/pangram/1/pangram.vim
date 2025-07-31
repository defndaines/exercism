function! IsPangram(sentence) abort
  return join(uniq(sort(split(tolower(a:sentence), '\zs'))), '')
        \ =~ 'abcdefghijklmnopqrstuvwxyz'
endfunction
