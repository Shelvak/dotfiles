" Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"Pathogen for vim pluggins
runtime bundle/vim-pathogen/autoload/pathogen.vim

call pathogen#infect()
call pathogen#helptags()

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

scriptencoding utf-8

let mapleader=','

" Persistent undo
if exists('+undofile') && exists('+undodir')
  set undofile
  set undodir=~/.vim/undodir
end

if has("syntax")
  syntax on
endif

if has("autocmd")
  filetype plugin indent on

  " Rails Rcommands
  autocmd User Rails Rnavcommand fabricator  test/fabricators -suffix=_fabricator.rb -default=model()
  autocmd User Rails Rnavcommand uploader  app/uploaders -suffix=_uploader.rb -default=model()
  autocmd User Rails Rnavcommand inputs  app/inputs -suffix=_input.rb -default=model()
  
  " Ruby surround
  autocmd FileType ruby let b:surround_35 = "#{\r}"
endif

" Short Cuts
nmap <C-n> :set number! number?<CR>

" Set colors
hi ColorColumn ctermbg=blue
hi CursorLine term=bold cterm=bold ctermbg=none

" Solarized configs
let g:solarized_termcolors=256

colorscheme grb256
set background=dark
set t_Co=256

" Surround.vim
let g:surround_113 = "#{\r}"   " v
let g:surround_45 = "<% \r %>"    " -
let g:surround_61 = "<%= \r %>"   " =

map <Leader>y <Plug>Yssurround=<cr>
map <Leader>i <Plug>Yssurround-<cr>
map <leader># ysiw#

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
