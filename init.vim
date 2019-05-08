
call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'diepm/vim-rest-console'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'terryma/vim-multiple-cursors'
Plug 'eagletmt/ghcmod-vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git status in nerd-tre
Plug 'ctrlpvim/ctrlp.vim'
Plug 'eagletmt/neco-ghc'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'racer-rust/vim-racer'
Plug 'mustache/vim-mustache-handlebars'
Plug 'Quramy/vim-js-pretty-template'
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'chrisbra/csv.vim'
Plug 'mxw/vim-jsx'

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

command! PrettyJson %!python -m json.tool

" Rust Racer
let g:racer_cmd = "/home/peter/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:rust_recommended_style = 1
let g:rustfmt_autosave = 1
let g:rustfmt_command = "cargo +nightly fmt --"

imap <c-space> <c-x><c-o>

" Stuff for written documents
hi clear SpellBad
hi SpellBad cterm=underline

" ----- neovimhaskell/haskell-vim -----

" Align 'then' two spaces after 'if'
let g:haskell_indent_if = 2
" Indent 'where' block two spaces under previous body
let g:haskell_indent_before_where = 2
" Allow a second case indent style (see haskell-vim README)
let g:haskell_indent_case_alternative = 1
" Only next under 'let' if there's an equals sign
let g:haskell_indent_let_no_in = 0

" ----- hindent & stylish-haskell -----

" Indenting on save is too aggressive for me
let g:hindent_on_save = 1

" Helper function, called below with mappings
function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

" Key bindings
augroup haskellStylish
  au!
  " Just hindent
  au FileType haskell nnoremap <leader>hi :Hindent<CR>
  " Just stylish-haskell
  au FileType haskell nnoremap <leader>hs :call HaskellFormat('stylish')<CR>
  " First hindent, then stylish-haskell
  au FileType haskell nnoremap <leader>hf :call HaskellFormat('both')<CR>
augroup END

" let g:ale_linters.haskell = ['hlint']

nnoremap <c-/> :NERDTreeToggle<CR>
nnoremap <c-t> :tabe<cr>:NERDTreeMirror<CR>

set timeoutlen=100 ttimeoutlen=0
let g:ctrlp_custom_ignore = '\node_modules\'
