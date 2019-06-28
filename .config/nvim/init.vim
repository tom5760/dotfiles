" Use :help <option> to see the documentation for the given option.

"" Load plugins

set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')

  call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/denite.nvim')

  "call dein#add('ctrlpvim/ctrlp.vim')

  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/nerdcommenter')

  call dein#add('icymind/NeoSolarized')
  call dein#add('vimwiki/vimwiki')

  "call dein#add('neoclide/coc.nvim', {'merge':0, 'build': './install.sh nightly'})

  call dein#add('HerringtonDarkholme/yats.vim', {'on_ft': 'typescript'})

  call dein#end()
  call dein#save_state()
endif

"" General options

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
set cursorcolumn
"set signcolumn=yes

set hidden
set lazyredraw

set scrolloff=2
set sidescrolloff=2

set list
let &showbreak = '↪ '
set listchars=tab:┊\ ,trail:⋅,extends:⇉,precedes:⇇,nbsp:␣

set undofile

set background=dark
set termguicolors
colorscheme NeoSolarized

" Close the preview window after selecting a completion.
autocmd CompleteDone * pclose

""" Keybindings """

" See :help Y
map Y y$

inoremap <silent><expr> <C-Space> <C-x><C-o>

" Use <C-n> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-n> :nohlsearch<CR><C-l>
"
" ^h ^l ^j ^k switches splits
noremap <silent> <C-h> <C-w>h
noremap <silent> <C-l> <C-w>l
noremap <silent> <C-j> <C-w>j
noremap <silent> <C-k> <C-w>k

" CTRL+A jumps to beginning of line in command window
cnoremap <C-A> <Home>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" For neovim node support
let g:node_host_prog = '/usr/bin/neovim-node-host'

"" For ctrlp
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_switch_buffer = '0'
"let g:ctrlp_match_current_file = 1
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --cached --others --exclude-standard']
"let g:ctrlp_mruf_relative = 1

"" For denite
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
\ ['git', 'ls-files', '--cached', '--others', '--exclude-standard'])

call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')

nnoremap <silent> <C-p> :<C-u>Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>

"" For NERDtree
map <C-S-b> :NERDTreeToggle<CR>
map <Leader>b :NERDTreeFind<CR>

"" For NERDcommenter
map <C-_> <plug>NERDCommenterToggle

"" For vimwiki
let g:vimwiki_list = [{'path': '~/documents/wiki/'}]

"" For vim-go
"let g:go_bin_path = "/home/tom/programs/go/tools"
"let g:go_info_mode = 'gopls'
"let g:go_def_mode = 'gopls'
"let g:go_fmt_command = "goimports"
"let g:go_fmt_experimental = 1
"let g:go_term_mode = 1

" For LanguageClient-neovim
"let g:LanguageClient_serverCommands = {
"\ 'typescript': ['/home/tom/programs/npm/bin/typescript-language-server', '--stdio']
"\ }

"function LC_maps()
  "if has_key(g:LanguageClient_serverCommands, &filetype)
    "nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
    "nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
    "nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    "nnoremap <buffer> <silent> <F5> :call LanguageClient_contextMenu()<CR>
    "nnoremap <buffer> <silent> <F5> :Denite contextMenu<CR>
    "set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
    "set signcolumn=yes
  "endif
"endfunction

"autocmd FileType * call LC_maps()
