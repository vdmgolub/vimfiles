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
au FocusGained * :checktime     " Workaround with file reload in nvim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" ================ Syntax highlighting ==============
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
let mapleader=","

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Runtime paths ==============

" Load FZF from homebrew installation
set runtimepath^=/usr/local/opt/fzf
runtime plugin/fzf.vim

" let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" ================ Plugins ==============
call plug#begin('~/.config/nvim/plugged')

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'albanm/vuetify-vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-editors/vim-elixir'
Plug 'honza/vim-snippets'
Plug 'icymind/NeoSolarized'
Plug 'jgdavey/vim-blockle'
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'amiralies/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vimwiki/vimwiki'
Plug 'ruanyl/vim-gh-line'

call plug#end()

" ================ Plugins settings ==============

" NERDTree
let NERDTreeMinimalUI  = 1
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize  = 35  " Window size
let NERDTreeDirArrows  = 1
let NERDTreeShowHidden  = 0

" NERDTreeTabs
let g:nerdtree_tabs_open_on_gui_startup = 0 " Auto open nerd tree on startup
let g:nerdtree_tabs_focus_on_files = 1      " Focus in the main content window

" Vim-Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#displayed_head_limit = 20

function! MyLineNumber()
  return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). ' | '.
    \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction

call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})
let g:airline_section_z = airline#section#create(['%3p%%: ', 'linenr', ':%3v'])

" Vim-Airline-Themes
let g:airline_theme='solarized'
let g:airline_solarized_bg = 'dark'

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['handlebars', 'eslint']
let g:syntastic_html_checkers = ['handlebars', 'eslint']

" Fzf
let g:fzf_preview_window = 'right:60%'

" Gist-vim
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'

" Indent Guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Solarized
set termguicolors
let g:neosolarized_hitrail=1

" Ripgrep
let g:rg_highlight=1
let g:rg_root_types=['!.git']

" vim-gh-line
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

" Vim-vue
let g:vue_disable_pre_processors=1
autocmd FileType vue syntax sync fromstart
" autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" BufExplorer
let g:bufExplorerSplitOutPathName=0
let g:bufExplorerShowRelativePath=1

" CoC
nmap <silent> gi <Plug>(coc-definition)
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
imap <C-l> <Plug>(coc-snippets-expand)

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <s-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> (pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>")
" Workaround for regular new lines
imap <expr> <CR> (pumvisible() ? "\<C-y>\<CR>\<Plug>DiscretionaryEnd" : "\<CR>\<Plug>DiscretionaryEnd")

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" ================ Interface ====================

set background=dark
color neosolarized
set list listchars=tab:▸\ ,trail:·
set title
set cursorline
set guioptions-=L " Remove left scroll bar
execute 'set colorcolumn=' . join(range(101,335), ',')

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

" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

nnoremap <leader>rc :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>e :NERDTreeToggle<cr>
" nnoremap <leader>e :Vexplore<cr>
nnoremap <leader>v :BufExplorer<cr>
nnoremap <leader>, :Rg<space>
nnoremap <leader>,w :Rg<space><c-r><c-w><cr>
nnoremap <silent><leader>t :Files<cr>
nnoremap <leader>f :b#<cr> " Switch between two recent buffers
nnoremap <leader>n :TagbarToggle<cr>
nnoremap <silent><leader>l :set list!<cr>

nnoremap <silent><leader><space> :noh<cr>
nnoremap zz :wa<cr>
inoremap jj <esc>
inoremap qq <esc>
nnoremap <leader>gt :w<cr>:call RunCurrentSpecFile()<cr>
nnoremap <leader>g :w<cr>:call RunNearestSpec()<cr>
nnoremap <silent><leader>p :let @+=expand('%:p')<cr>
nnoremap <silent><leader>pl :let @+=expand('%:p') . ':' . line('.')<cr>
noremap <silent><leader>ph :Gbrowse<cr>
noremap <silent><leader>pg :Gbrowse!<cr>
nmap <c-g> :bnext<cr>
nmap <c-f> :bprevious<cr>
nmap <c-n> :bdelete<cr>
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>co :copen<cr>

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
" nnoremap <tab> %
" vnoremap <tab> %
