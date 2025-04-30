return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettier")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(
        opts.sources,
        nls.builtins.formatting.prettier.with({
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
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "jq" },
        ["jsonc"] = { "jq" },
        ["yaml"] = { "yamlfmt" },
        ["markdown"] = { "markdown-toc" },
        ["markdown.mdx"] = { "markdown-toc" },
        ["lua"] = { "stylua" },
      },
    },
  },
}
