local map  = vim.api.nvim_buf_set_keymap
local opts = { noremap = true, silent = true }

vim.wo.spell = true
vim.bo.formatoptions = vim.bo.formatoptions .. 't'

-- Insert the current date as a heading
map(0, 'n', '<Leader>d', '"=strftime("%A, %B %-e, %Y")<CR>P', opts)
