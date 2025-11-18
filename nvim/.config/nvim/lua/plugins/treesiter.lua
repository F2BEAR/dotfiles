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
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "toml"
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autoinstall = true,
    },
  },
}
