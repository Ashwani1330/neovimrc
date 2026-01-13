# Neovim Configuration Revamp - Migration Guide

## 🚀 Migration Steps

### 1. Backup Current Config
```bash
cd ~/.config
mv nvim nvim.backup
mkdir nvim
```

### 2. Create New Structure
```bash
cd ~/.config/nvim
mkdir -p lua/akm/{core,plugins}
```

### 3. Copy New Files
Place each artifact file in its corresponding location:
- `init.lua` → `~/.config/nvim/init.lua`
- `core/options.lua` → `~/.config/nvim/lua/akm/core/options.lua`
- `core/keymaps.lua` → `~/.config/nvim/lua/akm/core/keymaps.lua`
- `core/autocmds.lua` → `~/.config/nvim/lua/akm/core/autocmds.lua`
- `plugins/lsp.lua` → `~/.config/nvim/lua/akm/plugins/lsp.lua`
- `plugins/cmp.lua` → `~/.config/nvim/lua/akm/plugins/cmp.lua`
- `plugins/dap.lua` → `~/.config/nvim/lua/akm/plugins/dap.lua`
- `plugins/telescope.lua` → `~/.config/nvim/lua/akm/plugins/telescope.lua`
- `plugins/git.lua` → `~/.config/nvim/lua/akm/plugins/git.lua`
- `plugins/ai.lua` → `~/.config/nvim/lua/akm/plugins/ai.lua`
- `plugins/editor.lua` → `~/.config/nvim/lua/akm/plugins/editor.lua`
- `plugins/ui.lua` → `~/.config/nvim/lua/akm/plugins/ui.lua`

### 4. Install External Tools
```bash
# Install LSP servers, formatters, linters via Mason
# Open nvim and run:
:Mason

# Install these manually for formatting (optional):
pip install black isort  # Python
npm install -g prettier  # JS/TS
cargo install stylua     # Lua
```

### 5. Launch & Install
```bash
nvim
# Lazy.nvim will automatically install all plugins
# Press 'I' in the Lazy UI to install
```

---

## ⌨️ Essential Keybindings Quick Reference

### Navigation & Windows
| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Navigate between windows |
| `Ctrl+arrows` | Resize windows |
| `Tab` / `Shift+Tab` | Next/previous buffer |
| `<leader>x` | Close current buffer |

### File Operations
| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>e` | File explorer (Oil) |
| `-` | Open parent directory |

### Fuzzy Finding (Telescope)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fw` | Find word under cursor |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |

### LSP (Language Server)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>d` | Show diagnostics |
| `<leader>f` | Format file |

### Debugging (DAP)
| Key | Action |
|-----|--------|
| `F5` | Continue/Start debugging |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>du` | Toggle debug UI |
| `<leader>de` | Evaluate expression |
| `<leader>dt` | Terminate |

### Git
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (Fugitive) |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gd` | Git diff |
| `<leader>gb` | Git blame |
| `]c` / `[c` | Next/previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |

### AI Assistance
| Key | Action |
|-----|--------|
| `Ctrl+J` | Accept Copilot suggestion |
| `Ctrl+L` | Next Copilot suggestion |
| `<leader>ac` | Toggle Copilot Chat |
| `<leader>ae` | Explain code (visual mode) |
| `<leader>ar` | Review code (visual mode) |
| `<leader>af` | Fix code (visual mode) |

### Editing
| Key | Action |
|-----|--------|
| `gcc` | Comment/uncomment line |
| `gc` (visual) | Comment selection |
| `Alt+j/k` | Move line down/up |
| `<` / `>` (visual) | Indent left/right |
| `ys{motion}{char}` | Surround with char |
| `ds{char}` | Delete surrounding char |
| `cs{old}{new}` | Change surrounding |

