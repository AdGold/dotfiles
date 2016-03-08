filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/Vundle.vim'

" My Bundles here:
"
" original repos on github
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'groenewege/vim-less'
Bundle 'ap/vim-css-color'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'sophacles/vim-bundle-mako'
Bundle 'klen/python-mode'
Bundle 'tpope/vim-abolish'
Bundle 'mjio/jellybeans.vim'
Bundle 'bling/vim-airline'
Bundle 'octol/vim-cpp-enhanced-highlight'
Plugin 'luochen1990/rainbow'
Plugin 'tpope/vim-obsession'
Plugin 'altercation/vim-colors-solarized'
Plugin 'KabbAmine/zeavim.vim'

Bundle 'ehamberg/vim-cute-python'
Bundle 'Twinside/vim-haskellConceal'
Bundle 'vim-scripts/Superior-Haskell-Interaction-Mode-SHIM'
" Bundle 'ujihisa/repl.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'Shougo/vimproc.vim'
" Bundle 'ervandew/supertab'
Bundle 'eagletmt/neco-ghc'
Bundle 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Bundle 'rdnetto/YCM-Generator'

" vim-scripts
Bundle 'L9'
Bundle 'TaskList.vim'
Bundle 'Latex-Text-Formatter'

call vundle#end()

let g:necoghc_enable_detailed_browse = 1

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

" haskell repl keymap
autocmd FileType haskell map <F5> :GhciFile<C-M><C-W>wA

" haskell type information
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> tt :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" supertab setup
" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" if has("gui_running")
  " imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
" else " no gui
  " if has("unix")
    " inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  " endif
" endif

" haskell supertab
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" nerdtree
map <C-N> :NERDTreeToggle<CR>

" The following maps the F8 key to toggle between hex and binary (while also setting the 
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

map <Leader>s :SyntasticToggleMode<CR>

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

map <C-B> <Space>c<Space>
map <F2> <Space>c<Space>

" Map f8 for Tagbar
map <F8> :TagbarToggle<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" gitgutter config
map <Leader>gt :GitGutterToggle<CR>
map <Leader>gh :GitGutterLineHighlightsToggle<CR>
