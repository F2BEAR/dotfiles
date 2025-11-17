return {
	{
		"williamboman/mason.nvim",
		opts = {
			PATH = "prepend",
			ensure_installed = {
				-- LSP servers
				"sqls",
				"lua-language-server",
				"prisma-language-server",
				"yaml-language-server",
				"marksman",
				"eslint-lsp",
				"json-lsp",
				"dockerfile-language-server",
				"docker-compose-language-service",
				"tailwindcss-language-server",
				"vtsls",
				"bash-language-server",
				"deno",

				-- Formatters
				"shfmt",
				"sql-formatter",
				"prettier",
				"stylua",
				"jq",
				"yamlfmt",

				-- Linters
				"shellcheck",
				"hadolint",
				"markdownlint-cli2",
				"markdown-toc",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
}
