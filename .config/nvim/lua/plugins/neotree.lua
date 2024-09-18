return {
	'nvim-neo-tree/neo-tree.nvim',
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	opts = {
		filesystem = {
			hijack_netrw_behavior = "open_current",
		},
		window = {
			width = 25,
		},
	},
	keys = {
		{
			'<C-b>', '<cmd>Neotree toggle<cr>',
			mode = '',
			desc = 'Toggle Neotree',
		},
		{
			'<leader>b', '<cmd>Neotree reveal<cr>',
			mode = '',
			desc = 'Reveal current file in neotree.',
		},
	},
}
