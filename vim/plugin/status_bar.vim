let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'branch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'branch':   'BranchName',
      \   'readonly': 'ReadonlyFile',
      \   'modified': 'ModifiedFile'
      \ },
      \ 'separator': { 'left': '>', 'right': '>' },
      \ 'subseparator': { 'left': '>', 'right': '>' }
      \ }

function! ModifiedFile()
  if &modified
    return '☣'
  endif

  return ''
endfunction

function! ReadonlyFile()
  if &readonly
    return '☠'
  endif

  return ''
endfunction

function! BranchName()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '['._.']♆' : ''
  endif

  return ''
endfunction

