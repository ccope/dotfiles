filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" Bundles
Bundle 'gmarik/Vundle.vim'
Bundle 'bogado/file-line'
" Syntax and Completion
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
" tagbar dep: apt-get install exuberant-ctags
Bundle 'majutsushi/tagbar' 
" VCS
Bundle 'tpope/vim-fugitive'
Bundle 'mhinz/vim-signify'
set rtp+=/home/cam/.vim/bundle/vim-lawrencium/
" File browsing/search
Bundle 'scrooloose/nerdtree'
Bundle 'ctrlpvim/ctrlp.vim'
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
Bundle 'tpope/vim-rbenv'
Bundle 'vim-ruby/vim-ruby'
" Go
Bundle 'fatih/vim-go'
" Tmux
Bundle 'christoomey/vim-tmux-navigator'
" Eye candy
Bundle 'nanotech/jellybeans.vim'
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/

colorscheme jellybeans
syntax on
filetype plugin indent on
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
au FileType ruby setlocal tabstop=2 expandtab shiftwidth=2 autoindent
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent omnifunc=pythoncomplete#Complete
au FileType puppet setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent
au FileType xml setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent
let g:SuperTabDefaultCompletionType = "context"
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set foldmethod=syntax
set foldlevel=99
set completeopt=menuone,longest,preview

" Auto-close doc window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Use python-mode instead of syntastic on py files
let g:syntastic_ignore_files = ['\.py$']
autocmd FileType python let g:syntastic_check_on_wq = 0

let g:pymode_options_max_line_length = 100
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_paths = ['/srv','/srv/server']

" Tagbar configuration for gotags. requires installing gotags.
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

nmap <F8> :TagbarToggle<CR>

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_auto_type_info = 1

au FileType go nmap <Leader>s <Plug>(go-implements)


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

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

set nomodeline
