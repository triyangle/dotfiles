let mapleader = "\<Space>"
let maplocalleader = ","

set textwidth=79
set wrap
set formatoptions+=tcqjn
set linebreak
set breakindent

set nrformats+=alpha

set cursorline
set cursorcolumn
set scrolloff=5
set timeoutlen=1000 ttimeoutlen=0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set ruler
set mouse=a
set incsearch
set ignorecase
set infercase
set smartcase
set autoread
au CursorHold * checktime
set omnifunc=syntaxcomplete#Complete
set showcmd
set modeline
set modelines=5
set hidden
set spelllang=en_us
set ttyfast

set undofile
set undodir=$HOME/.vim/undo

if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

set wildmenu
set wildignorecase
set wildmode=longest:full,full

if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
else
  set clipboard=unnamed
endif

call plug#begin()

" Plug 'Shougo/deoplete.nvim'

" Plug 'dundalek/lazy-lsp.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'github/copilot.vim'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['scheme', 'lisp', 'clojure'] }
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/is.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'tpope/vim-repeat'
Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
" Plug 'suan/vim-instant-markdown', { 'for': ['markdown'] }
Plug 'lvht/tagbar-markdown', { 'for': ['markdown'] }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
" Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-rsi'
Plug 'lervag/vimtex', { 'on': ['VimtexInverseSearch'], 'for': ['tex'] }
Plug 'sheerun/vim-polyglot'
" Plug 'dense-analysis/ale'
Plug 'tpope/vim-unimpaired'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-obsession'
Plug 'farmergreg/vim-lastplace'
Plug 'kshenoy/vim-signature'
Plug 'andymass/vim-matchup'
Plug 'alvan/vim-closetag', { 'for': ['html'] }
" Plug 'tpope/vim-sleuth'
Plug 'embear/vim-localvimrc'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'machakann/vim-highlightedyank'

" Plug 'benmills/vimux'
Plug 'triyangle/tmuxline.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'christoomey/vim-tmux-navigator'
"
" " YCMD notes: Need to compile with Python binary vim (brew/anaconda) was compiled with (or different Python version (2/3) )
" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py --all' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" OP visual mode .
vnoremap . :norm.<CR>
xnoremap . :norm.<CR>

xnoremap Q :'<,'>:normal @q<CR>

autocmd VimResized * wincmd =

"Show airline bar
set laststatus=2

syntax on

set number
set relativenumber
" set lazyredraw

"not recommended for now
"set nobackup

set backspace=indent,eol,start

filetype plugin indent on
autocmd FileType c,cpp,html,javascript,css,scheme,sql,vim,zsh,sh,bash,ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType Makefile setlocal noexpandtab
autocmd FileType crontab setlocal nowritebackup
autocmd FileType markdown,text,tex setlocal spell complete+=kspell,k,U,s,i,d,]
autocmd FileType * set formatoptions-=l
" autocmd FileType markdown,text setlocal wrap linebreak nolist
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END
:iabbrev </ </<C-X><C-O>

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <leader>s :mksession<CR>

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

nnoremap 0 g0
nnoremap $ g$
nnoremap ^ g^
nnoremap I g^i
nnoremap A g$a

nnoremap <expr> gj v:count ? 'gj' : 'j'
nnoremap <expr> gk v:count ? 'gk' : 'k'

nnoremap g0 0
nnoremap g$ $
nnoremap g^ ^
nnoremap gI I
nnoremap gA A

vnoremap <expr> j v:count ? 'j' : 'gj'
vnoremap <expr> k v:count ? 'k' : 'gk'

vnoremap 0 g0
vnoremap $ g$
vnoremap ^ g^
" vnoremap I g^i
" vnoremap A g$a

vnoremap <expr> gj v:count ? 'gj' : 'j'
vnoremap <expr> gk v:count ? 'gk' : 'k'

vnoremap g0 0
vnoremap g$ $
vnoremap g^ ^
vnoremap gI I
vnoremap gA A

noremap <F3> :call Spelling()<CR>
noremap <leader>3 :call Spelling()<CR>

nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

syntax enable
set background=dark
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
highlight Comment cterm=italic

let g:tex_flavor = 'latex'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_global_ycm_extra_conf = '~/dotfiles/config/vim/ycm/.ycm_extra_conf_c.py'
let g:ycm_confirm_extra_conf = 0

if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
" let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}

nmap <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0

" fzf settings
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Fuzzy-find with fzf
map <C-_> :FZF ~<cr>
nmap <C-_> :FZF ~<cr>

