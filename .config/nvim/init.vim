"
" Environmnet
"
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

"
" General
"
set encoding=utf-8          " The encoding displayed
set fileencoding=utf-8      " The encoding written to file
syntax on                   " Enable syntax highlight
set ttyfast                 " Faster redrawing
set lazyredraw              " Only redraw when necessary
set cursorline              " Find the current line quickly.

"
" Plugins
"
call plug#begin()
" nord-vim colorscheme
Plug 'arcticicestudio/nord-vim'

" neomake
Plug 'neomake/neomake'

" rust support
Plug 'rust-lang/rust.vim'

" NERDTree
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }

" Async FuzzyFind
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'


" .editorconfig
Plug 'editorconfig/editorconfig-vim'

" linting engine
Plug 'w0rp/ale'

"
" End Plugins
"
call plug#end() " remember to :PlugInstall 

"
" => Plugin Related Configs
"

" Neomake async hooks
call neomake#configure#automake('w')

" Open NERDTree automatically when vim starts up
autocmd vimenter * NERDTree
"NERDTree
let g:NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeToggle<CR>

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" Linting

" fix files on save
let g:ale_fix_on_save = 1

" lint after 1000ms after changes are made both on insert mode and normal mode
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000

" use emojis for errors and warnings
let g:ale_sign_error = '✗\ '
let g:ale_sign_warning = '⚠\ '

" fixer configurations
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}

" make FZF respect gitignore if `ag` is installed
if (executable('ag'))
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif

"
" => Visual Related Configs
"
" 256 colors
set t_Co=256

" set colorscheme
colorscheme nord

" long lines as just one line (have to scroll horizontally)
set nowrap

" line numbers
set number

" show the status line all the time
set laststatus=2

" toggle invisible characters
set invlist
set list
set listchars=tab:¦\ ,trail:⋅,extends:❯,precedes:❮

"
" Keymappings
"

" copy and paste to/from vIM and the clipboard
nnoremap <C-y> +y
vnoremap <C-y> +y
nnoremap <C-p> +P
vnoremap <C-p> +P

" access system clipboard
set clipboard=unnamed

" swapfiles location
set backupdir=/tmp//
set directory=/tmp//

" map fzf to ctrl+p
nnoremap <C-P> :Files<CR>

"
" Indentation
"

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
" :help smarttab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Auto indent
" Copy the indentation from the previous line when starting a new line
set ai

" Smart indent
" Automatically inserts one extra level of indentation in some cases, and works for C-like files
set si