### Utility
| Key | Action |
|-----|--------|
| `<leader>u` | Undo tree |
| `<leader>h` | Clear search highlight |
| `Ctrl+\` | Toggle terminal |
| `<leader>xx` | Show all diagnostics (Trouble) |

---

## 🎯 What Changed?

### ✅ Added
- **DAP (Debugging)** - Full debugging support with UI
- **Oil.nvim** - Better file explorer
- **Conform.nvim** - Better formatting
- **Trouble.nvim** - Better diagnostics UI
- **CopilotChat** - Conversational AI
- **Mini.nvim** - Surround, text objects, indentscope
- **Noice** - Better UI for messages

### ❌ Removed
- **Bufferline** - Using native buffer navigation
- **Harpoon** - Telescope + marks work fine
- **nvim-tree** - Replaced with Oil
- **Scope** - Unnecessary
- **nvim-navic** - Breadcrumbs removed
- **Multiple colorschemes** - Pick one

### 🔄 Streamlined
- All keybindings now follow logical patterns
- LSP setup is more comprehensive
- Plugin loading is optimized (lazy loading)
- File structure is cleaner

---

## 🎨 Customization Tips

### Change Colorscheme
In `lua/akm/plugins/ui.lua`, uncomment your preferred colorscheme:
- Catppuccin (default)
- Tokyonight
- Rose Pine
- Or add your own!

### Adjust Indentation
In `lua/akm/core/options.lua`, modify:
```lua
opt.shiftwidth = 4  -- Change to 2 for JS/TS style
opt.tabstop = 4
```

### Add More LSP Servers
In `lua/akm/plugins/lsp.lua`, add to `ensure_installed`:
```lua
ensure_installed = {
  "lua_ls",
  "pyright",
  "gopls",     -- Add Go
  "html",      -- Add HTML
  -- etc.
}
```

### Disable Format on Save
In `lua/akm/core/autocmds.lua`, comment out the AutoFormat group.

---

## 🔧 Troubleshooting

### Plugins Not Installing
```vim
:Lazy sync
:Lazy health
```

### LSP Not Working
```vim
:LspInfo
:Mason
:checkhealth
```

### Copilot Not Working
```vim
:Copilot setup
:Copilot status
```

### Performance Issues
Add to `lua/akm/core/options.lua`:
```lua
opt.timeoutlen = 500  -- Increase if needed
vim.g.loaded_python3_provider = 0  -- Disable Python provider
vim.g.loaded_ruby_provider = 0     -- Disable Ruby provider
```

---

## 📚 Next Steps

1. **Learn the Keybindings** - Spend a day using the new setup
2. **Customize Colors** - Make it yours
3. **Add Project-Specific Config** - Use `.nvim.lua` files
4. **Explore Telescope** - It's your best friend
5. **Use Debugging** - Try F5 in a Python/Rust file
6. **Leverage AI** - Visual select code and `<leader>ae`

---

## 💡 Pro Tips

- **Use Telescope for everything** - Files, buffers, grep, LSP symbols
- **Master `gd` and `gr`** - Definition and references are your bread and butter
- **Oil is powerful** - Think of it as dired for Neovim
- **Use marks** - `ma` to set mark 'a', `'a` to jump back
- **Learn text objects** - `daf` (delete a function), `cic` (change inner class)
- **Copilot Chat** - Select code, `<leader>ae` for explanation
- **Format often** - `<leader>f` keeps code clean
- **Debug visually** - DAP UI makes debugging intuitive

---

## 🚀 The Philosophy

This config prioritizes:
1. **Muscle Memory** - Familiar patterns from IDEs
2. **Speed** - Everything is fast and responsive
3. **Discoverability** - `<leader>fk` shows all keymaps
4. **Power** - Full IDE features in vim
5. **Simplicity** - No unnecessary complexity

Remember: **Vim is about muscle memory, not memorization.**

Happy coding! 🎉

~/.config/nvim/
├── init.lua                    # Bootstrap lazy.nvim only
├── lua/
│   └── akm/
│       ├── core/
│       │   ├── options.lua     # All vim.opt settings
│       │   ├── keymaps.lua     # Global keymaps
│       │   └── autocmds.lua    # Autocommands
│       ├── plugins/
│       │   ├── lsp.lua         # LSP configuration
│       │   ├── cmp.lua         # Completion
│       │   ├── treesitter.lua
│       │   ├── telescope.lua
│       │   ├── dap.lua         # Debugging
│       │   ├── git.lua         # Git plugins
│       │   ├── ai.lua          # AI tools
│       │   ├── editor.lua      # Editor enhancements
│       │   └── ui.lua          # UI plugins
│       └── utils.lua           # Helper functions


