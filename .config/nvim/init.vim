" Use :help <option> to see the documentation for the given option.

"" Plugins
call plug#begin('~/.config/nvim/vim-plug')
Plug 'neovim/nvim-lspconfig'

Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
Plug 'lifepillar/vim-solarized8'

Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

Plug 'vimwiki/vimwiki'

"Plug 'fatih/vim-go'

Plug 'godlygeek/tabular'

call plug#end()

"" General options

set hidden
set mouse=a
set nowrap
set undofile
set noautoread

set ignorecase
set smartcase
set inccommand=nosplit

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set textwidth=79
set formatoptions=jcrqlo

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

let $PAGER=''
let $MANPAGER=''

set termguicolors
set background=dark
let g:gruvbox_italic = '1'
colorscheme gruvbox

"colorscheme solarized8_high

" Some color overrides
" https://github.com/lifepillar/vim-solarized8/issues/65
"hi SpellBad ctermfg=NONE guifg=NONE
"hi Whitespace guifg=#555555 guibg=NONE guisp=NONE
"hi PreProc guifg=#ffb090 guibg=NONE guisp=NONE gui=NONE cterm=NONE
"hi Special guifg=#f7956c guibg=NONE guisp=NONE gui=NONE cterm=NONE

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
nnoremap <silent> <C-M-p> :Files<CR>

" For NERDtree
map <C-b> :NERDTreeToggle<CR>
map <Leader>b :NERDTreeFind<CR>

let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" For NERDcommenter
map <C-_> <plug>NERDCommenterToggle
let NERDDefaultAlign="start"

" For vimwiki
let g:vimwiki_list = [{
      \ 'path': '~/documents/notes/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md',
      \ 'diary_rel_path': 'journal/',
      \ 'diary_header': 'Journal',
      \ 'diary_index': 'index',
      \ 'auto_diary_index': 1 
      \ }]

" For vim-go
"let g:go_fmt_command = "goimports"
"let g:go_doc_popup_window = 1

" Use the current go module as the local module for goimports.
"autocmd FileType go let b:go_fmt_options = {
"  \   'goimports': '-local ' .
"  \   trim(system('cd '. shellescape(expand('%:h')) .'; and go list -m;')),
"  \ }

" Disable built-in SQL mappings
let g:omni_sql_no_default_maps = 1

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  --vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
  vim.api.nvim_command[[autocmd BufWritePre <buffer> lua goimports(1000)]]
end

function goimports(timeout_ms)
  vim.lsp.buf.formatting_sync({}, timeout_ms)

  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

nvim_lsp.gopls.setup {
  on_attach = on_attach,
  settings = {
    gopls = {
      ["local"] = "github.com/machineq",
      gofumpt = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}
EOF
