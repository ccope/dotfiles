filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" Bundles
Bundle 'gmarik/Vundle.vim'
Bundle 'tpope/vim-rvm'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'alfredodeza/pytest'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'vim-scripts/matchit.zip'
Bundle 'greyblake/vim-preview'
Bundle 'airblade/vim-gitgutter'
Bundle 't9md/vim-chef'
Bundle 'klen/python-mode'
"Bundle 'jaxbot/github-issues.vim'
Bundle 'skalnik/vim-vroom'
Bundle 'kien/ctrlp.vim'
Bundle 'christoomey/vim-tmux-navigator'
" Color bundles
Bundle 'nanotech/jellybeans.vim'
Bundle 'twerth/ir_black'


syntax on
filetype plugin indent on
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set t_Co=256
au FileType ruby setlocal tabstop=2 expandtab shiftwidth=2 autoindent
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent omnifunc=pythoncomplete#Complete
au FileType xml setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent
let g:SuperTabDefaultCompletionType = "context"
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set foldmethod=indent
set foldlevel=99
set completeopt=menuone,longest,preview
function! s:DiffWithSaved()
	let filetype=&ft
	diffthis
	vnew | r # | normal! 1Gdd
	diffthis
	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
colorscheme jellybeans

let mapleader=" "
