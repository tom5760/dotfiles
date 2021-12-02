local telescope = require('telescope')
local ext       = require('telescope._extensions')

-- hack to weight symbols by filename length, thus (hopefully) preferring
-- symbols from files in the local project.
local function hack_score(self, prompt, line, entry)
  local score = self.old_scoring_function(self, prompt, line, entry)

  local f = entry.filename
  local p = self.root_dir

  -- From: https://programming-idioms.org/idiom/167/trim-prefix/4291/lua
  f = (f:sub(0, #p) == p) and f:sub(#p+1) or f

  score = score * #f

  return score
end

local function hack_sorter(opts)
  local fzf_sorter = ext.manager.fzf.native_fzf_sorter()

  if opts.hack then
    fzf_sorter.old_scoring_function = fzf_sorter.scoring_function
    fzf_sorter.scoring_function = hack_score
    fzf_sorter.root_dir = opts.root_dir
  end

  return fzf_sorter
end

telescope.setup {
  defaults = {
    winblend = 10,
    preview = false,
    generic_sorter = hack_sorter,
  },
  pickers = {
    lsp_dynamic_workspace_symbols = {
      preview = true,
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
    },
  },
}

telescope.load_extension('fzf')

local map  = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- show file finder
map('n', '<C-p>', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
