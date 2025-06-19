return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				spelling = {
					enabled = true,
				},
			},
			win = {
				border = "rounded",
        width = 0.2,
			},
		},
	},
	{ "nvim-tree/nvim-web-devicons" },
	{ "echasnovski/mini.icons", version = "*" },
}
