let s:letters = {
      \ 'd': 2, 'g': 2,
      \ 'b': 3, 'c': 3, 'm': 3, 'p': 3,
      \ 'f': 4, 'h': 4, 'v': 4, 'w': 4, 'y': 4,
      \ 'k': 5,
      \ 'j': 8, 'x': 8,
      \ 'q': 10, 'z': 10 }

function! Score(word) abort
  let s:score = 0
  for ch in split(tolower(a:word), '\zs')
    let s:score += get(s:letters, ch, 1)
  endfor
  return s:score
endfunction