map \ :FZF /<cr>
nmap \ :FZF /<cr>

map <C-p> :Files<cr>
nmap <C-p> :Files<cr>

" View commits in fzf
nmap <Leader>c :Commits<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

"Nerdtree settings
"Open autmatically if no files specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Open automatically if starting from directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <Leader>e :NERDTreeToggle<CR>

"Close if only Nerdtree left
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Nerd commenter settings
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" https://github.com/scrooloose/nerdcommenter/issues/278
let g:NERDCustomDelimiters = {
      \ 'python': { 'left': '#', 'right': '' }
      \ }

" Easymotion settings
let g:EasyMotion_smartcase = 1
map <Leader><Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>L <Plug>(easymotion-overwin-line)

nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

set hlsearch
" let g:incsearch#auto_nohlsearch = 1
" map n  <Plug>(incsearch-nohl-n)
" map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)
nnoremap gD gD:nohl<CR>
nnoremap gd gd:nohl<CR>
nnoremap <silent> <ESC><ESC> :nohl<CR>

" insearch easymotion
" map <Leader><Leader>/ <Plug>(incsearch-easymotion-/)
" map <Leader><Leader>? <Plug>(incsearch-easymotion-?)
" map <Leader><Leader>g/ <Plug>(incsearch-easymotion-stay)

" function! s:config_fuzzyall(...) abort
"   return extend(copy({
"         \   'converters': [
"         \     incsearch#config#fuzzy#converter(),
"         \     incsearch#config#fuzzyspell#converter()
"         \   ],
"         \ }), get(a:, 1, {}))
" endfunction
"
" noremap <silent><expr> f/ incsearch#go(<SID>config_fuzzyall())
" noremap <silent><expr> f? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
" noremap <silent><expr> fg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1})) vim-easymotion

" function! s:config_easyfuzzymotion(...) abort
"   return extend(copy({
"         \   'converters': [incsearch#config#fuzzy#converter()],
"         \   'modules': [incsearch#config#easymotion#module()],
"         \   'keymap': {"\<CR>": '<Over>(easymotion)'},
"         \   'is_expr': 0,
"         \   'is_stay': 1
"         \ }), get(a:, 1, {}))
" endfunction
" noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
"
" " Ultisnips settings
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

" Gundo settings
nnoremap <Leader>u :GundoToggle<CR>

let g:instant_markdown_autostart = 0

" Markdown fenced code syntax highlighting
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages =
      \ ['java',
      \ 'scheme',
      \ 'python',
      \ 'sql',
      \ 'vim',
      \ 'viml=vim',
      \ 'bash=sh',
      \ 'tex',
      \ 'zsh',
      \ 'html',
      \ 'css',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=javascript']

" vim-markdown settings
let g:vim_markdown_folding_style_pythonic = 1
set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_toc_autofit = 1

let g:vim_markdown_fenced_languages =
      \ ['java',
      \ 'scheme',
      \ 'python',
      \ 'sql',
      \ 'vim',
      \ 'viml=vim',
      \ 'bash=sh',
      \ 'tex',
      \ 'zsh',
      \ 'html',
      \ 'css',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=javascript']

" Tabularize mappings
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" let g:polyglot_disabled = ['python']
" let g:polyglot_disabled = ['latex']

let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0
let g:localvimrc_event = ["BufReadPre"]

" let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:vimtex_view_automatic = 1
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_skim_skim_activate = 1
let g:vimtex_imaps_leader = ","
let g:vimtex_view_method = 'skim'
" let g:vimtex_view_general_viewer
"                 \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'

let g:tex_conceal="abdgm"
" let g:vimtex_compiler_progname = 'nvr'

let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

let g:matchup_surround_enabled = 1
let g:matchup_matchparen_deferred = 1
let g:matchup_override_vimtex = 1

"Easy buffer switching
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

" for tmux iterm2 cursor
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
" let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"

function! Spelling()
  setlocal spell!
  if &spell
    set complete+=kspell
    echo "Spell mode enabled"
  else
    set complete-=kspell
    echo "Spell mode disabled"
  endif
endfunction

inoremap <C-h> <c-g>u<Esc>[s1z=`]a<c-g>u
nnoremap <C-h> [s1z=

" Automatically install vim-plug and run PlugInstall if vim-plug is not found.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

augroup autoSaveAndRead
  autocmd!
  " autocmd TextChanged,InsertLeave,FocusLost * silent! wall
  autocmd CursorHold * silent! checktime
augroup END

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
