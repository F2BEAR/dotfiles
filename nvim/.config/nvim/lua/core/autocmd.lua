vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function()
    vim.o.winbar = ""
  end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
  callback = function()
    local navic = require("nvim-navic")
    if navic.is_available() then
      vim.o.winbar = "       %{%v:lua.require'nvim-navic'.get_location()%}"
    end
  end,
})
