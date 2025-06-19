return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	event = "VeryLazy",
	opts = { completions = { blink = { enabled = true } } },
	config = function(_, opts)
		require("render-markdown").setup(opts)
	end,
}
