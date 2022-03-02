syntax on
set t_Co=256

set modeline
set autoindent
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wildmode=longest,list
set backspace=indent,eol,start
set number
set exrc
set secure

let python_highlight_all=1
let python_slow_sync=1

filetype plugin indent on

let mapleader = "\<Space>"
let maplocalleader = ","

" set textwidth=79
set wrap
set formatoptions+=tcqjn
set linebreak
set breakindent

set nrformats+=alpha

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
 
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': ['scheme', 'lisp', 'clojure'] }
Plug 'majutsushi/tagbar'
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
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
" " Plug 'suan/vim-instant-markdown', { 'for': ['markdown'] }
Plug 'lvht/tagbar-markdown', { 'for': ['markdown'] }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': ['markdown'] }
" " " Plug 'yuttie/comfortable-motion.vim'
Plug 'tpope/vim-rsi'
Plug 'lervag/vimtex', { 'for': ['tex'] }
Plug 'sheerun/vim-polyglot'
" Plug 'w0rp/ale'
Plug 'tpope/vim-unimpaired'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-obsession'
Plug 'farmergreg/vim-lastplace'
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/matchit.zip'
Plug 'alvan/vim-closetag', { 'for': ['html'] }
" Plug 'tpope/vim-sleuth'
Plug 'embear/vim-localvimrc'
Plug 'machakann/vim-highlightedyank'

" Plug 'benmills/vimux'
Plug 'triyangle/tmuxline.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" " YCMD notes: Need to compile with Python binary vim (brew/anaconda) was compiled with (or different Python version (2/3) )
" Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clang-completer' }
 
call plug#end()

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
" set cursorline
" set lazyredraw

"not recommended for now
"set nobackup

set backspace=indent,eol,start

filetype plugin indent on
autocmd FileType html,javascript,css,scheme,sql,vim,zsh,sh,bash,ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType crontab setlocal nowritebackup
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

"Solarized dark
syntax enable
set background=dark
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
let g:gruvbox_italic=1
colorscheme gruvbox
highlight Comment cterm=italic

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_global_ycm_extra_conf = '~/dotfiles/config/vim/ycm/.ycm_extra_conf_c.py'
let g:ycm_confirm_extra_conf = 0

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
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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
let g:polyglot_disabled = ['latex']

let g:localvimrc_ask = 0

let g:vimtex_compiler_latexmk = {'callback' : 0}

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

" OS specific settings
" " can replace w/ new VTE settings?
" hi Normal ctermbg=none
" highlight NonText ctermbg=none
"
" if has("autocmd")
"   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"   au InsertEnter,InsertChange *
"         \ if v:insertmode == 'i' |
"         \   silent execute '!echo -ne "\e[6 q"' | redraw! |
"         \ elseif v:insertmode == 'r' |
"         \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"         \ endif
"   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif
"

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  " set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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

set grepprg=git\ grep\ -n\ $*

let g:gutentags_file_list_command = {
      \ 'markers': {
      \ '.git': 'git ls-files',
      \ '.hg': 'hg files',
      \ },
      \ }

" Automatically install vim-plug and run PlugInstall if vim-plug is not found.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" augroup autoSaveAndRead
"   autocmd!
"   " autocmd TextChanged,InsertLeave,FocusLost * silent! wall
"   autocmd CursorHold * silent! checktime
" augroup END
