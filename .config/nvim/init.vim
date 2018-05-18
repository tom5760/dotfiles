" Use :help <option> to see the documentation for the given option.

set mouse=a
set nowrap

set ignorecase
set smartcase
set inccommand=nosplit

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set colorcolumn=80,120
set cursorline

set hidden
set lazyredraw

set scrolloff=2
set sidescrolloff=2

set list
set listchars=tab:┊\ ,trail:⋅,extends:⇉,precedes:⇇,nbsp:␣

set undofile

set background=dark
set termguicolors
colorscheme NeoSolarized

""" Keybindings """

" See :help Y
map Y y$

" Use <C-n> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-n> :nohlsearch<CR><C-l>
"
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

"" For deoplete
" Close the preview window when finished completion.
autocmd CompleteDone * silent! pclose!

"" For nerdtree
map <C-S-b> :NERDTreeToggle<CR>
map <Leader>b :NERDTreeFind<CR>

"" For vimwiki
let g:vimwiki_list = [{'path': '~/documents/wiki/'}]
