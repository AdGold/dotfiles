" Vundle settings {{{
" Vundle init {{{
filetype off

set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" }}}
" Vundle packages {{{

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/Vundle.vim'

Bundle 'Valloric/YouCompleteMe'
Bundle 'rdnetto/YCM-Generator'
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
" MiniZinc highlighting
Plugin 'vale1410/vim-minizinc'

" Useful text objects"
" Bundle 'wellle/targets.vim'
" Move arguments/items sideways
Bundle 'AndrewRadev/sideways.vim'

" vim-scripts
" List tasks/todos
Bundle 'TaskList.vim'
" General helper utils
Bundle 'L9'
" Make Latex files nicer
Bundle 'Latex-Text-Formatter'

call vundle#end()
" }}}
" }}}
" General editing {{{

let mapleader=" "

filetype plugin indent on

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=50	            	" keep 50 lines of command line history

" Indicate we're on a fast terminal connection
set ttyfast

" don't clutter dir with backups/swap
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" }}}
" Useful maps {{{
" Edit vimrc easier
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>:filetype detect<CR>

" No need to press shift all the time
nnoremap ; :
vnoremap ; :

" Switch mode using jk
inoremap jk <esc>
vnoremap jk <esc>
inoremap <esc> <nop>

" Ranger
" noremap <C-a> :silent !ranger %:h<cr>:redraw!<CR>

" Sorting is useful
vnoremap S :sort<CR>

" C-v is mapped to paste so remap
nnoremap <C-m> <C-v>
nnoremap <leader>m <C-v>

" Push argument in parameter list forward/backward
nnoremap <leader>k :SidewaysRight<CR>
nnoremap <leader>j :SidewaysLeft<CR>
" using text objects from target.vim
" nmap <leader>k "zdIa"y2xvIava, jk"zp
" nmap <leader>j vIlav<leader>kvIlav

" }}}
" Indentation {{{
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" use set paste! instead of pastetoggle so that it redraws correctly
nnoremap <F3> :set paste!<cr>
" }}}
" Folding {{{
set foldenable
set foldmethod=syntax
set foldopen=block,hor,percent,quickfix,tag
set foldlevel=99
highlight Folded ctermfg=White ctermbg=black

" Make folds persistent
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" }}}
" Visual candy {{{

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

colorscheme jellybeans

set ruler	                	" show the cursor position all the time
set showcmd	                	" display incomplete commands
set number 		              	" show line numbers
set relativenumber              " make line numbers relative
set laststatus=2                " Make last window always have a status line

" }}}
" Undo settings {{{
" Configure persistent undo
if has('persistent_undo')
    " Enable/disable saving of undo history to an undo file
    set undofile

    " Directories to try for reading/writing undo files
    set undodir^=~/.vim/undo//
endif

" Make 'U' perform a redo operation (a sensible inverse of 'u')
nnoremap U <C-r>
" }}}
" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
augroup END
" }}}
" Write settings {{{
" Save on loss of focus
autocmd FocusLost * :silent! wall
" Automatically write changes to a file on certain commands
set autowrite

" Automatically reread externally modified files if unchanged in Vim
set autoread

" Display as much as possible of the last line
set display+=lastline

" Write the file via sudo
cnoremap w!! w !sudo tee % >/dev/null
" }}}
" Make search nice {{{
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader>y :noh<cr>

" ; is mapped to : so remap
nnoremap - ;

" replace mapping
nnoremap <leader>h :%s//c<Left><Left>
" }}}
" Movement {{{
set scrolloff=5

nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk

" Don't use arrow keys!!
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
" }}}
" QuickFix helpers {{{
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
" }}}
" Compilation cmds {{{
" compiling with make
set makeprg=make\ -B\ %:r\ CXXFLAGS=\"-g\ -std=c++11\"
autocmd FileType cpp noremap <F5> :make

" latex compile
autocmd FileType tex noremap <F5> :!pdflatex --halt-on-error %<CR>

" MiniZinc run
autocmd FileType zinc noremap <F5> :!minisearch %<CR>
" }}}
" Hex editor functionality {{{

" The following maps the F7 key to toggle between hex and binary (while also setting the 
" noeol and binary flags, so if you :write your file, vim doesn't perform unwanted conversions.

noremap <F7> :call HexMe()<CR>

let $in_hex=0
function! HexMe()
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

" }}}
" Clipboard stuff {{{
" Y should do what it's expected to do (d$, D, c$, C)
nnoremap Y y$

" system clipboard stuff, not sure how much is needed
set clipboard+=unnamed
set clipboard+=unnamedplus
set go+=a
"
" Allow Ctrl Shift C/V for copy/pasting to system
vnoremap <silent> <C-c> "+y
nnoremap <silent> <C-c> "+y
vnoremap <silent> <C-v> "+p
nnoremap <silent> <C-v> "+p
inoremap <silent> <C-v> <ESC>"+pa

