return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "ibhagwan/fzf-lua" },
    },
    event = "LspAttach",
    config = function()
      require("tiny-code-action").setup({
        backend = "vim",
        picker = "fzf-lua",
        signs = {
          quickfix = { "󰁨", { link = "DiagnosticInfo" } },
          others = { "?", { link = "DiagnosticWarning" } },
          refactor = { "", { link = "DiagnosticWarning" } },
          ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
          ["refactor.extract"] = { "", { link = "DiagnosticError" } },
          ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
          ["source.fixAll"] = { "", { link = "DiagnosticError" } },
          ["source"] = { "", { link = "DiagnosticError" } },
          ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
          ["codeAction"] = { "", { link = "DiagnosticError" } },
        },
        notify = {
          enable = true,
          on_empty = true,
        },
      })
    end,
    keys = {
      {
        "<leader>ca",
        function()
          require("tiny-code-action").code_action()
        end,
        mode = { "n", "v" },
        desc = "Code Action",
      },
    },
  },
}
