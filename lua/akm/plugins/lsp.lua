-- lua/akm/plugins/lsp.lua
-- LSP configuration with Mason

return {
  -- Mason: Installer
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },

  -- Setup runs after server configuration, with one owner for LSP activation.
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    dependencies = { "mason.nvim" },
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Buffer-local shortcuts when a language server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          local map = function(mode, lhs, rhs, desc)
            opts.desc = desc
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
          map("n", "<leader>vd", vim.diagnostic.open_float, "Diagnostics float")
          map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
          map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
          map("n", "<leader>vca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>vrr", vim.lsp.buf.references, "References")
          map("n", "<leader>vrn", vim.lsp.buf.rename, "Rename")
          map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
        end,
      })

      -- Diagnostics use the native signs API
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        float = {
          source = "if_many",
          border = "rounded",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN] = "!",
            [vim.diagnostic.severity.HINT] = "?",
            [vim.diagnostic.severity.INFO] = "i",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Server Definitions
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
              },
            },
          },
        },
        ts_ls = {},
        rust_analyzer = {},
        clangd = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
        vim.lsp.config(server, config)
      end
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "rust_analyzer", "clangd" },
        automatic_enable = false,
      })
      vim.lsp.enable(vim.tbl_keys(servers))
    end,
  },

  -- LazyDev (Lua dev)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
}
