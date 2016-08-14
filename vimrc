filetype off

set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/Vundle.vim'

Bundle 'Valloric/YouCompleteMe'
" Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Plugin 'KabbAmine/zeavim.vim'

" Better JS support
Bundle 'jelera/vim-javascript-syntax'
" Colour RGB appropriately
Bundle 'ap/vim-css-color'
" Tags
Bundle 'majutsushi/tagbar'
" Git support commands and git diff
Bundle 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" Fuzzy file searching
Bundle 'ctrlpvim/ctrlp.vim'
" Make python nice
Bundle 'klen/python-mode'
" Colour scheme
Bundle 'nanotech/jellybeans.vim'
" Nice status bar
Bundle 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Better C++ highlighting
Bundle 'octol/vim-cpp-enhanced-highlight'
" Rainbow!!!
Plugin 'luochen1990/rainbow'
" Better Haskell indenting/highlighting
Bundle 'neovimhaskell/haskell-vim'
" Conceals in Haskell and Python
" Bundle 'ehamberg/vim-cute-python'
" Bundle 'Twinside/vim-haskellConceal'
" Haskell completion
Bundle 'eagletmt/neco-ghc'
" Language aware commenting
Bundle 'scrooloose/nerdcommenter'
" File browser
Bundle 'scrooloose/nerdtree'
Bundle 'rdnetto/YCM-Generator'

" vim-scripts
" List tasks/todos
Bundle 'TaskList.vim'
" General helper utils
Bundle 'L9'
" Make Latex files nicer
Bundle 'Latex-Text-Formatter'

call vundle#end()

let g:necoghc_enable_detailed_browse = 1

filetype plugin indent on

colorscheme jellybeans

" general editing
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=50	            	" keep 50 lines of command line history
set ruler	                	" show the cursor position all the time
set showcmd	                	" display incomplete commands
set nu 		                	" show line numbers
set rnu                         " make line numbers relative

" Save on loss of focus
au FocusLost * :silent! wall
" Automatically write changes to a file on certain commands
set autowrite

" Automatically reread externally modified files if unchanged in Vim
set autoread

" Display as much as possible of the last line
set display+=lastline

" Indicate we're on a fast terminal connection
set ttyfast

" Make 'U' perform a redo operation (a sensible inverse of 'u')
nnoremap U <C-r>

" Configure persistent undo
if has('persistent_undo')
    " Enable/disable saving of undo history to an undo file
    set undofile

    " Directories to try for reading/writing undo files
    set undodir^=~/.vim/undo//
endif

" Ranger
noremap <C-a> :silent !ranger %:h<cr>:redraw!<CR>

" Py mode speedups
" Don't automatically run linter on saving changes
let g:pymode_lint_on_write = 0

" Don't automatically regenerate rope project cache on saving changes
let g:pymode_rope_regenerate_on_write = 0

" Make search nice
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader>y :noh<cr>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Movement
nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk

nnoremap ; :

" compiling with make
set mp=make\ -B\ %:r\ CXXFLAGS=\"-g\ -std=c++11\"
set aw

" Y should do what it's expected to do (d$, D, c$, C)
nmap Y y$

" Sorting is useful
vnoremap S :sort<CR>

" haskell supertab
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" nerdtree
map <C-N> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" The following maps the F7 key to toggle between hex and binary (while also setting the 
" noeol and binary flags, so if you :write your file, vim doesn't perform unwanted conversions.

noremap <F7> :call HexMe()<CR>

let $in_hex=0
function HexMe()
set binary
set noeol
if $in_hex>0
:%!xxd -r
let $in_hex=0
else
:%!xxd
let $in_hex=1
endif
endfunction

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" indentation
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
nnoremap <F3> :set paste!<cr>
set pastetoggle=<F3>

" status
set modeline
set laststatus=2

let mapleader=" "

" folding
set foldenable
set foldmethod=syntax
set foldopen=block,hor,percent,quickfix,tag
set foldlevel=99
highlight Folded ctermfg=White ctermbg=54

" system clipboard stuff, not sure how much is needed
set clipboard+=unnamed
set clipboard+=unnamedplus
set go+=a

