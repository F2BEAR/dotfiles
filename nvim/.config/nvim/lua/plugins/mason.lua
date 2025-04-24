return {
  {
    "williamboman/mason.nvim",
    opts = {
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

        -- Formatters
        "shfmt",
        "sql-formatter",
        "prettier",
        "stylua",

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
    opts = {
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
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")

      table.insert(
        opts.sources or {},
        null_ls.builtins.formatting.prettier.with({
          prefer_local = "node_modules/.bin",
          condition = function(utils)
            return not utils.root_has_file({
              ".prettierrc",
              ".prettierrc.js",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.toml",
              ".prettierrc.json5",
              "prettier.config.js",
              "prettier.config.cjs",
              ".prettierrc.cjs",
            })
          end,
          extra_args = {
            "--single-quote",
            "--trailing-comma",
            "all",
            "--use-tabs",
            "--tab-width",
            "2",
          },
        })
      )

      return opts
    end,
  },
}
