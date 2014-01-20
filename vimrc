" Ack
let g:ackprg="ack -H --nocolor --nogroup --column"

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
set history=2000
set scrolljump=5
set scrolloff=3
set cursorline
set colorcolumn=80
set pastetoggle=<C-p>
set linebreak

" Mac sucks (Mac Fixes)
set backspace=2
set mouse=nicr

scriptencoding utf-8
set encoding=utf-8
setglobal fileencoding=utf-8

let mapleader=','

" Persistent undo
set undofile
set undodir=~/.vim/undodir

syntax on

if has("autocmd")
  filetype plugin indent on

  " Ruby surround
  autocmd FileType ruby let b:surround_35 = "#{\r}"
  autocmd! BufRead,BufNewFile Gemfile setfiletype ruby
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
hi ColorColumn ctermbg=blue
hi CursorLine term=bold cterm=bold ctermbg=none
hi Visual term=reverse cterm=reverse guibg=Grey

" Solarized configs

  " Mac sucks (Mac Fixes)
"if !has('mac') && !has('macunix')
"  let g:solarized_termcolors=256
"  set t_Co=256
"  set background=dark
"endif
colorscheme grb256

" Surround.vim
let g:surround_113 = "#{\r}"      " v
let g:surround_45 = "<% \r %>"    " -
let g:surround_61 = "<%= \r %>"   " =

" GitGutter
let g:gitgutter_enabled = 0
hi SignColumn ctermbg=none

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
nnoremap <Leader>r :Rake

" Resize and restore windows
nnoremap <C-_> <C-W>_
nnoremap <C-=> <C-W>=

" Leader shortcuts for Vim Fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>

" Navigate through quickfix
map <F3> :cprev<CR>
map <F4> :cnext<CR>


