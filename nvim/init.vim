
call plug#begin('~/.vim/plugged')

Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'jparise/vim-graphql'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
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
Plug 'eagletmt/neco-ghc'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'racer-rust/vim-racer'
Plug 'mustache/vim-mustache-handlebars'
Plug 'Quramy/vim-js-pretty-template'
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'pangloss/vim-javascript'
Plug 'chrisbra/csv.vim'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'

" Elixir
Plug 'elixir-editors/vim-elixir'

" Elm
Plug 'ElmCast/elm-vim'

" Maybe remove this later
Plug 'severin-lemaignan/vim-minimap'

" Nginx
Plug 'chr4/nginx.vim'

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
let python_highlight_all=1
set number
set ruler
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
highlight Directory guifg=#FF0000 ctermfg=red
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

set wildignore +=*/node_modules/*

let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = '\node_modules\'
let g:ctrlp_cmp = 'CtrlPMixed'

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

" Let's add some javascript rubbish
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
" let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "_"
let g:javascript_conceal_underscore_arrow_function = "🞅"

map <leader>l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>

" Python stuff
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

