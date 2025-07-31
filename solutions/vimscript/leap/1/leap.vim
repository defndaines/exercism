"
" This function takes a year and returns 1 if it's a leap year
" and 0 otherwise.
"
function! IsLeap(year) abort
  if a:year % 400 == 0
    return 1
  elseif a:year % 100 == 0
    return 0
  elseif a:year % 4 == 0
    return 1
  endif
endfunction