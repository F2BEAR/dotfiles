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
}
