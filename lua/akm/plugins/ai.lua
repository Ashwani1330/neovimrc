-- lua/akm/plugins/ai.lua
-- AI-powered coding assistance

return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Copilot keymaps
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })
      vim.keymap.set("i", "<C-H>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot" })
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-K>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })

      -- Filetypes to enable
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["gitcommit"] = false,
        ["gitrebase"] = false,
        ["hgcommit"] = false,
      }
    end,
  },

  -- Alternative: Avante (Claude-powered AI assistant in Neovim)
  -- Uncomment if you want Claude integration instead of/alongside Copilot
  --[[
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        max_tokens = 8000,
      },
      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        focus = "<leader>af",
      },
    },
    keys = {
      { "<leader>aa", function() require("avante").ask() end, desc = "Ask AI", mode = { "n", "v" } },
      { "<leader>ae", function() require("avante").edit() end, desc = "Edit with AI", mode = "v" },
      { "<leader>ar", function() require("avante").refresh() end, desc = "Refresh AI" },
      { "<leader>at", function() require("avante").toggle() end, desc = "Toggle AI" },
    },
  },
  ]]--

  -- Alternative: CopilotChat for conversational AI
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
    },
    keys = {
      { "<leader>ac", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "Explain code" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", mode = "v", desc = "Review code" },
      { "<leader>af", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "Fix code" },
      { "<leader>ao", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "Optimize code" },
      { "<leader>ad", "<cmd>CopilotChatDocs<cr>", mode = "v", desc = "Generate docs" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", mode = "v", desc = "Generate tests" },
    },
    opts = {
      debug = false,
      show_help = "yes",
      prompts = {
        Explain = "Explain how this code works.",
        Review = "Review this code and suggest improvements.",
        Tests = "Write tests for this code.",
        Refactor = "Refactor this code to improve its clarity and readability.",
        FixCode = "Fix the bugs in this code.",
        BetterNamings = "Provide better names for variables and functions.",
        Documentation = "Write documentation for this code.",
        SwaggerApiDocs = "Write Swagger API documentation.",
        SwaggerJsDocs = "Write Swagger JSDoc comments.",
      },
      window = {
        layout = "float",
        width = 0.8,
        height = 0.8,
      },
    },
  },
}
