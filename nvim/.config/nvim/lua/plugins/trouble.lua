return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {
      fold_open = "",
      fold_closed = "",
      focus = true,
      group = true,
      use_diagnostic_signs = true,
      win = {
        size = {
          height = 0.25,
          width = 1,
        },
        type = "split",
        border = "rounded",
      },
      preview = {
        type = "split",
        relative = "win",
        border = "rounded",
        position = "right",
        size = {
          height = 1,
          width = 0.5,
        },
        zindex = 200,
      },
    },
  },
}
