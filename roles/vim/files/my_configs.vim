" use vim settings, rather then vi settings
set nocompatible

" make , the leader key
let mapleader=","

" do not create backups
set noswapfile
set nobackup
set nowritebackup

" turn on line numbering
set number
set relativenumber
" set relativenumber only in normal mode
augroup toggle_relative_number
autocmd InsertEnter * :setlocal norelativenumber
autocmd InsertLeave * :setlocal relativenumber

" show incomplete command
set showcmd

" show a menu when using tab completion
set wildmenu

" highlight search
set hlsearch

" find the next match as we type the search
set incsearch

" ignore case when searching unless you type a capital
set ignorecase
set smartcase

" set indentation
set autoindent
filetype plugin indent on    " smart auto indentation (instead of old smartindent option)

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with ‘>’, use 4 spaces width
set shiftwidth=4

" on pressing tab, insert 4 spaces instead of tab
set expandtab

" tell vim what kind of background and colorscheme is used
set background=dark
colorscheme desert

" show the cursor position
set ruler

" always display the status bar
set laststatus=2

" allow backspacing over indention, line breaks and insertion start
set backspace=indent,eol,start

" disable beep on errors
set noerrorbells

" flash the screen instead of beeping on errors
set visualbell

" set bigger history of executed commands
set history=1000

" automatically re-read files if unmodified inside vim
set autoread

" manage multiple buffers effectively
set hidden

" use an encoding that supports unicode
set encoding=utf-8

" don’t wrap lines
"set nowrap

" wrap lines at convenient points, avoid wrapping a line in the middle of a word
set linebreak

" enable syntax highlighting
syntax enable

" display a confirmation dialog when closing an unsaved file
set confirm

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir    " create this dir manually if it does not exist

" move visual selection
" select a line or a number of lines with V and then move them up or down with J and K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" make . to work with visually selected lines
vnoremap . :normal.<CR>
