"vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker

" General options {
"---------------------------------------------------------------------------
set nocompatible                "use vim settings, rather than vi settings
set noeb                        "no error bells
set vb t_bv=                    "visual bell instead of beeping
" }

" Plugins {
"---------------------------------------------------------------------------
filetype off                                        "required for vundle!

" vundle configuration
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" plugins managment
Plugin 'gmarik/Vundle.vim'                          "plugin manager

" theme plugin
Plugin 'altercation/vim-colors-solarized'           "solarized colorscheme

" syntax check and highlight plugins
Plugin 'vim-syntastic/syntastic'                    "syntax checking
Plugin 'Shutnik/jshint2.vim'                        "jshint integration
Plugin 'stephpy/vim-php-cs-fixer'                   "php-cs-fixer integration
Plugin 'nvie/vim-flake8'                            "flake8
Plugin 'Glench/Vim-Jinja2-Syntax'                   "jinja syntax
Plugin 'evidens/vim-twig'                           "twig syntax
Plugin 'chr4/nginx.vim'                             "nginx syntax
Plugin 'vim-scripts/indentpython.vim'               "python auto indent

" utilities plugins
Plugin 'triglav/vim-visual-increment'               "improved visual replacemen
Plugin 'tmhedberg/SimpylFold'                       "enhanced code folding
Plugin 'kien/ctrlp.vim'                             "improved search

" git plugins
Plugin 'tpope/vim-fugitive'                         "git wrapper

call vundle#end()
filetype plugin indent on

" Syntastic bundle configuration
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_rust_checkers = ['rustc']

" syntastic shortcut
nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd lclose\|bdelete
" }

" File formating {
"---------------------------------------------------------------------------
set encoding=utf-8              "default encoding
set fileencoding=utf-8

set tabstop=4                   "tabs characters appear 4-spaces-wide
set shiftwidth=4                "indents will be 4-spaces-wide
set expandtab                   "tab key insert spaces
set smartindent                 "indent at the same level of the previous line
" }

" Display {
"---------------------------------------------------------------------------
" theme
syntax on                                           "syntax highlight
set background=dark                                 "assume dark background
colorscheme solarized

" display line numbers
set number                      "display line numbers
set ruler                       "show the ruler

" flag white spaces at EOL
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile * match BadWhitespace /\s\+$/

" associate drupal module files with php syntax highlightning
au BufRead,BufNewFile *.module set filetype=php

" display the status line
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" syntastic addition to statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Broken down into easily includeable segments
"set statusline=%<%f\                     " Filename
"set statusline+=%w%h%m%r                 " Options
"set statusline+=\ [%{&ff}/%Y]            " Filetype
"set statusline+=\ [%{getcwd()}]          " Current dir
"set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y
"set statusline+=%=%c,%l/%L\ %P
" }

" Interaction {
"---------------------------------------------------------------------------
set pastetoggle=<F12>           "same indentation on pastes
set sidescroll=1
set backspace=indent,eol,start
set viminfo='20,\"50
set cino=
set showcmd                     "show partial commands in status line
set showmatch                   "show matching brackets/parenthesis
set report=0
set wildchar=<Tab>
set joinspaces
set tabpagemax=100              "maximum tab pages

" search
set noignorecase                "no ignore-case in search patterns
set hlsearch                    "highlight search terms
set incsearch                   "find as you type search

" history
set history=100                 "history capacity
set nobackup                    "no backup files
set undolevels=1000             "maximum number of changes that can be undone
set undoreload=1000             "number of lines saved that can be undone

" enable code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" add a docstring for folded code
let g:SimpylFold_docstring_preview=1
" }

" Global shortcuts {
"---------------------------------------------------------------------------
nmap <C-p> :tabprevious<CR>
nmap <C-n> :tabnext<CR>
nmap <C-t> :tabnew<CR>
imap <C-a> <ESC>^i
imap <C-e> <ESC>$i
map <C-e> $
map <C-a> ^
" }
