local lazypath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git', 'clone',
		'--filter=blob:none',
		'--branch=stable',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

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
vim.o.tabstop       = 4
vim.o.shiftwidth    = 4
vim.o.softtabstop   = 4
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
vim.o.listchars   = 'tab:│ ,lead:·,trail:·,extends:⇉,precedes:⇇,nbsp:␣'

vim.o.termguicolors  = true
vim.o.background     = 'dark'
vim.g.gruvbox_bold   = false
vim.g.gruvbox_italic = true
vim.cmd 'colorscheme gruvbox'

vim.o.completeopt = 'menu,longest,noinsert'
vim.opt.diffopt:append('linematch:60')

-- Disable built-in SQL mappings
vim.g.omni_sql_no_default_maps = 1

local augroup = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group    = augroup,
    callback = function() vim.highlight.on_yank() end,
})

-- Treat Avro schema files as JSON.
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    group   = augroup,
    pattern = "*.avsc",
    command = "setfiletype json",
})

-- Detect .gitconfig files 
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    group   = augroup,
    pattern = "*.gitconfig",
    command = "setfiletype gitconfig",
})

------------------
-- Key Mappings --
------------------

local map  = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- C-Space for omnicompletion
map('i', '<C-Space>', '<C-x><C-o>', opts)

-- Use C-n to clear highlighting of searches
map('n', '<C-n>', '<Cmd>nohlsearch<CR>', opts)

-- Use C-h C-l to move vertically between splits
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- C-a jumps to the beginning of the line in command mode.
map('c', '<C-a>', '<Home>', opts)

-- Maintain Visual Mode after shifting > and <
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
