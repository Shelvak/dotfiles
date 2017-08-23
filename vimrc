" Running SO...
let isMac = system("uname") == "Darwin\n"

source ~/.vim/color-reference.txt

if filereadable(expand("~/.vim-plugins-rc"))
  call plug#begin('~/.vim/plugs')
  source ~/.vim-plugins-rc
  call plug#end()
endif

" VimInfo
set viminfo='100,\"5,:50,%,n~/.viminfo'

" Config
set nocompatible
set timeout
"set timeoutlen=1000
"set ttimeoutlen=100
"Delayer
set showcmd
set showmatch
set noshowmode
set smartcase
set incsearch
set mouse=v
set hlsearch
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set history=2000
set scrolljump=5
set scrolloff=3
set cursorline
set pastetoggle=<C-p>
set linebreak
set magic
set backspace=2
set laststatus=2
" set colorcolumn=80
" Some magic... for delay
set re=1
set lazyredraw
set et   "spaces instead of tabs

if isMac
  set mouse=nicr
  set ai
  set si

  set dictionary+=~/.evbdevtools/phabricator_users.txt
  set dictionary+=~/.evbdevtools/phabricator_groups.txt
else
  " Encoding
  scriptencoding utf-8
  setglobal fileencoding=utf-8
endif

set encoding=utf-8
"set fileformats=unix,dos

let mapleader=","

" Persistent undo
if exists('+undofile') && exists('+undodir')
	set undodir=~/.vim/undodir
	set undofile
endif

syntax on
filetype plugin indent on

if has("autocmd")
  " Ruby surround
  autocmd FileType ruby let b:surround_35 = "#{\r}"
  autocmd! BufRead,BufNewFile Gemfile setfiletype ruby
  autocmd! BufRead,BufNewFile Vagrantfile setfiletype ruby
  autocmd! BufRead,BufNewFile *.cap setfiletype ruby

  " Restore cursor last position
  augroup lastCursorPosition
    autocmd!
    " Remember last cursor position in file
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  augroup END
endif

autocmd Filetype javascript,python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufEnter *.handlebars setlocal tabstop=4 shiftwidth=4 expandtab

" Set colors
hi CursorLine term=bold cterm=bold ctermbg=none
hi Search ctermfg=black ctermbg=green
" In Iterm put TangoDark theme
set t_Co=256
set term=screen-256color
colorscheme grb256
" let g:solarized_termcolors=256
set background=light

" GitGutter
let g:gitgutter_enabled = 0
hi SignColumn ctermbg=none

" Gist-vim
let g:gist_detect_filetype = 1

if isMac
  let g:gist_clip_command = 'pbcopy'
else
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

" SmartColumns
let g:smart_display_opts = {'guibg': 'Blue' }
autocmd Filetype python let g:smart_display_opts = {'guibg': 'Blue', 'column': '120' }

" JSHint
"let jshint2_save = 1
"let jshint2_error = 0
"let jshint2_height = 5

" Short Cuts
map <Leader>n :set number!<CR>:GitGutterToggle<CR>
map <Leader>y <Plug>Yssurround=<cr>
map <Leader>i <Plug>Yssurround-<cr>
map <leader># ysiw#
map <C-n> :set relativenumber! <CR>

" Invisibles characters setup
set listchars=tab:▸\ ,eol:¬
nmap <Leader>l :set list!<CR>

" Maps
nnoremap <Leader><Leader> :nohlsearch<CR>

" Leader shortcuts for Vim Rails commands
nnoremap <Leader>m :Emodel
nnoremap <Leader>c :Econtroller
nnoremap <Leader>v :Eview
nnoremap <Leader>u :Eunittest
nnoremap <Leader>f :Efunctionaltest

" Leader shortcuts for Vim Fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>

" Navigate through quickfix
map <F2> :cprev<CR>
map <F1> :cnext<CR>

" Copy selected|entire file to systemclipboard
map <C-C> :%y+<CR>
" Copy the current file path
nnoremap <leader>C :let @+=expand("%")<CR>

" Rubocop
let fts = ['rb', 'erb']
if index(fts, &filetype) == -1
  let g:vimrubocop_keymap = 0
  let g:vimrubocop_config = '~/.rubocop.yml'
  nmap <F7> :RuboCop<CR>
endif

set tags=~/tags
runtime! settings/*

let g:python_host_prog = '/usr/bin/python2'
let g:python4_host_prog = '/usr/bin/python'

let g:ruby_host_prog = '/home/rotsen/.rubies/ruby-2.3.4/bin/ruby'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<m-tab>"

let g:vim_tags_auto_generate = 1

" ========================================
" FZF setup
" ========================================
set grepprg=rg\ —vimgrep
let g:grep_operator = 'rg'
let g:fzf_nvim_statusline=0
nnoremap <silent> <leader>t :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>. :Lines<CR>
map <silent> · :call SearchDefWithAg()<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


function! SearchDefWithAg()
  execute 'Rg' 'def '.expand('<cword>')
  "execute 'rg -i --column --line-number --no-heading --color=always "def '.expand('<cword>').'"'
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

command! -bang -nargs=* Agi call fzf#vim#grep('rg -i --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<F3>'
let g:multi_cursor_next_key='<F4>'
let g:multi_cursor_prev_key='<F5>'
let g:multi_cursor_skip_key='<F6>'
let g:multi_cursor_quit_key='<Esc>'

" NeoMake
let g:neomake_javascript_eslint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
let g:neomake_javascript_enabled_makers = ['eslint']
