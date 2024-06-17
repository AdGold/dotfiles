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

" Bundle 'Valloric/YouCompleteMe'
" Bundle 'rdnetto/YCM-Generator'
" Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Plugin 'KabbAmine/zeavim.vim'

" Auto switch to paste
Plugin 'ConradIrwin/vim-bracketed-paste.git'

" Better JS support
" Bundle 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Typescript
Plugin 'leafgarland/typescript-vim'
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
" Bundle 'klen/python-mode'
" Bundle 'python-mode/python-mode'
" Colour scheme
" Bundle 'nanotech/jellybeans.vim'
Plugin 'dracula/vim', { 'name': 'dracula' }
" Plugin 'zenorocha/dracula-theme',{'rtp':'vim/'}
" Nice status bar
Bundle 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Better C++ highlighting
Bundle 'octol/vim-cpp-enhanced-highlight'
" Rainbow!!!
Plugin 'luochen1990/rainbow'
" Better Haskell indenting/highlighting
Bundle 'neovimhaskell/haskell-vim'
" Haskell completion
Bundle 'eagletmt/neco-ghc'
" Language aware commenting
Bundle 'scrooloose/nerdcommenter'
" File browser
Bundle 'scrooloose/nerdtree'
" MiniZinc highlighting
Plugin 'vale1410/vim-minizinc'

" Useful text objects"
Bundle 'wellle/targets.vim'
" Move arguments/items sideways
Bundle 'AndrewRadev/sideways.vim'
" move inside identifiers
Plugin 'bkad/CamelCaseMotion'

" vim-scripts
" List tasks/todos
Bundle 'TaskList.vim'
" General helper utils
Bundle 'L9'
" Make Latex files nicer
Bundle 'Latex-Text-Formatter'
Plugin 'lervag/vimtex'

" Debugging in vim
Plugin 'joonty/vdebug'

" vim - tmux interoperability
Plugin 'christoomey/vim-tmux-navigator'

" Fancy icons
" Plugin 'ryanoasis/vim-devicons'

call vundle#end()
" }}}
" }}}
" General editing {{{

let mapleader=" "
let maplocalleader=" "

filetype plugin indent on

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=50	            	" keep 50 lines of command line history

" Indicate we're on a fast terminal connection
set ttyfast

" don't clutter dir with backups/swap
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" simple word count
nnoremap <leader>cw :!wc -w %<CR>

