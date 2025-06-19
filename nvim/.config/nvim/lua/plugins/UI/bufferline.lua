return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "thin",
					diagnostics = "nvim_lsp",
					always_show_bufferline = false,
					close_command = "bdelete! %d",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. count .. icon
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "",
							separator = true,
						},
					},
				},
			})
		end,
	},
}
