local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Mappings
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', 'gr', [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]], opts)
  buf_set_keymap('n', '<Leader>q', [[<Cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]], opts)

  local cmd = string.format([[<Cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols({hack = true, root_dir = '%s'})<CR>]], client.config.root_dir)
  buf_set_keymap('n', '<Leader>p', cmd, opts)

  vim.cmd [[
    command! Format execute 'lua vim.lsp.buf.formatting()'
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
  ]]
end

local function on_new_config(new_config, new_root_dir)
  local module = vim.trim(vim.fn.system({'go', 'list'}))

  if module then
    new_config.settings.gopls['local'] = module
  end
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt      = true,
      linksInHover = false,
    },
  },
  on_new_config = on_new_config,
}

