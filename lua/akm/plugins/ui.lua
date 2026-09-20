-- lua/akm/plugins/ui.lua
-- UI enhancements and colorscheme

return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    enabled = false, -- Enable when switching back to Kanagawa
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = false,
        theme = "dragon",
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = true,
          mason = true,
          dap = true,
          dap_ui = true,
        },
      })
      vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },

  --[[
  {
    -- Colorscheme - Choose one, comment others
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = false,
          treesitter = true,
          telescope = true,
          mason = true,
          dap = true,
          dap_ui = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  ]] --

  -- Alternative colorschemes (uncomment to use)
  --[[
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  ]] --

  --[[
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("rose-pine")
    end,
  },
  ]] --
  {
    "marekh19/meowsoot.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("meowsoot").setup({
        style = "night", -- "night" (warm dark), "moon" (cool dark), "dawn" (light)
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = {},
          functions = {},
          variables = {},
          sidebars = "dark", -- "dark", "transparent", "normal"
          floats = "dark",
        },
        plugins = {
          all = false,
          auto = true, -- Detect installed plugins through lazy.nvim
        },
        cache = true,
      })
      vim.cmd.colorscheme("meowsoot")
    end,
  },

  -- Lualine - Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      -- LSP progress
      local function lsp_progress()
        return (vim.lsp.status():gsub("%%", "%%%%"))
      end

      return {
        options = {
          theme = "meowsoot",
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            { "filename", path = 1 },
            { lsp_progress },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "fugitive", "oil", "lazy" },
      }
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Dressing - Better UI for inputs and selects
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        border = "rounded",
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
      },
    },
  },
}
