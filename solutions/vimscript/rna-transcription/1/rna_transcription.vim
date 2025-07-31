let s:rna_map = {'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U'}

function! ToRna(strand) abort
  if a:strand !~ '^[' . join(keys(s:rna_map), '') . ']*$'
    return ''
  endif
  return join(map(split(a:strand, '\zs'), {_, val -> get(s:rna_map, val, '')}), '')
endfunction
