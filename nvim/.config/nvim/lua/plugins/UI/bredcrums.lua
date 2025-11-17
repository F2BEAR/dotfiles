return {
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    opts = {
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = true,
      separator = " > ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
      click = true,
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    lazy = true,
    keys = {
      { "<leader>nb", "<cmd>Navbuddy<cr>", desc = "Nav Buddy" },
    },
    opts = {
      lsp = { auto_attach = true },
    },
  },
}
