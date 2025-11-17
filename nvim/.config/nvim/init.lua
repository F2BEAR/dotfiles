local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Setting up <leader>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enabling diagnostic shit
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
  jump = {
    float = true,
  },
})

require("core.options")
require("core.keymaps")
require("core.autocmd")

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.UI" },
})
