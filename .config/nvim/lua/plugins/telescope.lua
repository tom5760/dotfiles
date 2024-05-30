local function project_files()
	local builtin = require('telescope.builtin')

	local opts = {}
	vim.fn.system('git rev-parse --is-inside-work-tree')
	if vim.v.shell_error == 0 then
		builtin.git_files(opts)
	else
		builtin.find_files(opts)
	end
end

return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	opts = {
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
	},
	init = function()
		require('telescope').load_extension 'fzf'
	end,
	keys = {
		{ '<C-p>', project_files },
	},
}