" don't clutter dir with backups/swap
set backupdir=~/.vim/tmp,.
set directory=~/vim/tmp,.

" Remap ctrl+arrows to move between window splits
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

map <leader>[ :tabprevious<CR>
map <leader>] :tabnext<CR>
map <leader>y :tabedit<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Allow Ctrl Shift C/V for copy/pasting to system
vmap <silent> <C-c> "+y
nmap <silent> <C-c> "+y
vmap <silent> <C-v> "+p
nmap <silent> <C-v> "+p
imap <silent> <C-v> <ESC>"+pi

" Now, make python work with virtualenvs:
if has("python") && !empty($VIRTUAL_ENV)
  python << EOF
import os
import sys
a = os.environ['VIRTUAL_ENV'] + '/bin/activate_this.py'
execfile(a, dict(__file__ = a))
if 'PYTHONPATH' not in os.environ:
    os.environ['PYTHONPATH'] = ''
    os.environ['PYTHONPATH'] += os.getcwd()+":"
    os.environ['PYTHONPATH'] += ":".join(sys.path)
EOF
endif

" QuickFix close function; :q should close a window *and* the accompanying
" quickfix
aug QFClose
  au!
  " if |q| doesn't work use |cclose| ?
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Javascript folding that doesn't suck
let javaScript_fold=1
au FileType javascript call JavaScriptFold()

" Conceal
set conceallevel=2
hi Conceal ctermbg=234 ctermfg=81
fu! SetCppConceals()
    syntax match cppSmartPtr "\(std::\)\?unique_ptr" conceal cchar=●
    syntax match cppSmartPtr "\(std::\)\?shared_ptr" conceal cchar=◆
    syntax match cppSmartPtr "\(std::\)\?weak_ptr" conceal cchar=▲
endfunction
au FileType cpp call SetCppConceals()

let g:rainbow_active = 1
let g:rainbow_conf = {
   \ 'ctermfgs': ['Darkblue', 'darkgreen', 'darkcyan', 'darkred', 'darkmagenta', 'brown', 'grey', 'lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
   \ 'separately': {
   \   'cpp': {
   \     'parentheses': [
   \       'start=/(/ end=/)/ fold',
   \       'start=/\[/ end=/\]/ fold',
   \       'start=/{/ end=/}/ fold',
   \       'start=/\(\(\<operator\>\)\@<!<\)\&[a-zA-Z0-9_]\@<=<\ze[^<]/ end=/>/']
   \   }
   \ }
   \ }

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_semantic_triggers = {'haskell' : ['.']}

" Syntastic settings

" Make syntastic work nicer
let g:syntastic_enable_balloons = 1
" pylint gives me the shits.
let g:syntastic_python_checkers = ['flake8', 'pyflakes']
" Don't whinge about c++11, you brat!
let g:syntastic_cpp_compiler_options = '-I${HOME}/openmpi/env/include -std=c++11'
let g:syntastic_auto_loc_list=1

map <leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" NERDCommenter settings
let NERDSpaceDelims=1
" Set default haskell comment to be -- (first line should work, but doesn't)
" let NERD_haskell_alt_style=1
let g:NERDCustomDelimiters = {
    \ 'haskell': { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
\ }

" Use <leader>/ to toggle comment
map <leader>/ <leader>c<space>

" Map f8 for Tagbar
map <F8> :TagbarToggle<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" gitgutter config
map <leader>gt :GitGutterToggle<CR>
map <leader>gh :GitGutterLineHighlightsToggle<CR>

" Use powerline fonts
" Doesn't work for some reason (TODO)
let g:airline_powerline_fonts = 1
let g:airline_theme='murmur'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = '⎘ ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" " airline symbols
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" Haskell syntax highlighting
let g:haskell_enable_quantification = 1 " enable highlighting of forall
let g:haskell_enable_recursivedo = 1 " enable highlighting of mdo and rec
let g:haskell_enable_arrowsyntax = 1 " enable highlighting of proc
let g:haskell_enable_pattern_synonyms = 1 " enable highlighting of pattern
let g:haskell_enable_typeroles = 1 " enable highlighting of type roles
let g:haskell_enable_static_pointers = 1 " enable highlighting of static
