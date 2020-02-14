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
    let branch = fugitive#head()
    let git_path = FugitiveExtractGitDir(expand('%:p')) " Get the .git absolute path
    let project_name = get(split(git_path, '/'), '-2', '')  " split and get the project dir name (last item is .git)
    return strlen(branch) ? '['.project_name.'#'.branch.']♆' : ''
  endif

  return ''
endfunction

