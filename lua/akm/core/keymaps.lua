-- lua/akm/core/keymaps.lua
-- Intuitive keybindings following IDE conventions + vim philosophy

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key is Space (set in init.lua)

-- ========================================
-- ESSENTIAL MOTIONS
-- ========================================

-- Better window navigation (Ctrl+hjkl like VS Code)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- -- Buffer navigation (Tab = next, Shift+Tab = prev, like browser)
-- keymap("n", "<Tab>", ":bnext<CR>", opts)
-- keymap("n", "<S-Tab>", ":bprevious<CR>", opts)
-- keymap("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })

-- Better indenting (stays in visual mode)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines up/down (Alt+j/k like VS Code)
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- ========================================
-- LEADER KEYMAPS (Space + key)
-- ========================================

-- File operations
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all force" })

-- File explorer (pv = project view, like your old config)
keymap("n", "<leader>pv", ":Oil<CR>", { desc = "File explorer" })
keymap("n", "<leader>e", ":Oil<CR>", { desc = "File explorer" })

-- Search & Replace
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
keymap("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Replace word under cursor" })

-- ========================================
-- TELESCOPE (Fuzzy Finder)
-- ========================================
-- These will be set in telescope.lua plugin config:
-- <leader>ff - Find files
-- <leader>fg - Live grep
-- <leader>fb - Buffers
-- <leader>fh - Help tags
-- <leader>fr - Recent files
-- <leader>fc - Find in current buffer

-- ========================================
-- LSP (Language Server)
-- ========================================
-- These will be set in lsp.lua when LSP attaches:
-- gd - Go to definition
-- gr - Go to references
-- gi - Go to implementation
-- K - Hover documentation
-- <leader>ca - Code action
-- <leader>rn - Rename
-- [d - Previous diagnostic
-- ]d - Next diagnostic
-- <leader>d - Show diagnostics

-- ========================================
-- DEBUGGING (DAP)
-- ========================================
-- These will be set in dap.lua:
-- <F5> - Continue
-- <F10> - Step over
-- <F11> - Step into
-- <F12> - Step out
-- <leader>db - Toggle breakpoint
-- <leader>dB - Conditional breakpoint
-- <leader>dr - Open REPL
-- <leader>du - Toggle UI

-- ========================================
-- GIT
-- ========================================
-- These will be set in git.lua:
-- <leader>gs - Git status
-- <leader>gc - Git commit
-- <leader>gp - Git push
-- <leader>gd - Git diff
-- <leader>gb - Git blame
-- ]c - Next hunk
-- [c - Previous hunk
-- <leader>hs - Stage hunk
-- <leader>hr - Reset hunk

-- ========================================
-- UTILITY
-- ========================================

-- Terminal toggle (Ctrl+\ like VS Code)
keymap("n", "<C-\\>", "<Esc>:terminal<CR>", { desc = "Open terminal" })
keymap("n", "<leader>tt", ":sp<Esc>:terminal<Esc>:resize -7<CR>", { desc = "Open terminal" })
keymap("t", "<Esc>", "<C-\\><C-n>", opts) -- Exit terminal mode with Esc

-- Quick save with Ctrl+S (optional, but many expect it)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>a", opts)

-- Paste without yanking in visual mode
keymap("v", "p", '"_dP', opts)

-- Keep cursor centered during search and page jumps
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Quickfix navigation
keymap("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
keymap("n", "[q", ":cprev<CR>", { desc = "Previous quickfix" })

-- Format file
keymap("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })
