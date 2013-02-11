" Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"Pathogen for vim pluggins
call pathogen#infect()

" Rails Rcommands
autocmd User Rails Rnavcommand fabricator  test/fabricators -suffix=_fabricator.rb -default=model()
autocmd User Rails Rnavcommand uploader  app/uploaders -suffix=_uploader.rb -default=model()
autocmd User Rails Rnavcommand inputs  app/inputs -suffix=_input.rb -default=model()

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

scriptencoding utf-8

if has("syntax")
  syntax on
endif

if has("autocmd")
  filetype plugin indent on
endif

" Short Cuts
nmap <C-n> :set number! number?<CR>

" Set colors
hi ColorColumn ctermbg=blue
hi CursorLine term=bold cterm=bold ctermbg=none
