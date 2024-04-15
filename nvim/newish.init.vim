
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' " Show git status in nerd-tre
Plug 'ctrlpvim/ctrlp.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'folke/zen-mode.nvim'

call plug#end()

" syntax enable
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
let g:ale_linters = {'rust': ['analyzer'], 'kotlin': ['languageserver'], 'clojure': ['clj-kondo'], 'go': ['gofmt', 'golint', 'gopls', 'govet'], 'python': ['flake8', 'pylint', 'jedils']}
let g:ale_rust_analyzer_executable = "/Users/petereast/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer"

" Some settings
set number
set ruler

" NERDTree stuff
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * NERDTreeClose | CtrlP

" Change the background colour of ALE highlighting
highlight ALEError ctermfg=black ctermbg=red
highlight ALEWarning ctermbg=black

" Run rustfmt on write of rust files
" autocmd BufWritePost *.rs !cargo +nightly fmt
" let g:ale_rust_cargo_check_tests = 1

let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

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

nnoremap <c-m> :NERDTreeToggle<CR>
nnoremap <c-t> :FloatermToggle<CR>

set timeoutlen=100 ttimeoutlen=0
" Set the colour of the pmenu
hi Pmenu ctermbg=white
set background=dark

" Let's add some IntelliJ-esque keyboard shortcuts
nmap <c-k1> :NERDTreeToggle<CR>
nmap <F6> :ALERename<CR>
nmap <D-f> :NERDTreeFind<CR>
nmap <F8> :TagbarToggle<CR>
nmap <c-L> :buffers<CR>
nmap <F2> :lnext<CR>

command Gc Git add % | Git commit
