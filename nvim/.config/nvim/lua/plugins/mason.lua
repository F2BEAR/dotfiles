return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "sqls",
        "lua_ls", -- lua-language-server
        "prismals", -- prisma-language-server
        "yamlls", -- yaml-language-server
        "marksman",
        "eslint", -- eslint-lsp
        "jsonls", -- json-lsp
        "dockerls", -- dockerfile-language-server
        "docker_compose_language_service",
        "tailwindcss", -- tailwindcss-language-server
        "vtsls", -- TypeScript/JavaScript server
        "bashls", -- bash-language-server

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
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")

      local function has_prettier_config(utils)
        return utils.root_has_file({
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
      end

      local prettier = null_ls.builtins.formatting.prettier.with({
        condition = has_prettier_config,
        dynamic_command = function(params)
          if has_prettier_config(params.utils) then
            return {
              "prettier",
              "--stdin-filepath",
              params.bufname,
            }
          else
            return {
              "prettier",
              "--stdin-filepath",
              params.bufname,
              "--single-quote",
              "--trailing-comma",
              "all",
              "--use-tabs",
              "--tab-width",
              "2",
            }
          end
        end,
      })

      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        -- Formatting
        prettier, -- Use our configured prettier
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.sql_formatter,

        -- Linting
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.markdownlint,
      })

      return opts
    end,
  },
}
