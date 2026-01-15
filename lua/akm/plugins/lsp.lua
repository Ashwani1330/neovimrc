-- lua/akm/plugins/lsp.lua
-- LSP configuration with Mason

return {
  -- Mason: Installer
  {
    "williamboman/mason.nvim",
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

  -- Mason-LSPConfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls", "pyright", "ts_ls", "rust_analyzer", "clangd",
      },
      automatic_installation = true,
    },
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
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Override global LSP floating window borders
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- 1. Modern LspAttach Autocommand (Decouples keymaps from server setup)
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
          map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("n", "<leader>vca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>vrr", vim.lsp.buf.references, "References")
          map("n", "<leader>vrn", vim.lsp.buf.rename, "Rename")
          map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
        end,
      })

      -- 2. FIX: Use new 'signs.text' API instead of deprecated 'sign_define'
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
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
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
                library = vim.api.nvim_get_runtime_file("", true),
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

      -- 3. FIX: Handle deprecation of lspconfig framework in Neovim 0.11+
      for server, config in pairs(servers) do
        -- Merge defaults
        config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

        if vim.fn.has("nvim-0.11") == 1 then
          -- New native API for 0.11+
          vim.lsp.config(server, config)
          vim.lsp.enable(server)
        else
          -- Legacy API for 0.10
          lspconfig[server].setup(config)
        end
      end
    end,
  },

  -- LazyDev (Lua dev)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = { { path = "luvit-meta/library", words = { "vim%.uv" } } },
    },
  },
}
