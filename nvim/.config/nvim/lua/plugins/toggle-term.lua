return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    cmd = "ToggleTerm",
    build = ":ToggleTerm",
    keys = { { "<F4>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" } },
    opts = {
      size = 15,
      open_mapping = "<F4>",
      direction = "horizontal",
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      close_on_exit = true,
      start_in_insert = true,
      persist_mode = false,
    },
  },
}
