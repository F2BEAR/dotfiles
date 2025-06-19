return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			require("mason").setup()
			local masonlsp = require("mason-lspconfig")

			masonlsp.setup({
				automatic_installation = true,
				automatic_enable = true,
				ensure_installed = {
					"sqls",
					"lua_ls",
					"prismals",
					"yamlls",
					"marksman",
					"eslint",
					"jsonls",
					"dockerls",
					"docker_compose_language_service",
					"tailwindcss",
					"vtsls",
					"bashls",
				},
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({})
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim" } },
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
										checkThirdParty = false,
									},
									telemetry = { enable = false },
								},
							},
						})
					end,
				},
			})
		end,
	},
}
