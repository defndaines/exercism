function! Difference(number) abort
  return SquareOfSum(a:number) - SumOfSquares(a:number)
endfunction

function! SquareOfSum(number) abort
  let s:sum = 0
  for n in range(1, a:number)
    let s:sum += n
  endfor
  return s:sum * s:sum
endfunction

function! SumOfSquares(number) abort
  let s:sum = 0
  for n in range(1, a:number)
    let s:sum += n * n
  endfor
  return s:sum
endfunction
