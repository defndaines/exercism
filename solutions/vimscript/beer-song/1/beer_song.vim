function! Verse(verse) abort
  if a:verse == 1
    return "1 bottle of beer on the wall, 1 bottle of beer.\n"
          \ . "Take it down and pass it around, no more bottles of beer on the wall.\n"
  elseif a:verse
    return printf("%s on the wall, %s.\nTake one down and pass it around, %s on the wall.\n",
          \ s:bottles(a:verse), s:bottles(a:verse), s:bottles(a:verse - 1))
  else
    return "No more bottles of beer on the wall, no more bottles of beer.\n"
          \ . "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  endif
endfunction

function! Verses(start, end) abort
  let s:song = []
  for n in range(a:start, a:end, -1)
    call add(s:song, Verse(n))
  endfor
  return join(s:song, "\n")
endfunction

function! s:bottles(n) abort
  if a:n > 1
    return printf('%d bottles of beer', a:n)
  elseif a:n == 1
    return printf('%d bottle of beer', a:n)
  elseif a:n == 0
    return 'no more bottles of beer'
  endif
endfunction
