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
set incsearch
set autoread
au CursorHold * checktime
set omnifunc=syntaxcomplete#Complete
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/rainbow_parentheses.vim'
Plugin 'majutsushi/tagbar'

call vundle#end()

"Show airline bar
set laststatus=2

syntax on

set number
set relativenumber
set cursorline

"not recommended for now
"set nobackup

set backspace=indent,eol,start

filetype plugin indent on
autocmd FileType html,scheme,sql setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType crontab setlocal nowritebackup
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END
:iabbrev </ </<C-X><C-O>

nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

vnoremap j gj
vnoremap k gk
vnoremap 0 g0
vnoremap $ g$
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

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
let g:syntastic_python_python_exec = 'python3'

let g:airline#extensions#tabline#enabled = 1

let g:ycm_python_binary_path = 'python3'

nmap <F8> :TagbarToggle<CR>

"Easy buffer switching
let mapleader = "\<Space>"
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>d :bd<cr>
