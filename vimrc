" Running SO...
let uname = system("uname")

"Pathogen for vim pluggins
runtime bundle/vim-pathogen/autoload/pathogen.vim

execute pathogen#infect()
execute pathogen#helptags()

" VimInfo
set viminfo='100,\"5,:50,%,n~/.viminfo'

" Config
set nocompatible
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
"set colorcolumn=80

if uname == "Darwin\n"
  set mouse=nicr
  set ai
  set si
else

  " Encoding
  scriptencoding utf-8
  setglobal fileencoding=utf-8
endif

set encoding=utf-8


let mapleader=','

" Persistent undo
set undodir=~/.vim/undodir
set undofile

syntax on

if has("autocmd")
  filetype plugin indent on

  " Ruby surround
  autocmd FileType ruby let b:surround_35 = "#{\r}"
  autocmd! BufRead,BufNewFile Gemfile setfiletype ruby
  autocmd! BufRead,BufNewFile .cap setfiletype ruby
endif

" Restore cursor to last positon
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Set colors
"hi ColorColumn ctermbg=blue
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

if uname == "Darwin\n"
  let g:gist_clip_command = 'pbcopy'
else
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

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

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

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
