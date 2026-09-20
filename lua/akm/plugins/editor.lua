-- lua/akm/plugins/editor.lua
-- Core editor enhancement plugins

return {
  -- Treesitter: the main branch supports Neovim 0.12's native APIs.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
      require("nvim-treesitter").update():wait(300000)
      require("nvim-treesitter").install(require("akm.core.treesitter").languages):wait(300000)
    end,
    config = function()
      require("akm.core.treesitter").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })
      local objects = {
        af = "@function.outer", ["if"] = "@function.inner",
        ac = "@class.outer", ic = "@class.inner",
        aa = "@parameter.outer", ia = "@parameter.inner",
      }
      for key, capture in pairs(objects) do
        vim.keymap.set({ "x", "o" }, key, function()
          require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
        end, { desc = "Select " .. capture })
      end
      for key, capture in pairs({ f = "@function.outer", c = "@class.outer" }) do
        vim.keymap.set({ "n", "x", "o" }, "]" .. key, function()
          require("nvim-treesitter-textobjects.move").goto_next_start(capture, "textobjects")
        end, { desc = "Next " .. capture })
        vim.keymap.set({ "n", "x", "o" }, "[" .. key, function()
          require("nvim-treesitter-textobjects.move").goto_previous_start(capture, "textobjects")
        end, { desc = "Previous " .. capture })
      end
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
  },

-- Comment.nvim
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- 1. Setup the context-commentstring plugin FIRST and disable the buggy autocmd
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }

      -- 2. Setup Comment.nvim with the integration hook
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Mini.nvim
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          replace = "cs",
          find = "",
          find_left = "",
          highlight = "",
          update_n_lines = "",
        },
      })
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.indentscope").setup({ symbol = "│", options = { try_as_border = true } })
      require("mini.move").setup({
        mappings = {
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      })
    end,
  },

  -- Illuminate
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = { providers = { "lsp" } },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.keymap.set("n", "]]", function() require("illuminate").goto_next_reference(false) end,
        { desc = "Next Reference" })
      vim.keymap.set("n", "[[", function() require("illuminate").goto_prev_reference(false) end,
        { desc = "Prev Reference" })
    end,
  },

  -- Undotree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },

  -- FILE EXPLORERS (Both Enabled)

  -- 1. NvimTree (Sidebar on the Right) - Mapped to <leader>pv
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>pv", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer (Tree)" },
    },
    opts = {
      sort = { sorter = "case_sensitive" },
      hijack_directories = { enable = false }, -- Oil handles directory buffers
      view = { side = "right", width = 35 },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
      git = { enable = true, ignore = false },
    },
  },

  -- 2. Oil.nvim (Buffer Editor) - Mapped to <leader>e
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-",         "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>e", "<cmd>Oil<cr>", desc = "File Explorer (Oil)" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
      },
    },
  },

  --[[ -- Conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        rust = { "rustfmt" },
        go = { "gofmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        clang_format = {
          prepend_args = { "--style={IndentWidth=4}" },
        },
      },
    },
  }, ]]

  -- Trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
    },
    opts = {},
  },

  -- Cloak
  {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = { ".env*", "wrangler.toml", ".dev.vars" },
          cloak_pattern = "=.+"
        },
      },
    },
  },

  -- Render Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "copilot-chat" },
    cmd = "RenderMarkdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown rendering" },
    },
    opts = {
      file_types = { "markdown", "copilot-chat" },
      latex = { enabled = true, converter = "latex2text" },
    },
  },
}
