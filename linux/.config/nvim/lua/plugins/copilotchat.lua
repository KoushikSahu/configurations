map("v", "<leader>h", ":CopilotChat<CR>")
map("n", "<leader>h", ":CopilotChatOpen<CR>")

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    cmd = { 'CopilotChat', 'CopilotChatOpen' },
    dependencies = {
      { "zbirenbaum/copilot.lua" },     -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }       -- for curl, log wrapper
    },
    opts = {
      debug = true,       -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'float',
        relative = 'cursor',
        width = 1,
        height = 0.4,
        row = 1
      }
    }
    -- See Commands section for default commands if you want to lazy load on them
  }
}
