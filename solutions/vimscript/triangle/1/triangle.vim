function! Equilateral(triangle) abort
  return a:triangle[0] > 0
        \ && a:triangle[0] == a:triangle[1]
        \ && a:triangle[0] == a:triangle[2]
endfunction

function! Isosceles(triangle) abort
  let s:tri = s:normalize(a:triangle)
  return s:tri[1] == s:tri[2]
endfunction

function! Scalene(triangle) abort
  let s:tri = s:normalize(a:triangle)
  return s:tri[2] < s:tri[0] + s:tri[1]
        \ && !Isosceles(s:tri)
        \ && !Equilateral(s:tri)
endfunction

function! s:normalize(triangle) abort
  let s:tri = copy(a:triangle)
  call sort(s:tri)
  return s:tri
endfunction
