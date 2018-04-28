" Don't try to be vi compatible
set nocompatible

" Use secure encryption by default
set cryptmethod=blowfish2

" Turn on syntax highlighting and plugins (for netrw
syntax on
filetype plugin on

" riot tags as html
au BufReadPost *.tag set syntax=html

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
set wildignore+=**/node_modules/**
set wildignore+=**/.git/**
set wildignore+=**/target/**

" Display all matching files when we tab complete
set wildmenu

" Security
set modelines=0

" Show file stats
set ruler

" Encoding
set encoding=utf-8

" Whitespace
set textwidth=79

" smartindent was replaced by cindent, which itself is only appropriate for C-style syntax
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Don't request to save buffer when going to the next one
set hidden
" Delete freedom in insert mode
set backspace=2
