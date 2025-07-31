function! LargestProduct(digits, span) abort
  " Filter out all the edge cases.
  if a:digits =~ '\D'
    throw 'invalid input'
  elseif a:span > len(a:digits) || a:span < 0
    return -1
  endif

  " Good input, now find the largest product.
  let s:candidates = []
  for n in range(0, len(a:digits) - a:span)
    call add(s:candidates, strpart(a:digits, n, a:span))
  endfor
  call map(s:candidates, {_, val -> s:DigitsProduct(val)}) 
  return sort(s:candidates, 'n')[-1]
endfunction

function! s:DigitsProduct(digits) abort
  if empty(a:digits)
    return 1
  endif
  execute 'let s:product = ' . join(split(a:digits, '\zs'), ' * ')
  return s:product
endfunction
