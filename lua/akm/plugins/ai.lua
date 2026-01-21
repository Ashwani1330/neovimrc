-- lua/akm/plugins/ai.lua
-- AI-powered coding assistance (Full Copilot Stack)

return {
  -- 1. GITHUB COPILOT (The Engine)
  -- Handles ghost text completions as you type
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      -- Ghost Text Keymaps
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")',
        { expr = true, replace_keycodes = false, desc = "Copilot: Accept" })
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)", { desc = "Copilot: Accept word" })
      vim.keymap.set("i", "<C-H>", "<Plug>(copilot-dismiss)", { desc = "Copilot: Dismiss" })
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot: Next suggestion" })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot: Prev suggestion" })
    end,
  },

  -- 2. COPILOT CHAT (The Sidebar/Agent)
  -- Allows you to chat, ask for explanations, and fix bugs
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },    -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    -- build = "make tiktoken",       -- Only on MacOS or Linux
    opts = {
      debug = false,

      -- Window configuration (Floating or Sidebar)
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.3,         -- fractional width of parent, or absolute width in columns
        height = 0.5,        -- fractional height of parent, or absolute height in rows
        -- Options: 'split', 'float', 'tab'
        relative = "editor",
        border = "rounded",
      },
    },
    keys = {
      -- Chat Keymaps
      { "<leader>aa", ":CopilotChatToggle<CR>",  desc = "Copilot: Toggle Chat" },
      { "<leader>ae", ":CopilotChatExplain<CR>", desc = "Copilot: Explain Code",   mode = "v" },
      { "<leader>af", ":CopilotChatFix<CR>",     desc = "Copilot: Fix Bug",        mode = "v" },
      { "<leader>at", ":CopilotChatTests<CR>",   desc = "Copilot: Generate Tests", mode = "v" },

      -- Quick Chat (Ask a one-off question)
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Copilot: Quick Chat",
      },
    },
  },
}
