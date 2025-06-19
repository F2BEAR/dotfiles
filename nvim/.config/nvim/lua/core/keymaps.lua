local keymap = vim.keymap

-- neo-tree
keymap.set("n", "<leader>e", function()
  require("lazy").load({ plugins = { "neo-tree.nvim" } })
  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, { desc = "Toggle file explorer" })

-- Mason
keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- Lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

-- Noice
keymap.set("n", "<leader>n", "<cmd>NoiceTelescope<CR>", { desc = "Opens Noice Telescope" })

-- bufferline
keymap.set("n", "<leader>bd", "<cmd>bdelete!<CR>", { noremap = true, silent = true, desc = "Close current buffer" })
keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })

-- Delete all other buffers
keymap.set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete other buffers" })

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })

-- Inc-Rename
keymap.set("n", "<leader>r", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename word under cursor" })

-- FZF
keymap.set("n", "<leader>sb", "<cmd>FzfLua blines<cr>", { desc = "Search in buffers" })
keymap.set("n", "<leader>s", "<cmd> FzfLua grep_project<cr>", { desc = "Search in project" })

-- Tiny Code Action
keymap.set("n", "<leader>c", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = "Tiny Code Action" })
