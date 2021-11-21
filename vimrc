" Running SO...
" Before load plugins config
if filereadable(expand("~/.vim-plugins-before-load"))
  source ~/.vim-plugins-before-load
endif
" Load plugins
if filereadable(expand("~/.vim-plugins"))
  call plug#begin('~/.vim/plugs')
  source ~/.vim-plugins
  call plug#end()
endif

source ~/.vim/color-reference.txt

" Config
set term=screen-256color
set nocompatible
set timeout
"set timeoutlen=1000
"set ttimeoutlen=100
"Delayer
set showcmd
set showmatch
" set noshowmode
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
" set re=1
set lazyredraw
set et   "spaces instead of tabs

" Encoding
scriptencoding utf-8
setglobal fileencoding=utf-8
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
  autocmd Filetype elixir setlocal formatprg=mix\ format\ -
  autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd Filetype solidity setlocal tabstop=4 shiftwidth=4 expandtab
  autocmd! BufRead,BufNewFile Gemfile, Vagrantfile, *.cap setfiletype ruby
  autocmd! BufRead,BufNewFile *.pdf.erb setfiletype html.eruby
  autocmd! BufRead,BufNewFile *.jsx setfiletype javascript.jsx

  " console.log to debug contracts/tests
  autocmd BufRead,BufNewFile *.js,*.sol nnoremap <Leader>c :call <SID>InsertConsoleForRow()<CR>

  function! s:InsertConsoleForRow()
    execute "normal! o" . "console.log('" . expand('%:t') . ":" .line(".") . "');" . "\<Esc>=="
  endfunction

  autocmd BufWritePre * if index(['gitcommit', 'snippets'], &ft) < 0 | %s/\t/  /ge  " Replace tabs except in gitcommit msg

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

" Set colors
hi CursorLine term=bold cterm=bold ctermbg=none
hi Search ctermfg=black ctermbg=green
set t_Co=256
colorscheme grb256
set background=light

" Show line number & git status
map <Leader>n :set number!<CR>:GitGutterToggle<CR>
map <C-n> :set relativenumber! <CR>

" Invisibles characters setup
set listchars=tab:▸\ ,eol:¬
nmap <Leader>l :set list!<CR>

" Clean search highlight
nnoremap <Leader><Leader> :nohlsearch<CR>

" Navigate through quickfix
map <F2> :cprev<CR>
map <F1> :cnext<CR>
map <ESC>[1;5D <C-Left>
map <ESC>[1;5C <C-Right>

" ========================================
" Clipboard / Copy selected|entire file to systemclipboard
" ========================================
set clipboard=unnamed " plus
" Copy content (full file or selected in visual mode)
map <C-C> :%y+<CR>
" Copy the current file path
nnoremap <leader>C :let @+=expand("%")<CR>

if filereadable(expand("~/.vim-plugins-rc"))
  source ~/.vim-plugins-rc
endif

" ========================================
" Save file with sudo (extreme!!!)
" ========================================
" cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" ========================================
" Command history per git project or global
" ========================================
let projects=$HOME."/git/"
let current_dir=getcwd()
if stridx(current_dir, projects) == 0
  let project_name=split(strpart(current_dir, len(projects)), '/')[0]
  exe "set viminfo=%,'100,<5,/50,:100,n" . projects . project_name . "/.viminfo"
else
  set viminfo=%,'100,<5,/50,:100,n~/.viminfo
endif

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
