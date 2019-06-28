" Use :help <option> to see the documentation for the given option.

"" Plugins
call plug#begin('~/.config/nvim/vim-plug')

Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

"" General options

set hidden
set lazyredraw
set mouse=a
set nowrap
set undofile

set ignorecase
set smartcase
set inccommand=nosplit

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set colorcolumn=80,120
set cursorline
set cursorcolumn

set scrolloff=2
set sidescrolloff=2

set list
let &showbreak = '↪ '
let &listchars = 'tab:⤑ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣'

colorscheme solarized8_high

" Close preview window automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif

"" Keybindings

" See :help Y
map Y y$

" CTRL-Space opens omnicompletion
inoremap <C-Space> <C-x><C-o>

" Use <C-n> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-n> :nohlsearch<CR><C-l>

" ^h ^l ^j ^k switches splits
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-l> <C-w>l
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k

" CTRL+A jumps to beginning of line in command window
cnoremap <silent> <C-A> <Home>

" Maintain Visual Mode after shifting > and <
vnoremap <silent> < <gv
vnoremap <silent> > >gv

"" Plugin configuration

" FZF.vim
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! GFilesFallback()
  let output = system('git rev-parse --is-inside-work-tree') " Is there a faster way?
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

nnoremap <silent> <C-p> :call GFilesFallback()<CR>

" For NERDtree
map <C-S-b> :NERDTreeToggle<CR>
map <Leader>b :NERDTreeFind<CR>

" For NERDcommenter
map <C-_> <plug>NERDCommenterToggle

" For vimwiki
let g:vimwiki_list = [{'path': '~/documents/wiki/'}]

" For vim-go
let g:go_bin_path = "/home/tom/programs/go/tools/bin"
let g:go_info_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1
let g:go_term_mode = 1
