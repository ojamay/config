" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
"       __  __                     _           _    ___
"       \ \/ /_ _ _ __ ___   __ _ (_) ___     | |  / (_)___ ___
"        \  / _` | '_ ` _ \ / _` || |/ _ \ ___| | / / / __ `__ \
"        / / (_| | | | | | | (_| || | (_) |___/ |/ / / / / / / /
"       /_/ \__,_|_| |_| |_|\__,_|/ |\___/    |___/_/_/ /_/ /_/
"                               |__/
"
"   This is the personal .vimrc file of Yamajo.
"   I recommend to pick out the parts you want and understand.
"
"}

" Options {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let environment="dev" "office or dev
" }

" Environment {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if !(has('win32') || has('win64'))
    set shell=/bin/sh
endif

" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if (has('win32') || has('win64'))
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Arrow Key Fix
" for vim-autoclose
" https://github.com/spf13/spf13-vim/issues/780
"if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
"    inoremap <silent> <C-[>OC <RIGHT>
"endif

" }

" GUI {
"###########################################################################
if has("gui_running")
  set guifont=Consolas:h11 " Windows
  "set guioptions-=m  "no menu bar
  set guioptions-=L  "no left-hand scroll bar
  set guioptions-=r  "no right-hand scroll bar
  set guioptions-=t  "no tearoff menu entries.
  set guioptions-=T  "no toolbar
  " Maximise gvim window
  "au GUIEnter * simalt ~n " use ~x on an English Windows version or ~n for French.
endif
" }

" Interface {
"###########################################################################
"set display=truncate   " Show @@@ in the last line if it is truncated
set history=200        " keep 200 lines of command line history
"set paste
set ruler              " show the cursor position all the time

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5
set showcmd            " display incomplete commands
set wildmenu           " display completion matches in a status line

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

if has('Pstatusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\                     " Filename
  set statusline+=%w%h%m%r                 " Options
  set statusline+=\ [%{&ff}/%Y]            " Filetype
  set statusline+=\ [%{getcwd()}]          " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

  set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y
  set statusline+=%=%c,%l/%L\ %P

endif

" }

" Syntax Highlighting {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nospell
" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

if &t_Co > 2 || has("gui_running")
  set hlsearch " Switch on highlighting the last used search pattern.
endif

highlight SpecialKey guifg=#465457 ctermfg=59
highlight NonText guifg=#465457 ctermfg=59
" }

" Defaults {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" }

" Custom {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion est activable avec <Leader>m
"let g:EasyMotion_leader_key = '<Leader>m'


" formats de fichiers pour lesquels l'autocomplétion est désactivée
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*~,*.tar,*.tgz,*.zip

"set list!
"set backspace=2 " make backspace work like most other apps
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " autocomplete
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  augroup END
else
  set autoindent " always set autoindenting on
endif " has("autocmd")

" }

" System {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nofsync            " le système décide quand vider le cache
set ttimeout           " time out for key codes
set ttimeoutlen=100    " wait up to 100ms after Esc for special key
set ttyfast            " accélère le rendu graphique
" }

" File {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4          " Tabs characters appear 4-spaces-wide
set shiftwidth=4       " Tabs. Size of an 'indent'
set expandtab          " Tab key insert spaces
set smarttab           " Tab key insert spaces or tab to next tabstop
set autoread           " MAJ auto si le fichier ouvert est modifié ailleurs
set encoding=utf-8     " encodage par défaut
set fileencoding=utf-8 " encodage par défaut
set nobackup           " no backup files
" }

" Mappings {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" restore opened file
map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3
" filter non-printable characters from the paste buffer
" useful when pasting from some gui application
nmap <leader>p :let @* = substitute(@*,'[^[:print:]]','','g')<cr>"*p

" saisir tag,,, pour obtenir <tag></tag>
imap ,,, <esc>bdwa<<esc>pa><cr></<esc>pa><esc>kA

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" }

" MS Windows Compatible {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set options and add mapping such that Vim behaves a lot like MS-Windows

" set the 'cpoptions' to its Vim default
if 1 " only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
"vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>               "+gP
map <S-Insert>          "+gP

cmap <C-V>              <C-R>+
cmap <S-Insert>         <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
" Use CTRL-G u to have CTRL-Z only undo the paste.

exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']

imap <S-Insert>         <C-V>
vmap <S-Insert>         <C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>           <C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>           :update<CR>
vnoremap <C-S>          <C-C>:update<CR>
inoremap <C-S>          <C-O>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
"noremap <C-Z> u
"inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
"noremap <C-Y> <C-R>
"inoremap <C-Y> <C-O><C-R>

" Alt-Space is System menu
"if has("gui")
"  noremap <M-Space> :simalt ~<CR>
"  inoremap <M-Space> <C-O>:simalt ~<CR>
"  cnoremap <M-Space> <C-C>:simalt ~<CR>
"endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
"noremap <C-F4> <C-W>c
"inoremap <C-F4> <C-O><C-W>c
"cnoremap <C-F4> <C-C><C-W>c
"onoremap <C-F4> <C-C><C-W>c

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif

" }

" Dev environment {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if environment == "dev"
    set cursorline
    set number
    set t_Co=256 " pour ssh
    "colorscheme slate
    colorscheme monokai " crusoexia/vim-monokai
endif
" }

" Office environment {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" hide ruler, statusline
if environment == "office"

endif
" }

" Add optional packages {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  " ??? packadd matchit
endif
" }

" Functions {
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show highlighting groups for current word
"nmap <C-S-P> :call <SID>SynStack()<CR>
"function! <SID>SynStack()
"  if !exists("*synstack")
"    return
"  endif
"  echo map(synstack(line('.'), col('.')),
"  \       'synIDattr(v:val, "name")')
"endfunc

" Seems to be checking if your Windows environment is able to do the diff itself
" and, if not, use the builtin diff.
"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

" }
