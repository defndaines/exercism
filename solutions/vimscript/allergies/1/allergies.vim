let s:allergies = [
      \ ['eggs', 1],
      \ ['peanuts', 2],
      \ ['shellfish', 4],
      \ ['strawberries',8],
      \ ['tomatoes', 16],
      \ ['chocolate', 32],
      \ ['pollen', 64],
      \ ['cats', 128]]

function! AllergicTo(score, allergy) abort
  return index(List(a:score), a:allergy) > -1
endfunction

function! List(score) abort
  let s:allergens = []
  for [allergen, factor] in s:allergies
    if and(a:score, factor)
      call add(s:allergens, allergen)
    endif
  endfor
  return s:allergens
endfunction
