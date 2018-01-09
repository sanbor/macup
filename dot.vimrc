" Don't try to be vi compatible
set nocompatible

" Use secure encryption by default
set cryptmethod=blowfish2

" Turn on syntax highlighting
syntax on

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

