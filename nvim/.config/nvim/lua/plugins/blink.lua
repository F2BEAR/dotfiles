return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
    },
    version = "1.*",
    event = "VeryLazy",
    ---@module 'blink.cmp'
    opts = {
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          "exact",
          "score",
        },
      },
      sources = {
        default = {
          "lazydev",
          "lsp",
          "path",
          "buffer",
          "copilot",
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      completion = {
        menu = {
          border = "rounded",
          scrollbar = false,
        },
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
      },
      keymap = {
        preset = "super-tab",
      },
    },
    opts_extend = { "sources.default" },
  },
}
