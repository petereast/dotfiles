
call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'diepm/vim-rest-console'
Plug 'terryma/vim-multiple-cursors'
Plug 'eagletmt/ghcmod-vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git status in nerd-tre
Plug 'ctrlpvim/ctrlp.vim'
Plug 'eagletmt/neco-ghc'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'racer-rust/vim-racer'
Plug 'mustache/vim-mustache-handlebars'

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

" Change the background colour of ALE highlighting
highlight ALEError ctermfg=black ctermbg=red
highlight ALEWarning ctermbg=black

" Automatically wrap markdown files
" TODO

" Run rustfmt on write of rust files
autocmd BufWritePost *.rs !cargo +nightly fmt
let g:ale_rust_cargo_check_tests = 1

" Stuff for ctrlspace
set nocompatible
set hidden
if executable("ag")
  let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmp = 'CtrlP'

set clipboard^=unnamed
set hidden
let g:racer_cmd = "/home/user/.cargo/bin/racer"
let g:racer_experimental_completer = 1

command PrettyJson %!python -m json.tool

" Rust Racer
let g:racer_cmd = "/home/peter/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:rust_recommended_style = 1
let g:rustfmt_autosave = 1
let g:rustfmt_command = "cargo +nightly fmt --"

imap <c-space> <c-x><c-o>
