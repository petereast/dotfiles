
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc


call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git status in nerd-tre
Plug 'ctrlpvim/ctrlp.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'udalov/kotlin-vim'
Plug 'ianks/vim-tsx'
Plug 'preservim/tagbar'

call plug#end()

syntax enable
filetype plugin indent on

" Use release branch (recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

" Use relative lines
set relativenumber

" Configure ale linters
let g:ale_linters = {'rust': ['analyzer'], 'kotlin': ['languageserver'], 'clojure': ['clj-kondo']}
let g:ale_rust_analyzer_executable = "/Users/petereast/.rustup/toolchains/stable-x86_64-apple-darwin/bin/rust-analyzer"

" Some settings
set number
set ruler

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Change the background colour of ALE highlighting
highlight ALEError ctermfg=black ctermbg=red
highlight ALEWarning ctermbg=black

" Automatically wrap markdown files
" TODO

" Run rustfmt on write of rust files
" autocmd BufWritePost *.rs !cargo +nightly fmt
" let g:ale_rust_cargo_check_tests = 1

" Stuff for ctrlspace
set nocompatible
set hidden
if executable("rg")
  let g:CtrlSpaceGlobCommand = 'rg -l --nocolor -g ""'
endif

let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmp = 'CtrlP'

set clipboard^=unnamed
set hidden

command! PrettyJson %!python -m json.tool

let g:rust_recommended_style = 1
let g:rustfmt_autosave = 1

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

nnoremap <c-/> :NERDTreeToggle<CR>
nnoremap <c-t> :FloatermToggle<CR>

set timeoutlen=100 ttimeoutlen=0
let g:ctrlp_custom_ignore = '\node_modules\'

" Set the colour of the pmenu
hi Pmenu ctermbg=white
set background=dark

" Clojure stuff

" From Scala metals vvv
" ~/.vimrc

" Let's add some IntelliJ-esque keyboard shortcuts
nmap <c-k1> :NERDTreeToggle<CR>
nmap <D-f> :NERDTreeFind<CR>
nmap <F8> :TagbarToggle<CR>