" wild menu
" set wildmenu                    " Make completion useful: show a navigable menu for tab completion
set wildignore+=.svn,CVS,.git,*.pyc,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam,*/tmp/*,*.zip,log/**,node_modules/**,target/**,tmp/**,*.rbc    " Ignore these files when completing names and in Explorer
set wildmode=list:longest,list:full  " List all matches and complete till longest common string, or complete first match

" }}}
" Useful maps {{{
" Edit vimrc easier
nnoremap <leader>cv :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>:filetype detect<CR>

nnoremap ; :
vnoremap ; :
vnoremap S :sort<CR>
nnoremap S :w<CR>
nnoremap Q :q<CR>

" Dot command works on ranges
xnoremap . :normal .<CR>
" Switch mode using jk
inoremap jk <esc>
" needed so that vim still understands escape sequences
inoremap <esc>^[ <esc>^[

" C-v is mapped to paste so remap
nnoremap <C-m> <C-v>
nnoremap <leader>m <C-v>

" CtrlP shortcut
map <leader>p <C-p>

" Push argument in parameter list forward/backward
nnoremap <leader>k :SidewaysRight<CR>
nnoremap <leader>j :SidewaysLeft<CR>

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

let g:dracula_colorterm=0
colorscheme dracula
" highlight Normal ctermbg=None

set ruler	                	" show the cursor position all the time
set showcmd	                	" display incomplete commands
set number 		              	" show line numbers
set relativenumber              " make line numbers relative
set laststatus=2                " Make last window always have a status line

" }}}
" Folding {{{
set foldenable
set foldmethod=syntax
set foldopen=block,hor,percent,quickfix,tag
set foldlevel=99
highlight Folded ctermfg=lightblue ctermbg=None

" Make folds persistent
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
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
" Config file settings {{{
augroup filetype_conf
    autocmd!
    autocmd FileType vim,tmux,zsh setlocal foldmethod=marker
    autocmd FileType vim,tmux,zsh setlocal foldlevel=0
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

if has('mouse')
  set mouse=a
endif
" }}}
" Compilation cmds {{{
" compiling with make
set makeprg=make\ -B\ %:r\ CXXFLAGS=\"-g\ -std=c++20\"
autocmd FileType c noremap <F5> :make<CR>
autocmd FileType c noremap <F6> :!./%:r<CR>
autocmd FileType cpp noremap <F5> :make<CR>
autocmd FileType cpp noremap <F6> :!./%:r<CR>

" Typescript test/lint
autocmd FileType typescript noremap <leader>f :w<CR>:!npm run fix<CR>
autocmd FileType typescript noremap <F6> :!npm run test<CR>

" latex compile
" autocmd FileType tex noremap <F5> :!latexmk % -pdf<CR>
autocmd FileType tex noremap <F5> :!latexmk -e '$pdflatex=q/pdflatex \%O -shell-escape \%S/' % -pdf<CR>
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
" covered by vim-tmux-navigator
" nnoremap <silent> <C-Up> :wincmd k<CR>
" nnoremap <silent> <C-Down> :wincmd j<CR>
" nnoremap <silent> <C-Left> :wincmd h<CR>
" nnoremap <silent> <C-Right> :wincmd l<CR>

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
" Javascript/Typescript improvements {{{
" Javascript folding that doesn't suck

autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab

augroup javascript_folding
    autocmd!
    autocmd FileType javascript setlocal foldmethod=syntax
augroup END
" }}}
" }}}
" Plugin settings {{{
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
let g:syntastic_enable_balloons = 0
" let g:syntastic_python_checkers = ['flake8', 'pyflakes']
let g:syntastic_cpp_compiler_options = '-I${HOME}/openmpi/env/include -std=c++20'
" let g:syntastic_typescript_checkers = ['eslint']
let g:syntastic_aggregate_errors = 0
" let g:syntastic_debug = 1
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_auto_loc_list=1

noremap <leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠️"
let g:syntastic_style_error_symbol = '⁉️'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" }}}
" NERDCommenter settings {{{
let NERDSpaceDelims=1
" Set default haskell comment to be -- (first line should work, but doesn't)
" let NERD_haskell_alt_style=1
let g:NERDCustomDelimiters = {
    \ 'haskell': { 'left': '--', 'leftAlt': '{-', 'rightAlt': '-}' },
    \ 'zinc': { 'left': '%', 'leftAlt': '/*', 'rightAlt': '*/' },
    \ 'python': { 'left': '#', 'leftAlt': "'''", 'rightAlt': "'''" },
    \ 'pyrex': { 'left': '#', 'leftAlt': "'''", 'rightAlt': "'''" },
\ }

" Use <leader>/ to toggle comment
map <leader>/ <leader>c<space>
" }}}
" Powerline/airline settings {{{
" Use powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
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

" enable folding
let g:pymode_folding = 1

" python3
let g:pymode_python = 'python3'

" use <leader>p for pdb breakpoint
let g:pymode_breakpoint_bind = '<leader>p'

" Don't automatically regenerate rope project cache on saving changes
let g:pymode_rope_regenerate_on_write = 0
" }}}
" Misc plugin settings {{{
" This allows jsx syntax highlighting in js files
let g:jsx_ext_required = 0

" NERDTree settings
noremap <C-N> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Map f8 for Tagbar
noremap <F8> :TagbarToggle<CR>

" gitgutter config
" noremap <leader>gt :GitGutterToggle<CR>
noremap <leader>gh :GitGutterLineHighlightsToggle<CR>

" create mappings for movement in identifiers
call camelcasemotion#CreateMotionMappings('<leader>')
map w <leader>w
map b <leader>b
map e <leader>e
" }}}
" }}}
