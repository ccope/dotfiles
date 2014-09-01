filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" Bundles
Bundle 'gmarik/Vundle.vim'
" Syntax and Completion
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
" Git
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
" File browsing/search
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/matchit.zip'
" Markdown viewer
Bundle 'greyblake/vim-preview'
" Chef scripts
Bundle 't9md/vim-chef'
" Python
Bundle 'klen/python-mode'
Bundle 'alfredodeza/pytest'
" Ruby
Bundle 'skalnik/vim-vroom'
" Tmux
Bundle 'christoomey/vim-tmux-navigator'
" Eye candy
Bundle 'Lokaltog/powerline'
Bundle 'nanotech/jellybeans.vim'
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

colorscheme jellybeans
syntax on
filetype plugin indent on
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
au FileType ruby setlocal tabstop=2 expandtab shiftwidth=2 autoindent
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent omnifunc=pythoncomplete#Complete
au FileType xml setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent
let g:SuperTabDefaultCompletionType = "context"
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set foldmethod=indent
set foldlevel=99
set completeopt=menuone,longest,preview

" Allow synastic to work with python-mode
let g:pymode_lint = 0

" Change leader to space
let mapleader=" "

" Custom Functions
function! s:DiffWithSaved()
	let filetype=&ft
	diffthis
	vnew | r # | normal! 1Gdd
	diffthis
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

