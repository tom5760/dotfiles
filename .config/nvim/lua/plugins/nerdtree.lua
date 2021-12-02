local map  = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('', '<C-b>',     '<Cmd>NERDTreeToggle<CR>', opts)
map('', '<Leader>b', '<Cmd>NERDTreeFind<CR>',   opts)
