local telescope = require('telescope')
local builtin   = require('telescope.builtin')

telescope.setup {
  defaults = {
    winblend = 10,
    preview = false,
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    lsp_dynamic_workspace_symbols = {
      preview = true,
    },
    lsp_references = {
      preview = true,
    },
  },
}

telescope.load_extension('zf-native')

vim.keymap.set('n', '<C-p>', builtin.find_files)
