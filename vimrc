" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set relativenumber              " Relative numbers +
set number                      " Line numbers
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set gcr=a:blinkon0              " Disable cursor blink
set visualbell                  " No sounds
set autoread                    " Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
let mapleader=","

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ NeoBundle ==============

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'bufexplorer.zip'

filetype plugin indent on
NeoBundleCheck

" ================ Plugins settings ==============

" NERDTree
let NERDTreeMinimalUI  = 1
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize  = 40  " Window size
let NERDTreeDirArrows  = 0   " No arrows, just | + and ~

" NERDTreeTabs
let g:nerdtree_tabs_open_on_gui_startup = 0 " Auto open nerd tree on startup
let g:nerdtree_tabs_focus_on_files = 1      " Focus in the main content window


" ================ Interface ====================

color railscasts2
set guifont=Menlo:h16

" ================ Key mappings ====================

nnoremap <leader>n :NERDTreeTabsToggle<CR>
nnoremap <leader>b :BufExplorer<CR>

inoremap jj <ESC>

" ================ Navigation ====================

nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
