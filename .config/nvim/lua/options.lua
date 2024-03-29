vim.o.mouse    = 'a'
vim.o.wrap     = false
vim.o.undofile = true
vim.o.autoread = false
vim.o.title    = true
vim.o.clipboard = 'unnamedplus'

vim.o.ignorecase = true
vim.o.smartcase  = true
vim.o.inccommand = 'nosplit'

vim.o.expandtab     = false
vim.o.tabstop       = 8
vim.o.shiftwidth    = 8
vim.o.softtabstop   = 8
vim.o.textwidth     = 79
vim.o.formatoptions = 'jcrqlo'

vim.o.colorcolumn  = '80,120'
vim.o.cursorline   = true
vim.o.cursorcolumn = true

vim.o.scrolloff     = 2
vim.o.sidescrolloff = 2

vim.o.wildmode = 'longest:full,full'
vim.o.pumblend = 20

vim.o.list        = true
vim.o.showbreak   = '↪ '
vim.o.breakindent = true
vim.o.listchars   = 'tab:⤑ ,trail:·,extends:⇉,precedes:⇇,nbsp:␣'

vim.o.termguicolors  = true
vim.o.background     = 'dark'
vim.g.gruvbox_bold   = false
vim.g.gruvbox_italic = true
vim.cmd 'colorscheme gruvbox'

vim.o.completeopt = 'menu,longest,noinsert'

-- Disable built-in SQL mappings
vim.g.omni_sql_no_default_maps = 1

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
