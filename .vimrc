" ~/.vimrc
" Author: Tom Wambold <tom5760@gmail.com>

set nocompatible     " Don't try to be vi compatible

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=50
set incsearch
set autoread
set mouse=a
set hlsearch
set ignorecase
set smartcase
"set cursorline
set confirm
set shortmess+=a
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set history=1000
set hidden
set wildmode=list:longest
set lazyredraw
set laststatus=2
set ruler
set showcmd
set wildmenu
set viminfo^=!
set list
set colorcolumn=80

if !&scrolloff
  set scrolloff=3
endif
if !&sidescrolloff
  set sidescrolloff=3
endif
set display+=lastline

if &listchars ==# 'eol:$'
  set listchars=tab:\ \ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\ \ ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif

let s:dir = has('win32') ? '~/Application Data/Vim' : has('mac') ? '~/Library/Vim' : '~/.local/share/vim'
if isdirectory(expand(s:dir))
  if &directory =~# '^\.,'
    let &directory = expand(s:dir) . '/swap//,' . &directory
  endif
  if &backupdir =~# '^\.,'
    let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  endif
  if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
    let &undodir = expand(s:dir) . '/undo//,' . &undodir
  endif
endif
if exists('+undofile')
  set undofile
endif

if !exists('g:netrw_list_hide')
  let g:netrw_list_hide = '^\.,\~$,^tags$'
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

" Colorscheme
let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme base16-3024

"" Keybindings
" Use <C-n> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-n> :nohlsearch<CR><C-l>

" ^h ^l ^j ^k switches splits
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-l> <C-w>l
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k

" CTRL+A jumps to beginning of line in command window
cnoremap <C-A>     <Home>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" For ctrlp
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_switch_buffer = '0'
let g:ctrlp_match_current_file = 1

" Extra filetypes
autocmd BufRead,BufNewFile *.hx setfiletype javascript
autocmd BufRead,BufNewFile *.less setfiletype css
autocmd BufRead,BufNewFile *.gradle setfiletype groovy

autocmd Filetype go setlocal noexpandtab

autocmd Filetype gitcommit setlocal spell

" For vim-go
let g:go_def_reuse_buffer = 1
let g:go_auto_type_info = 1
let g:go_fmt_autosave = 1
let g:go_gorename_prefill = 0

au FileType go nmap <Leader>gd <Plug>(go-def-split)
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gr <Plug>(go-rename)
au FileType go nmap <Leader>gv <Plug>(go-vet)
au FileType go nmap <Leader>gb <Plug>(go-install)

" For Typescript tsuquyomi
let g:tsuquyomi_disable_default_mappings = 1
let g:tsuquyomi_disable_quickfix = 1
au FileType typescript nmap <Leader>td <Plug>(TsuquyomiDefinition)
au FileType typescript nmap <Leader>tb <Plug>(TsuquyomiGoBack)
au FileType typescript nmap <Leader>tr <Plug>(TsuquyomiReferences)
au FileType typescript nmap <buffer> <Leader>ti : <C-u>echo tsuquyomi#hint()<CR>
