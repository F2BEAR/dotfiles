return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      LazyVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          LazyVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end
    end,
  },
}
