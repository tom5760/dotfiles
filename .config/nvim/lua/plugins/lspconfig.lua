-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach(client, bufnr)
	local ts_builtin = require('telescope.builtin')

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

	-- Mappings
	local opts = { buffer = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', 'gD',         vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', 'gd',         vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>',      vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<Leader>e',  vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '<Leader>f',  vim.lsp.buf.format, opts)

	vim.keymap.set('n', 'gr',        ts_builtin.lsp_references, opts)
	vim.keymap.set('n', '<Leader>q', ts_builtin.diagnostics, opts)
	vim.keymap.set('n', '<Leader>p', ts_builtin.lsp_dynamic_workspace_symbols, opts)
end

local function on_new_config(new_config, new_root_dir)
	local module = vim.trim(vim.fn.system({'go', 'list'}))

	if module then
		new_config.settings.gopls['local'] = module
	end
end

return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')

		lspconfig.gopls.setup {
			on_attach = on_attach,
			settings = {
				gopls = {
					gofumpt               = true,
					linksInHover          = false,
					completeFunctionCalls = false,
				},
			},
			on_new_config = on_new_config,
		}

		lspconfig.clangd.setup {
			on_attach = on_attach,
		}
	end,
}
