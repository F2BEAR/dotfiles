return {
  { "AndreM222/copilot-lualine" },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "onedark",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = {
            statusline = {
              "dashboard",
              "neo-tree",
              "avante",
            },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = {
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              function()
                return vim.fn.expand("%:t")
              end,
            },
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                  return ""
                end
                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, client.name)
                end
                return "LSP: " .. table.concat(names, ", ")
              end,
              icon = "",
            },
          },
          lualine_x = {
            "diagnostics",
            {
              "copilot",
              symbols = {
                status = {
                  icons = {
                    enabled = " ",
                    sleep = " ",
                    disabled = " ",
                    warning = " ",
                    unknown = " ",
                  },
                  hl = {
                    enabled = "#50FA7B",
                    sleep = "#AEB7D0",
                    disabled = "#6272A4",
                    warning = "#FFB86C",
                    unknown = "#FF5555",
                  },
                },
                spinners = "dots",
                spinner_color = "#6272A4",
              },
              show_loading = true,
              show_colors = true,
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }
      return opts
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end,
  },
}