" }}}
" Window management {{{
" Window splits {{{

" Remap ctrl+arrows to move between window splits
nnoremap <silent> <C-Up> :wincmd k<CR>
nnoremap <silent> <C-Down> :wincmd j<CR>
nnoremap <silent> <C-Left> :wincmd h<CR>
nnoremap <silent> <C-Right> :wincmd l<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" }}}
" Tabs {{{

noremap <leader>[ :tabprevious<CR>
noremap <leader>] :tabnext<CR>
" noremap <leader>t :tabedit<CR>

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

" }}}
" }}}
" Extended funcitonality {{{
" Apply macros to multiple lines {{{
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
" }}}
" Python virtualenv fixes {{{
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
" }}}
" QuickFix close {{{
" QuickFix close function; :q should close a window *and* the accompanying
" quickfix
augroup QFClose
  autocmd!
  " if |q| doesn't work use |cclose| ?
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
augroup END
" }}}
" Javascript folds {{{
" Javascript folding that doesn't suck
let javaScript_fold=1
autocmd FileType javascript call JavaScriptFold()
" }}}
" C++ Conceals {{{
" Conceal
set conceallevel=2
highlight Conceal ctermbg=234 ctermfg=81
function! SetCppConceals()
    syntax match cppSmartPtr "\(std::\)\?unique_ptr" conceal cchar=●
    syntax match cppSmartPtr "\(std::\)\?shared_ptr" conceal cchar=◆
    syntax match cppSmartPtr "\(std::\)\?weak_ptr" conceal cchar=▲
endfunction
autocmd FileType cpp call SetCppConceals()
" }}}
" }}}
" Plugin settings {{{
" Misc plugin settings {{{
let zinc_no_highlight_overlong = 1

" NERDTree settings
noremap <C-N> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Map f8 for Tagbar
noremap <F8> :TagbarToggle<CR>

" gitgutter config
" noremap <leader>gt :GitGutterToggle<CR>
noremap <leader>gh :GitGutterLineHighlightsToggle<CR>
" }}}
" Rainbow parenthesis settings {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
   \ 'ctermfgs': ['Darkblue', 'darkgreen', 'darkcyan', 'darkmagenta', 'grey', 'lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
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
" }}}
" YCM settings {{{
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python3'
let g:ycm_confirm_extra_conf = 0 
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:ycm_error_symbol = '✘'
let g:ycm_warning_symbol = '>'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_goto_buffer_command = 'vertical-split'

noremap <leader>gd :YcmCompleter GoTo<CR>
noremap <leader>gt :YcmCompleter GetType<CR>
noremap <leader>gf :YcmCompleter FixIt<CR>

" }}}
" Syntastic settings {{{

" Make syntastic work nicer
let g:syntastic_enable_balloons = 1
" pylint gives me the shits.
let g:syntastic_python_checkers = ['flake8', 'pyflakes']
" Don't whinge about c++11, you brat!
let g:syntastic_cpp_compiler_options = '-I${HOME}/openmpi/env/include -std=c++11'
let g:syntastic_auto_loc_list=1

noremap <leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" }}}
" NERDCommenter settings {{{
let NERDSpaceDelims=1
" Set default haskell comment to be -- (first line should work, but doesn't)
" let NERD_haskell_alt_style=1
let g:NERDCustomDelimiters = {
    \ 'haskell': { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'zinc': { 'left': '%', 'leftAlt': '/*', 'rightAlt': '*/' },
    \ 'python': { 'left': '#', 'leftAlt': "'''", 'rightAlt': "'''" },
\ }

" Use <leader>/ to toggle comment
map <leader>/ <leader>c<space>
" }}}
" Powerline/airline settings {{{
" Use powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='murmur'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = '⎘ ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" " airline symbols
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

" }}}
" Pymode settings {{{
" Py mode speedups
" Don't automatically run linter on saving changes
let g:pymode_lint_on_write = 0

" Don't automatically regenerate rope project cache on saving changes
let g:pymode_rope_regenerate_on_write = 0
" }}}
" Haskell settings {{{
let g:necoghc_enable_detailed_browse = 1

" haskell supertab
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Haskell syntax highlighting
let g:haskell_enable_quantification = 1 " enable highlighting of forall
let g:haskell_enable_recursivedo = 1 " enable highlighting of mdo and rec
let g:haskell_enable_arrowsyntax = 1 " enable highlighting of proc
let g:haskell_enable_pattern_synonyms = 1 " enable highlighting of pattern
let g:haskell_enable_typeroles = 1 " enable highlighting of type roles
let g:haskell_enable_static_pointers = 1 " enable highlighting of static
" }}}
" }}}
