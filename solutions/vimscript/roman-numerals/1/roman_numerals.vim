function! ToRoman(number) abort
  return s:ToRoman(a:number,
        \ [1000, 'M', 900, 'CM', 500, 'D', 400, 'CD',
        \  100, 'C', 90, 'XC', 50, 'L', 40, 'XL',
        \  10, 'X', 9, 'IX', 5, 'V', 4, 'IV', 1, 'I'])
endfunction

function! s:ToRoman(number, romans) abort
  if a:number
   let [s:hindu, s:roman; s:rest] = a:romans
   if a:number >= s:hindu
     return s:roman . s:ToRoman(a:number - s:hindu, a:romans)
   else
     return s:ToRoman(a:number, s:rest)
   endif
  else
    return ''
  endif
endfunction
