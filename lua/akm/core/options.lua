-- lua/akm/core/options.lua
-- Sensible defaults for IDE-like experience

local opt = vim.opt

-- UI & Appearance
opt.number = true         -- Line numbers
opt.relativenumber = true -- Relative line numbers (vim motions)
opt.signcolumn = "yes"    -- Always show sign column (prevents shift)
opt.cursorline = true     -- Highlight current line
opt.termguicolors = true  -- True color support
opt.showmode = false      -- Don't show mode (statusline handles it)
opt.wrap = false          -- No line wrap
opt.splitright = true     -- Vertical splits go right
opt.splitbelow = true     -- Horizontal splits go below

-- Editor Behavior
opt.mouse = "a"               -- Enable mouse
opt.clipboard = "unnamedplus" -- System clipboard
opt.undofile = true           -- Persistent undo
opt.swapfile = false          -- No swap files
opt.backup = false            -- No backup files
opt.updatetime = 250          -- Faster completion
opt.timeoutlen = 300          -- Faster key sequence completion

-- Indentation
opt.expandtab = true   -- Spaces instead of tabs
opt.shiftwidth = 4     -- Indent width
opt.tabstop = 4        -- Tab width
opt.softtabstop = 4    -- Backspace removes 4 spaces
opt.smartindent = true -- Smart auto-indent

-- Search
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true  -- Case-sensitive if uppercase used
opt.hlsearch = false  -- Don't highlight searches (use n/N)
opt.incsearch = true  -- Incremental search

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10 -- Max items in popup menu

-- Performance
opt.lazyredraw = false -- Disable for Noice compatibility
opt.synmaxcol = 240    -- Don't syntax highlight long lines

-- Scrolling
opt.scrolloff = 8     -- Lines to keep above/below cursor
opt.sidescrolloff = 8 -- Columns to keep left/right of cursor

-- Folding (using treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- Don't fold by default

-- Neovim-specific
if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true -- Smooth scrolling
end
