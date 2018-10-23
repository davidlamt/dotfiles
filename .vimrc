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

" ========== Plugins ==========

" Install vim-plug plugin manager if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Directory for plugins
call plug#begin('~/.vim/plugged')

" Linter
Plug 'w0rp/ale'

" Insert brackets, parems, and quotes in pair
Plug 'jiangmiao/auto-pairs'

" Quick HTML abbreviations
Plug 'mattn/emmet-vim'

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'

" Status bar
Plug 'vim-airline/vim-airline'

" Git workflow helper
Plug 'jreybert/vimagit'

" Dark theme
Plug 'tomasiser/vim-code-dark'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Better JavaScript indentation and syntax support
Plug 'pangloss/vim-javascript'

" Support for JSX
Plug 'mxw/vim-jsx'

" Status line for tmux
Plug 'edkolev/tmuxline.vim'

" Code completion
Plug 'Valloric/YouCompleteMe', { 'do' : '~/.vim/plugged/YouCompleteMe/install.py' }

" Initialize the plugin system
call plug#end()

" ===== ale =====

" Style the error and warning signs
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Fix JavaScript files using ESLint
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['eslint'],
\}

" Fix files on save
let g:ale_fix_on_save = 1

" ===== fzf.vim =====

" Open fuzzy finder with Ctrl + p
nnoremap <C-p> :Files<CR>

" Open buffer list with Ctrl + b
nnoremap <C-b> :Buffers<CR>

" Use ag instead of find to traverse the file system
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ===== tmuxline =====

" Remove separators
let g:tmuxline_powerline_separators = 0

" ===== vim-code-dark =====

colorscheme codedark

" ===== YouCompleteMe =====

" Close preview window once completion is accepted
let g:ycm_autoclose_preview_window_after_completion=1

" <leader>gd jumps to definition of the keyword under the cursor
nnoremap <leader>gd :YcmCompleter GoTo<CR>

" <leader>yr finds all references of the keyword under the cursor
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>

" <leader>yR renames the keyword under the cursor
nnoremap <leader>yR :YcmCompleter RefactorRename
