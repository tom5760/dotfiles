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
    git_files = {
      show_untracked = true,
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

local function project_files()
  local opts = {}
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

vim.keymap.set('n', '<C-p>', project_files)
