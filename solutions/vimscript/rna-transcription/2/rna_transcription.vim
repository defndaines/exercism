function! ToRna(strand) abort
  if a:strand !~# '^[ACGT]*$'
    return ''
  endif
  return tr(a:strand, 'ACGT', 'UGCA')
endfunction
