" Use :help <option> to see the documentation for the given option.

"" Plugins
call plug#begin('~/.config/nvim/vim-plug')

Plug 'HerringtonDarkholme/yats.vim'
Plug 'lifepillar/vim-solarized8'

Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

Plug 'vimwiki/vimwiki'

Plug 'fatih/vim-go'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

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
set textwidth=79

set colorcolumn=80,120
set cursorline
set cursorcolumn

set scrolloff=2
set sidescrolloff=2

set wildmode=longest:full,full
set pumblend=20

set list
let &showbreak = '↪ '
let &listchars = 'tab:⤑ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣'

set termguicolors
colorscheme solarized8_high

" Some color overrides
" https://github.com/lifepillar/vim-solarized8/issues/65
hi SpellBad ctermfg=NONE guifg=NONE
hi Whitespace guifg=#555555 guibg=NONE guisp=NONE
hi PreProc guifg=#ffb090 guibg=NONE guisp=NONE gui=NONE cterm=NONE
hi Special guifg=#f7956c guibg=NONE guisp=NONE gui=NONE cterm=NONE

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

" Wayland Clipboard

let g:clipboard = {
  \  'name': 'wl-clipboard',
  \  'copy': {
  \    '+': 'wl-copy',
  \    '*': 'wl-copy --primary',
  \  },
  \  'paste': {
  \    '+': 'wl-paste',
  \    '*': 'wl-paste --primary',
  \  },
  \}

"" Plugin configuration

" For neovim node support
let g:node_host_prog = '/usr/bin/neovim-node-host'

" FZF.vim
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! GFilesFallback()
  let output = system('git rev-parse --is-inside-work-tree')
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles --cached --others --exclude-standard\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

nnoremap <silent> <C-p> :call GFilesFallback()<CR>

" For NERDtree
map <C-S-b> :NERDTreeToggle<CR>
map <Leader>b :NERDTreeFind<CR>

let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" For NERDcommenter
map <C-_> <plug>NERDCommenterToggle
let NERDDefaultAlign="start"

" For vimwiki
let g:vimwiki_list = [{'path': '~/documents/wiki/'}]

" For vim-go
let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1
let g:go_doc_popup_window = 1

" Use the current go module as the local module for goimports.
autocmd FileType go let b:go_fmt_options = {
  \   'goimports': '-local ' .
  \   trim(system('cd '. shellescape(expand('%:h')) .'; and go list -m;')),
  \ }


" For LanguageClient-neovim
let g:LanguageClient_serverCommands = {
\ 'typescript': ['/home/tom/programs/npm/bin/typescript-language-server', '--stdio']
\ }

function LC_maps()
 if has_key(g:LanguageClient_serverCommands, &filetype)
   nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
   nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
   nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
   nnoremap <buffer> <silent> <F5> :call LanguageClient_contextMenu()<CR>
   nnoremap <buffer> <silent> <A-.> :call LanguageClient#textDocument_codeAction()<CR>
   set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
   set signcolumn=yes
 endif
endfunction

autocmd FileType * call LC_maps()

"" Function to test key code
"function! s:getchar() abort
"  redraw | echo 'Press any key: '
"  let c = getchar()
"  while c ==# "\<CursorHold>"
"    redraw | echo 'Press any key: '
"    let c = getchar()
"  endwhile
"  redraw | echomsg printf('Raw: "%s" | Char: "%s"', c, nr2char(c))
"endfunction
"command! GetChar call s:getchar()
