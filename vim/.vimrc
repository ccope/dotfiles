if has('nvim')
  let s:editor_root=expand("~/.config/nvim")
else
  set nocompatible
endif

call plug#begin('~/.vim/plugged')
" Plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bogado/file-line'
" Syntax and Completion
Plug 'ervandew/supertab'
"Plug 'scrooloose/syntastic'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'tpope/vim-surround'
" Debugging
Plug 'phcerdan/Conque-GDB'
"Plug 'gilligan/vim-lldb'
" tagbar dep: apt-get install exuberant-ctags
"Plug 'majutsushi/tagbar'
" VCS
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
" File browsing/search
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/matchit.zip'
" Markdown viewer
Plug 'greyblake/vim-preview'
" Chef scripts
Plug 't9md/vim-chef'
" Python
if has('nvim')
  Plug 'zchee/deoplete-jedi'
endif
Plug 'davidhalter/jedi-vim'
" Ruby
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-rbenv'
Plug 'vim-ruby/vim-ruby'
" Go
Plug 'fatih/vim-go'
" Tmux
Plug 'christoomey/vim-tmux-navigator'
" Toml
Plug 'cespare/vim-toml'
Plug 'hashivim/vim-terraform'
" Eye candy
Plug 'nanotech/jellybeans.vim'
" Rust
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
call plug#end()

syntax on
set hidden
set nomodeline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set foldmethod=syntax
set foldlevel=99
set completeopt=menuone,longest,preview
au FileType go let g:go_highlight_functions = 1
au FileType go let g:go_highlight_methods = 1
au FileType go let g:go_highlight_structs = 1
au FileType go let g:go_auto_type_info = 1
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType puppet setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent
au FileType ruby setlocal tabstop=2 expandtab shiftwidth=2 autoindent
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
au FileType rust let rustc_sys_root = systemlist("rustc --print sysroot")[0]
au FileType rust let RUST_SRC_PATH = rustc_sys_root + "/lib/rustlib/src"
au FileType rust let g:racer_cmd = "~/.cargo/bin/racer"
au FileType xml setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4 autoindent
au BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"
let g:SuperTabDefaultCompletionType = "context"
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:jedi#completions_enabled = 0
endif

" Change leader to space
let mapleader=" "

colorscheme jellybeans
let g:airline_theme='jellybeans'

" Auto-close doc window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Use python-mode instead of syntastic on py files
"let g:syntastic_ignore_files = ['\.py$']
"autocmd FileType python let g:syntastic_check_on_wq = 0

" Tagbar configuration for gotags. requires installing gotags.
"let g:tagbar_type_go = {
"    \ 'ctagstype' : 'go',
"    \ 'kinds'     : [
"        \ 'p:package',
"        \ 'i:imports:1',
"        \ 'c:constants',
"        \ 'v:variables',
"        \ 't:types',
"        \ 'n:interfaces',
"        \ 'w:fields',
"        \ 'e:embedded',
"        \ 'm:methods',
"        \ 'r:constructor',
"        \ 'f:functions'
"    \ ],
"    \ 'sro' : '.',
"    \ 'kind2scope' : {
"        \ 't' : 'ctype',
"        \ 'n' : 'ntype'
"    \ },
"    \ 'scope2kind' : {
"        \ 'ctype' : 't',
"        \ 'ntype' : 'n'
"    \ },
"    \ 'ctagsbin'  : 'gotags',
"    \ 'ctagsargs' : '-sort -silent'
"\ }

"nmap <F8> :TagbarToggle<CR>

" Set GDB leader
let g:ConqueGdb_Leader = '\'
let g:ConqueGdb_GdbExe = "rust-gdb"
" let g:lldb_map_Lbreakpoint = "\b"
" let g:lldb_map_Lcontinue = "\c"
" let g:lldb_map_Lprint = "\p"
" let g:lldb_map_Lrun = "\r"
" let g:lldb_map_Lstep = "\s"
" let g:lldb_map_Lstepin = "\i"

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
