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
set shiftround
set ttimeout
set ttimeoutlen=50
set incsearch
set autoread
set mouse=a
set hlsearch
set ignorecase
set smartcase
set cursorline
set confirm
set shortmess+=a
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
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

if exists("&colorcolumn")
    set colorcolumn=80 " Color column 80 differently
endif

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

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
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

"" Colorscheme
set background=dark
colorscheme solarized

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

" For ctrlp
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_switch_buffer = 'v'

" vim-multiple-cursors
let g:multi_cursor_next_key='<C-m>'

" Extra filetypes
autocmd BufRead,BufNewFile *.hx setfiletype javascript
autocmd BufRead,BufNewFile *.less setfiletype css
autocmd BufRead,BufNewFile *.gradle setfiletype groovy

autocmd Filetype go setlocal noexpandtab

autocmd Filetype javascript setlocal tabstop=2
autocmd Filetype javascript setlocal shiftwidth=2
autocmd Filetype javascript setlocal softtabstop=2

autocmd Filetype html setlocal tabstop=2
autocmd Filetype html setlocal shiftwidth=2
autocmd Filetype html setlocal softtabstop=2

autocmd Filetype scss setlocal tabstop=2
autocmd Filetype scss setlocal shiftwidth=2
autocmd Filetype scss setlocal softtabstop=2

autocmd Filetype gitcommit setlocal spell
