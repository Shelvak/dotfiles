if exists('g:loaded_ExtractInterface')
    finish
endif

let g:loaded_ExtractInterface = 1

command -range -nargs=* Extract :<line1>,<line2>call s:ExtractInterface(<f-args>)

function! s:ExtractInterface(interface='', ...) range abort
  " Get visual-selected
  let content = getline(a:firstline, a:lastline)

  " Copy original file header (license/pragma)
  let headers = getline(1, 2)

  if a:interface == ''
    " Get interface name
    let name = matchstr(getline(a:firstline), '\vinterface (\zs\S+\ze) ')
  else
    let name = a:interface
  endif

  " Delete visual-selected
  silent exec a:firstline.','.a:lastline.'del'

  " Add import interface
  call append(a:firstline-1, 'import "../interfaces/'.name.'.sol";')

  " Build the final file name
  let out = 'interfaces/'.name.'.sol'

  " Open final file buffer
  exec 'split '. fnameescape(out)

  " Check if file has content, if not append original file headers
  if getline(1) == ''
    silent call append(0, headers)
  else
    silent call append(line('$'), '') " newline before
  endif

  " Paste extracted lines
  silent $put
endfunction
