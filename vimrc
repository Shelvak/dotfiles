" Running SO...
let isMac = system("uname") == "Darwin\n"

" Load plugins
"let b:deoplete_ignore_sources = ['buffer']

if filereadable(expand("~/.vim-plugins-rc"))
  call plug#begin('~/.vim/plugs')
  source ~/.vim-plugins-rc
  call plug#end()
endif


" VimInfo
set viminfo='100,\"5,:50,%,n~/.viminfo'

" Config
"set nocompatible
set timeout
"set timeoutlen=1000
"set ttimeoutlen=100
"Delayer
set showcmd
set showmatch
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
set ttyfast
set lazyredraw

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

if has("autocmd")
  filetype plugin indent on

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

" Restore cursor to last positon

" Set colors
hi CursorLine term=bold cterm=bold ctermbg=none
hi Search ctermfg=black ctermbg=green

" Solarized + Colorscheme configs
" In Iterm put TangoDark theme + term-new simulation
let g:solarized_termcolors=256
colorscheme grb256
set background=dark
set t_Co=256

" Surround.vim
let g:surround_113 = "#{\r}"      " v
let g:surround_45 = "<% \r %>"    " -
let g:surround_61 = "<%= \r %>"   " =

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

" JSHint
let jshint2_save = 1
let jshint2_error = 0
let jshint2_height = 5

" Short Cuts
map <Leader>n :set number!<CR>:GitGutterToggle<CR>
map <Leader>y <Plug>Yssurround=<cr>
map <Leader>i <Plug>Yssurround-<cr>
map <leader># ysiw#
"map <C-n> :set relativenumber! <CR>

" Invisibles characters setup
set listchars=tab:▸\ ,eol:¬
nmap <Leader>l :set list!<CR>

" Maps
nnoremap <Leader><Leader> :nohlsearch<CR>

" Leader shortcuts for Vim Rails commands
nnoremap <Leader>m :Rmodel
nnoremap <Leader>c :Rcontroller
nnoremap <Leader>v :Rview
nnoremap <Leader>u :Runittest
nnoremap <Leader>f :Rfunctionaltest
nnoremap <Leader>i :Rintegrationtest

" Leader shortcuts for Vim Fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>

" Navigate through quickfix
map <F2> :cprev<CR>
map <F1> :cnext<CR>

map <C-C> :%y+<CR>

function Dos2Unix()
  update
  e ++ff=dos
  setlocal ff=unix
  w
endfunction

map <C-m>:call Dos2Unix()<CR>

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
let g:python3_host_prog = '/usr/bin/python'

let g:ruby_host_prog = '/home/rotsen/.rubies/ruby-2.3.1/bin/ruby'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<m-tab>"

let g:vim_tags_auto_generate = 1
set tags=./.git/tags
nnoremap · :CtrolPTag<CR>

let g:ctrlp_map = '<leader>t'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

