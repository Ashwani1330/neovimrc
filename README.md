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

## ⌨️ Keybindings

**Leader Key:** `Space`

<details>
<summary><strong>CLICK TO VIEW ALL KEYBINDINGS</strong></summary>

### 📂 File & Window Management

| Key | Action |
| --- | --- |
| `<leader>pv` | Toggle File Explorer (NvimTree) |
| `<leader>e` / `-` | Edit Parent Directory (Oil.nvim) |
| `<leader>w` | Save File |
| `<leader>q` | Quit |
| `<leader>Q` | Force Quit All |
| `Ctrl+h/j/k/l` | Navigate between splits |
| `Ctrl+Arrows` | Resize splits |
| `<C-\>` | Toggle Terminal |
| `<leader>fb` | Switch Buffers (Telescope) |

### 🧠 LSP (Code Intelligence)

| Key | Action |
| --- | --- |
| `gd` | Go to Definition |
| `K` | Hover Documentation |
| `<leader>vrr` | Find References |
| `<leader>vca` | Code Action |
| `<leader>vrn` | Rename Symbol |
| `<leader>vd` | Show Diagnostics (Float) |
| `<leader>vws` | Workspace Symbols |
| `[d` / `]d` | Previous / Next Diagnostic |
| `<leader>f` | Format File |

### 🔍 Telescope (Search)

| Key | Action |
| --- | --- |
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep (Search text) |
| `<leader>fr` | Recent Files |
| `<leader>fw` | Grep String (Word under cursor) |
| `<leader>fc` | Fuzzy find in current buffer |
| `<leader>fs` | Document Symbols |
| `<leader>px` | Project/Telescope Commands |
| `<leader>fh` | Help Tags |
| `<leader>fk` | Keymaps |

### 🤖 AI (Copilot)

| Key | Action |
| --- | --- |
| **Ghost Text** |  |
| `Ctrl+J` | Accept Suggestion |
| `Ctrl+L` | Accept Next Word |
| `Ctrl+H` | Dismiss Suggestion |
| `Alt+]` | Next Suggestion |
| `Alt+[` | Previous Suggestion |
| **Chat Agent** |  |
| `<leader>aa` | Toggle Chat Sidebar |
| `<leader>aq` | Quick Chat Input |
| `<leader>ae` | Explain Code (Visual) |
| `<leader>af` | Fix Bug (Visual) |
| `<leader>at` | Generate Tests (Visual) |

### 🌲 Git (Fugitive & Gitsigns)

| Key | Action |
| --- | --- |
| `<leader>gs` | Git Status |
| `<leader>gc` | Git Commit |
| `<leader>gp` | Git Push |
| `<leader>gP` | Git Pull |
| `<leader>gd` | Git Diff |
| `<leader>gl` | Git Log |
| `]c` / `[c` | Next / Previous Hunk |
| `<leader>hs` | Stage Hunk |
| `<leader>hr` | Reset Hunk |
| `<leader>hp` | Preview Hunk |
| `<leader>tb` | Toggle Blame Ghost Text |

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
| `<leader>dt` | Terminate |

### 🛠️ Utility & Extra

| Key | Action |
| --- | --- |
| `<leader>u` | Toggle UndoTree |
| `<leader>xx` | Toggle Trouble (Diagnostics) |
| `<leader>h` | Clear Search Highlight |
| `<leader>r` | Replace word under cursor |
| `Alt+j/k` | Move lines up/down |

</details>

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
