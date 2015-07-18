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
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'bufexplorer.zip'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'ervandew/supertab'
NeoBundle 'vdmgolub/vim-colors-solarized'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'matchit.zip'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle "MarcWeber/vim-addon-mw-utils" " snipmate dependency
NeoBundle "tomtom/tlib_vim" " snipmate dependency
NeoBundle 'garbas/vim-snipmate'
NeoBundle "honza/vim-snippets"
NeoBundle "vdmgolub/vim-snippets", { 'name': 'my-snippets' }
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'thoughtbot/vim-rspec'

filetype plugin indent on
NeoBundleCheck

call neobundle#end()

" ================ Plugins settings ==============

" NERDTree
let NERDTreeMinimalUI  = 1
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize  = 30  " Window size
let NERDTreeDirArrows  = 1

" NERDTreeTabs
let g:nerdtree_tabs_open_on_gui_startup = 0 " Auto open nerd tree on startup
let g:nerdtree_tabs_focus_on_files = 1      " Focus in the main content window

" Vim-Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_html_checkers = ['handlebars']

" CtrlP
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Default to filename searches - so that appctrl will find application
" controller
let g:ctrlp_by_filename = 1

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0

" Gist-vim
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'

" Indent Guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Vim-Rspec
let g:rspec_command = "!bin/rspec --no-color --format p {spec}"
let g:rspec_runner = "os_x_iterm"

" Solarized
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_hitrail=1

" ================ Interface ====================

set background=dark
color solarized
set guifont=Inconsolata-dz\ for\ Powerline:h16
set list listchars=tab:▸\ ,trail:·
set t_Co=256
set title
set cursorline
set guioptions-=L " Remove left scroll bar
execute 'set colorcolumn=' . join(range(81,335), ',')

set nowrap       " Don't wrap lines
set linebreak    " Wrap lines at convenient points

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Key mappings ====================

au FocusLost * :wa " Save all changes if focus lost

nnoremap <leader>e :NERDTreeTabsToggle<cr>
nnoremap <leader>b :BufExplorer<cr>
nnoremap <leader>a :Ag<space>
nnoremap <silent><leader>t :CtrlP<cr>
nnoremap <silent><leader>r :CtrlPTag<cr>
nnoremap <leader>f :b#<cr> " Switch between two recent buffers
nnoremap <leader>n :TagbarToggle<cr>
nnoremap <silent><leader>l :set list!<cr>

nnoremap <silent><leader><space> :noh<cr>
inoremap jj <esc>
nnoremap <leader>gt :w<cr>:call RunCurrentSpecFile()<cr>
nnoremap <leader>g :w<cr>:call RunNearestSpec()<cr>
nmap <c-g> :bnext<cr>
nmap <c-f> :bprevious<cr>
nmap <c-n> :bdelete<cr>

" ================ Plugins' default key mappings ====================

" <leader>ig :IndentGuidesToggle<cr> - Show/hide indentation levels
" gcc - comment/uncomment current line
" gc - comment/uncomment selection (or target - gcap - paragraph)
" TODO: add description for surround.vim

" ================ Navigation and scrolling ====================

nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

set ruler
set scrolloff=8         " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                " Enable ctrl-n and ctrl-p to scroll thru matches

" ================ Search =======================

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <tab> %
vnoremap <tab> %
