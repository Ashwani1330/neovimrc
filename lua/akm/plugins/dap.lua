-- lua/akm/plugins/dap.lua
-- Debug Adapter Protocol - VS Code-like debugging

return {
  -- DAP core
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      -- Virtual text during debugging
      "theHamsta/nvim-dap-virtual-text",
      -- Mason integration
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debug: Conditional Breakpoint" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Debug: Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run Last" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Debug: Eval" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug: Terminate" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Mason DAP setup
      require("mason-nvim-dap").setup({
        automatic_installation = false,
        handlers = {}, -- Configure Mason-managed adapters, including codelldb
        ensure_installed = {
          "python",
          "codelldb", -- Rust/C/C++
        },
      })

      -- DAP UI setup
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      -- Virtual text setup
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      })

      -- Auto-open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Breakpoint icons
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped" })


    end,
  },

  -- Language-specific DAP extensions
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      if vim.fn.executable(python) ~= 1 then
        python = vim.fn.exepath("python3")
      end
      require("dap-python").setup(python)
    end,
  },
}
