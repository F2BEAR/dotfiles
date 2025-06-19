return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    version = false,
    lazy = false,
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
          endpoint = "https://api.githubcopilot.com",
          model = "gpt-4o-2024-11-20",
          proxy = nil,
          allow_insecure = false,
          timeout = 30000,
          extra_request_body = {

            temperature = 0,
            max_tokens = 20480,
          },
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
    },
  },
}
