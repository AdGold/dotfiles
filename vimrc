filetype plugin indent on

" colorscheme jellybeans

" general editing
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=50	            	" keep 50 lines of command line history
set ruler	                	" show the cursor position all the time
set showcmd	                	" display incomplete commands
set nu 		                	" show line numbers
set rnu
set incsearch	            	" do incremental searching

" compiling with make
set mp=make\ -B\ %:r\ CXXFLAGS=\"-g\ -std=c++11\"
set aw

" The following maps the F8 key to toggle between hex and binary (while also setting the 
" noeol and binary flags, so if you :write your file, vim doesn't perform unwanted conversions.

noremap <F8> :call HexMe()<CR>

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" indentation
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

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

" Allow Ctrl Shift C/V for copy/pasting to system
vmap <silent> <C-c> "+y
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

" bgbn fixes, re-add if things break

if 0
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


endif
