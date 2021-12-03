" let g:python3_host_prog = '~/anaconda3/envs/ml/bin/python'

call plug#begin('$HOME/.local/share/nvim/plugged/')
Plug 'mhinz/vim-startify'
" status bar
Plug 'vim-airline/vim-airline'
" git
Plug 'airblade/vim-gitgutter'
" file manager
Plug 'scrooloose/nerdtree'
" vim undo tree
Plug 'simnalamburt/vim-mundo'
" full path fuzzy file, buffer ... finder for vim
Plug 'kien/ctrlp.vim'
" autocompletion 
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
" insert, delete brackets in pairs
Plug 'jiangmiao/auto-pairs'
Plug 'mhartington/oceanic-next'
" tab completion
Plug 'ervandew/supertab'
" js linting
Plug 'w0rp/ale'
call plug#end()

" preview (docstring), noselect, longest, menuone
" set cot=menu,noinsert,preview
" set winfixheight
set previewheight=3 
" completion
set wildmenu
" line numbers
set relativenumber
set number relativenumber
" search
set hlsearch
" error notifications
set noerrorbells
set novisualbell
" bracket matching
set showmatch
" time out
set ttimeoutlen=10
" if file is changed out side of neovim reread it
set autoread
" ignore case in pattern
set ignorecase
" unsure -- todo
set nobackup
set nowb
set noswapfile
" tabs unsure -- todo
set smarttab
" uses spaces instead of tabs
set expandtab
" default (off ) buffers
set hidden
set encoding=utf-8
set foldenable
set foldmethod=indent
set foldlevelstart=20
set splitbelow
set splitright
set scrolloff=2
" set clipboard+=unnamedplus
set undofile
set undodir=~/.nvim/undo
set pastetoggle=<F2>
set laststatus=2
" syntax
" set background=dark

if (has("termguicolor"))
        set termguicolors
endif

syntax enable
syntax on

let g:oceanic_next_terminal_bold=1
let g:oceanic_next_terminal_italic=1
colorscheme OceanicNext
let g:airline_theme="oceanicnext"

let g:jedi#force_py_version = 3
let g:jedi#use_tabs_not_buffers = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#statement_length = 5
let g:deoplete#sources#jedi#show_docstring = 1
" let g:deoplete#sources#jedi#python_path = '~/anaconda3/envs/ml/bin/python'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:gitgutter_map_keys = 0
let mapleader = "\<Space>"
let g:airline#extensions#ale#enabled = 1
nnoremap <Space> <nop>
nnoremap <leader>an :NERDTreeToggle<CR>
nnoremap <leader>od :e ~/dotfiles/nvim/init.vim<CR>
