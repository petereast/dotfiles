
call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'

call plug#end()
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

" Some settings
syntax on
set number
set ruler
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
