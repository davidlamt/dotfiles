" Do not try to be vi compatible (use awesome vim settings)
set nocompatible

" ========== General Settings ==========

" Allow backspace over automatically inserted indentation, line breaks, and from before insert mode is entered
set backspace=indent,eol,start

" Use spaces instead of tabs
set expandtab

" Allow switching buffers without saving
set hidden

" Highlight search results
set hlsearch

" Search is not case-sensitive
set ignorecase

" Search incrementally (show position of pattern during search)
set incsearch

" Always display status bar
set laststatus=2

" Show line numbers
set number

" Show current row and column (bottom right)
set ruler

" Set the number of columns with reindent operations (<< and >>)
set shiftwidth=2

" Auto indent based on code syntax
set smartindent

" Set the number of columns indented with 'Tab'
set softtabstop=2

" Default horizontal split to be below current pane
set splitbelow

" Default vertical split to be to the right of current pane
set splitright

" Turn on syntax highlighting
syntax on

" Ignore specific files and directories
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" ================ Backup Settings ===============

" These directories need to exist
" Double slash saves the original full path
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" ===== File Explorer =====

" Remove banner
let g:netrw_banner=0

" Set width to be 25% of window
let g:netrw_winsize=25

" ========== General Mappings ==========

" Avoid shift key when entering a command
nnoremap ; :

" Change leader to ,
let mapleader=','

" Ctrl + [h, j, k, l] to navigate panes
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

" Toggle file explorer with Ctrl + e
nnoremap <C-e> :Lexplore<CR>

" Map Ctrl + c to Esc
inoremap <C-c> <Esc>

" ========== Plugins ==========

" Install vim-plug plugin manager if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Directory for plugins
call plug#begin('~/.vim/plugged')

" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Better syntax highlighting for jsonc
Plug 'neoclide/jsonc.vim'

" Status line for tmux
" Only necessary to generate the snapshot 
" Plug 'edkolev/tmuxline.vim'

" Status bar
Plug 'vim-airline/vim-airline'

" Dark theme
Plug 'tomasiser/vim-code-dark'

" Better JavaScript indentation and syntax highlighting
Plug 'pangloss/vim-javascript'

" Better JSX indentation and syntax highlighting
Plug 'maxmellon/vim-jsx-pretty'

" Git workflow helper
Plug 'jreybert/vimagit'

" Initialize the plugin system
call plug#end()

" ===== coc =====

" Install missing coc extensions
let g:coc_global_extensions = ['coc-css', 'coc-eslint', 'coc-html', 'coc-json', 'coc-tsserver']

" Read tsconfig.json file as jsonc to allow for comments
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use gh to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list."
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" ===== fzf.vim =====

" Open fuzzy finder with Ctrl + p
nnoremap <C-p> :Files<CR>

" Open buffer list with Ctrl + b
nnoremap <C-b> :Buffers<CR>

" Use ag instead of find to traverse the file system
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" ===== tmuxline =====

" Remove separators
let g:tmuxline_powerline_separators = 0

" ===== vim-code-dark =====

colorscheme codedark
