let os = substitute(system('uname'), '\n', '', '')

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set autoindent
set smartindent
set ruler
set clipboard=unnamedplus
set mouse=a
set incsearch
set ignorecase
set smartcase
set autoread
au CursorHold * checktime
set omnifunc=syntaxcomplete#Complete

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe'
Plug 'junegunn/rainbow_parentheses.vim', { 'do': './install.py --clang-completer' }
Plug 'majutsushi/tagbar'

" OS specific plugins... for now
if os == 'Linux'
  Plug 'edkolev/tmuxline.vim'
  Plug 'tmux-plugins/vim-tmux'
endif

call plug#end()

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
autocmd FileType html,scheme,sql,vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
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
hi Normal ctermbg=none
highlight NonText ctermbg=none

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
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1

nmap <F8> :TagbarToggle<CR>

"Easy buffer switching
let mapleader = "\<Space>"
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>d :bd<cr>

function! OpenLines(nrlines, dir)
  let nrlines = a:nrlines < 2 ? 2 : a:nrlines
  let start = line('.') + a:dir
  call append(start, repeat([''], nrlines))
  if a:dir < 0
    normal! 2k
  else
    normal! 2j
  endif
endfunction
" Mappings to open multiple lines and enter insert mode.
nnoremap <Leader>o :<C-U>call OpenLines(v:count, 0)<CR>S
nnoremap <Leader>O :<C-U>call OpenLines(v:count, -1)<CR>S

nnoremap o o<esc>S
nnoremap O O<esc>S
