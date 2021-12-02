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
