local keymap = vim.keymap

-- General
keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- neo-tree
keymap.set("n", "<leader>e", function()
  require("lazy").load({ plugins = { "neo-tree.nvim" } })
  require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
end, { desc = "Toggle file explorer" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Mason
keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- Lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

-- Noice
keymap.set("n", "<leader>n", "<cmd>NoiceTelescope<CR>", { desc = "Opens Noice Telescope" })

-- Trouble
keymap.set("n", "<leader>td", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble" })

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
keymap.set("n", "<leader>s", "<cmd>FzfLua grep_project<cr>", { desc = "Search in project" })
keymap.set("n", "<leader>sf", "<cmd>FzfLua files<cr>", { desc = "Search files" })
keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Go to Definition" })
keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Go to Implementation" })
keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { desc = "Go to References" })
keymap.set("n", "gD", "<cmd>FzfLua lsp.buf.declaration<cr>", { desc = "Go to Declaration" })

-- Tiny Code Action
keymap.set("n", "<leader>c", function()
  require("tiny-code-action").code_action()
end, { noremap = true, silent = true, desc = "Tiny Code Action" })
