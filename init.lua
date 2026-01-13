-- init.lua - Minimal bootstrap for lazy.nvim
-- Everything else is in lua/akm/

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys BEFORE lazy setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core settings
require("akm.core.options")
require("akm.core.keymaps")
require("akm.core.autocmds")

-- Setup lazy.nvim
require("lazy").setup("akm.plugins", {
  defaults = { lazy = true },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml",
        "tutor", "zipPlugin", "netrwPlugin",
      },
    },
  },
})
