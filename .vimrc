set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set autoindent
set smartindent
set ruler
set clipboard=unnamed
set mouse=a

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()

"Show airline bar
set laststatus=2

syntax on

set number
set cursorline

"not recommended for now
"set nobackup

set backspace=indent,eol,start

filetype plugin indent on
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2

nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

"Solarized dark
syntax enable
set background=dark
colorscheme solarized

"Recommended syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline#extensions#tabline#enabled = 1

