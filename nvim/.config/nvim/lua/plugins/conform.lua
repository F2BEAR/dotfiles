return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			sql = { "sql_formatter" },
			json = { "jq" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			jsx = { "prettier" },
			tsx = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			yaml = { "yamlfmt" },
			["*"] = {},
		},
	},
}
