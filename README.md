# ⚡Neovim Configuration for Windows

A blazing fast, fully-featured Neovim configuration built for Windows. It includes LSP support, debugging (DAP), AI assistance (Copilot), and a refined UI, all managed by `lazy.nvim`.

## Screenshot
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/0030daf7-7193-423b-8cfe-4c162fb0423c" />

## 📋 Requirements

Before installing this configuration, you must ensure your Windows environment has the necessary build tools. Neovim plugins often need to compile C/C++ code (like `telescope-fzf-native` or Treesitter parsers).

### 1. Install Neovim & Build Tools (via Winget)
Open **PowerShell as Administrator** and run the following commands:

```powershell
# 1. Install Neovim (if you haven't already)
winget install -e --id Neovim.Neovim

# 2. Install Build Tools (Required for Telescope & Treesitter)
winget install -e --id ezwinports.make
winget install -e --id BrechtSanders.WinLibs.POSIX.UCRT

# 3. Install Ripgrep (Required for fast file searching)
winget install -e --id BurntSushi.ripgrep.MSVC
```

### 2. Install Language Runtimes

For Mason to install language servers (LSP), you need the underlying runtimes:

* **Node.js**: Required for `pyright`, `ts_ls`, `bashls`, etc.
* **Python**: Required for `debugpy` and Python tooling.
* **Rust (Cargo)**: Optional, but recommended for some formatters.

---

## 🚀 Installation

### 1. Back up existing config (if any)

```powershell
if (Test-Path $env:LOCALAPPDATA\nvim) { mv $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak }
if (Test-Path $env:LOCALAPPDATA\nvim-data) { mv $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak }
```

### 2. Clone the repository

```powershell
git clone https://github.com/ashwani1330/neovimrc.git $env:LOCALAPPDATA\nvim
```

### 3. Launch Neovim

Open `nvim` in your terminal. `lazy.nvim` will automatically bootstrap and install all plugins.

* **Note:** You might see some errors on the very first launch while Treesitter parsers are compiling. This is normal.
* Wait for the dashboard to appear, then run `:checkhealth` to verify everything is green.

---

## ⌨️ Essential Keybindings

**Leader Key:** `Space`

### 📂 File & Window Management

| Key | Action |
| --- | --- |
| `<leader>e` / `-` | Open File Explorer (Oil.nvim) |
| `<leader>pv` | Toggle Sidebar Explorer (NvimTree) |
| `<leader>ff` | Find Files (Telescope) |
| `<leader>fg` | Live Grep (Search text in files) |
| `<leader>fb` | Switch Buffers |
| `Ctrl+h/j/k/l` | Navigate between windows |
| `Ctrl+arrows` | Resize windows |
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>Q` | Force Quit All |
| `<C-\>` | Toggle Terminal |

### 🧠 LSP (Code Intelligence)

| Key | Action |
| --- | --- |
| `gd` | Go to Definition |
| `<leader>vrr` | Find References |
| `K` | Hover Documentation |
| `<leader>vca` | Code Action |
| `<leader>vrn` | Rename Symbol |
| `<leader>vd` | Show Diagnostics (Float) |
| `<leader>vws` | Workspace Symbols |
| `<leader>f` | Format File |
| `[d` / `]d` | Previous / Next Diagnostic |

### 🤖 AI Assistance (Copilot)

**Ghost Text (Completions):**
| Key | Action |
| --- | --- |
| `Ctrl+J` | Accept Suggestion |
| `Ctrl+L` | Accept Next Word |
| `Ctrl+H` | Dismiss Suggestion |
| `Alt+]` | Next Suggestion |
| `Alt+[` | Previous Suggestion |

**Chat & Agent:**
| Key | Action |
| --- | --- |
| `<leader>aa` | Toggle Copilot Chat Sidebar |
| `<leader>aq` | Quick Chat (Input window) |
| `<leader>ae` | Explain Code (Visual Mode) |
| `<leader>af` | Fix Bug (Visual Mode) |
| `<leader>at` | Generate Tests (Visual Mode) |

### 🐛 Debugging (DAP)

| Key | Action |
| --- | --- |
| `F5` | Start / Continue |
| `F10` | Step Over |
| `F11` | Step Into |
| `F12` | Step Out |
| `<leader>db` | Toggle Breakpoint |
| `<leader>dB` | Conditional Breakpoint |
| `<leader>du` | Toggle Debug UI |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run Last |
| `<leader>dt` | Terminate |

### 🌲 Git

**Fugitive:**
| Key | Action |
| --- | --- |
| `<leader>gs` | Git Status |
| `<leader>gc` | Git Commit |
| `<leader>gp` | Git Push |
| `<leader>gP` | Git Pull |
| `<leader>gd` | Git Diff |
| `<leader>gl` | Git Log |

**Gitsigns:**
| Key | Action |
| --- | --- |
| `]c` / `[c` | Next / Previous Hunk |
| `<leader>hs` | Stage Hunk |
| `<leader>hr` | Reset Hunk |
| `<leader>hS` | Stage Buffer |
| `<leader>hR` | Reset Buffer |
| `<leader>hp` | Preview Hunk |
| `<leader>hb` | Blame Line |
| `<leader>tb` | Toggle Blame Ghost Text |

### 🔭 Telescope & Tools

| Key | Action |
| --- | --- |
| `<leader>px` | Open Telescope Command Palette |
| `<leader>fr` | Recent Files |
| `<leader>fw` | Find Word (Grep String) |
| `<leader>fc` | Fuzzy Find in Current Buffer |
| `<leader>fs` | Document Symbols |
| `<leader>fgc` | Git Commits |
| `<leader>fgb` | Git Branches |
| `<leader>fgs` | Git Status |
| `<leader>u` | Toggle UndoTree |
| `<leader>xx` | Toggle Trouble (Diagnostics) |

---

## 🎨 Features & Plugins

* **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
* **LSP:** Mason, Mason-LSPConfig, nvim-lspconfig
* **Completion:** nvim-cmp, LuaSnip
* **Formatting:** Conform.nvim
* **Explorer:** Oil.nvim (Buffer-like file editing) & Nvim-Tree
* **Fuzzy Finder:** Telescope.nvim (with fzf-native for speed)
* **Git:** Gitsigns & Fugitive
* **AI:** Github Copilot & CopilotChat.nvim
* **Debugging:** nvim-dap & nvim-dap-ui

---

## 🔧 Troubleshooting

**1. "Make" not found / Telescope FZF error**
Ensure you installed `ezwinports.make` via Winget (see Requirements). If the error persists, open nvim and run:

```vim
:Lazy build telescope-fzf-native.nvim
```

**2. Treesitter errors on startup**
If syntax highlighting is missing, run:

```vim
:TSUpdate
```

**3. Icons are missing or look weird**
Make sure you are using a **Nerd Font** in your terminal (e.g., Windows Terminal settings).
