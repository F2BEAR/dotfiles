return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "prisma",
        "sql",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
    },
  }
}
