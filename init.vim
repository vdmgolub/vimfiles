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


set mouse=n

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

" ================ Plugins ==============
call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'kristijanhusak/completion-tags'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-editors/vim-elixir'
Plug 'honza/vim-snippets'

Plug 'icymind/NeoSolarized'

Plug 'jgdavey/vim-blockle'
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/vim-easy-align'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nathanaelkane/vim-indent-guides'
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
Plug 'unblevable/quick-scope'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vimwiki/vimwiki'
Plug 'ruanyl/vim-gh-line'

call plug#end()

:lua << END
  require'lspinstall'.setup() -- important
  local servers = require'lspinstall'.installed_servers()

  require'lspconfig'.ruby.setup{on_attach=require'completion'.on_attach}
  local actions = require('telescope.actions')
  require('telescope').setup {
      defaults = {
          file_sorter = require('telescope.sorters').get_fzy_sorter,
          prompt_prefix = ' >',
          color_devicons = true,

          file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

          mappings = {
              i = {
                  ["<C-x>"] = false,
                  ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              },
          },

          preview_cutoff = 80,
      },
      extensions = {
          fzy_native = {
              override_generic_sorter = false,
              override_file_sorter = true,
          }
      }
  }
  require('telescope').load_extension('fzy_native')
END

autocmd BufEnter * lua require'completion'.on_attach()

" ================ Plugins settings ==============

" NERDTree
let NERDTreeMinimalUI  = 1
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize  = 30  " Window size
let NERDTreeDirArrows  = 1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

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
" let g:vue_disable_pre_processors=1
" autocmd FileType vue syntax sync fromstart
" autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" Vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" BufExplorer
let g:bufExplorerSplitOutPathName=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSplitVertSize=0

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Emmet
let g:user_emmet_leader_key=','

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>t <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>s <cmd>Telescope grep_string<cr>
nnoremap <leader>v <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>

" ================ Interface ====================

set background=dark
color neosolarized
set list listchars=tab:▸\ ,trail:·
set title
set cursorline
set guioptions-=L " Remove left scroll bar
set colorcolumn=80
" execute 'set colorcolumn=' . join(range(101,335), ',')

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
nnoremap <leader>v :BufExplorer<cr>
" nnoremap <leader>, :Rg<space>
" nnoremap <leader>,w :Rg<space><c-r><c-w><cr>
" nnoremap <silent><leader>t :Files<cr>
nnoremap <leader>f :b#<cr> " Switch between two recent buffers
nnoremap <silent><leader>l :set list!<cr>

nnoremap <silent><leader><space> :noh<cr>
nnoremap zz :wa<cr>
inoremap jj <esc>
inoremap qq <esc>
nnoremap <silent><leader>p :let @+=expand('%:p')<cr>
nnoremap <silent><leader>pl :let @+=expand('%:p') . ':' . line('.')<cr>
noremap <silent><leader>ph :Gbrowse<cr>
noremap <silent><leader>pg :Gbrowse!<cr>
noremap <silent><leader>gb :Git blame<cr>
nmap <c-g> :bnext<cr>
nmap <c-f> :bprevious<cr>
" nmap <c-n> :bdelete<cr>
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>co :copen<cr>


" Quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=150
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END


" Completion-nvim
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_confirm_key = ""
let g:completion_enable_server_trigger = 0
let g:completion_trigger_character = ['.', ':']
let g:completion_trigger_keyword_length = 3
let g:completion_chain_complete_list = {
    \'default' : [
    \    {'complete_items': ['lsp', 'buffer']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
    \}
" Fix for endwise
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>\<Plug>DiscretionaryEnd" :  "\<CR>\<Plug>DiscretionaryEnd"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

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
