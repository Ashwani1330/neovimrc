# ⚡Neovim Configuration

A blazing fast, fully-featured Neovim configuration built for Linux and macOS. It includes LSP support, debugging (DAP), AI assistance (Copilot), and a refined UI, all managed by `lazy.nvim`.

> [!IMPORTANT]
> **🪟 Windows Users:** Please check the [windows branch](https://github.com/ashwani1330/neovimrc/tree/windows) for a configuration optimized for PowerShell and Windows build tools.

## Screenshot
<img width="1916" height="1065" alt="image" src="https://github.com/user-attachments/assets/da42680f-f1ba-4545-9dc8-75ba9b34af0f" />


## 📋 Requirements

This configuration targets **Neovim 0.12+** and requires **tree-sitter-cli 0.26.1+**, a C compiler, `curl`, and `tar`. Install the CLI using your package manager or an official Treesitter release binary, rather than npm. Distribution packages for Neovim may be older than this requirement.

### 1. Install Neovim & Tools

**Ubuntu / Debian:**

```bash
sudo apt update
sudo apt install neovim build-essential ripgrep fd-find git

```

**Fedora / RHEL:**
```bash
sudo dnf install neovim gcc make ripgrep fd-find git

```

**Arch Linux:**

```bash
sudo pacman -S neovim base-devel ripgrep fd git tree-sitter

```

**macOS (Homebrew):**

```bash
brew install neovim ripgrep fd gcc tree-sitter

```

### 2. Install Language Runtimes

For [Mason.nvim](https://github.com/mason-org/mason.nvim) to install language servers (LSP) and formatters, you need:

* **Node.js** (npm): Required for `pyright`, `ts_ls`, `bashls`, etc.
* **Python**: Required for `debugpy` and Python tooling.
* **Rust (Cargo)**: Optional, but recommended for compiling some tools.
  
---

## 🚀 Installation

### 1. Back up existing config

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

```

### 2. Clone the repository

```bash
git clone https://github.com/ashwani1330/neovimrc.git ~/.config/nvim

```

### 3. Launch Neovim

Open `nvim` in your terminal. `lazy.nvim` will automatically bootstrap and install all plugins.

* Wait for plugin and parser installation to finish.
* Run `:checkhealth` to verify everything is green.

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
| `Alt+Enter` | Accept Suggestion |
| `Alt+l` | Accept Next Word |
| `Alt+Backspace` | Dismiss Suggestion |
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
| `<leader>um` | Toggle Markdown rendering |
| `Ctrl+Space` (normal / visual) | Expand Treesitter selection |
| `Backspace` (visual) | Shrink Treesitter selection |
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
* **Syntax:** nvim-treesitter and textobjects, both on `main`, with native Neovim highlighting and folding
* **Markdown:** render-markdown.nvim; normal mode renders, insert mode shows source
* **Theme:** Meowsoot night with its matching Lualine theme
* **Formatting:** Language server formatting (`<leader>f`); Conform.nvim is an optional commented configuration
* **Explorer:** Oil.nvim (Buffer-like file editing) & Nvim-Tree
* **Fuzzy Finder:** Telescope.nvim (with fzf-native for speed)
* **Git:** Gitsigns & Fugitive
* **AI:** Github Copilot & CopilotChat.nvim
* **Debugging:** nvim-dap & nvim-dap-ui

---

## 🔧 Troubleshooting

**1. "Make" not found / Telescope FZF error**
Ensure you have `make` and `gcc` installed (see Requirements). Then run:

```vim
:Lazy build telescope-fzf-native.nvim

```

**2. Treesitter errors on startup**
Ensure `tree-sitter --version` reports 0.26.1 or newer. If syntax highlighting is missing, install missing parsers and update existing ones:

```vim
:Lazy build nvim-treesitter

```

**3. Icons are missing or look weird**
Make sure you are using a [Nerd Font](https://www.nerdfonts.com/) in your terminal.


**4. Markdown rendering**
The `markdown` and `markdown_inline` parsers must both be installed. LaTeX math additionally uses the `latex` parser and `latex2text` converter (`uv tool install pylatexenc`). Keep `~/.local/bin` on your PATH. Open [the Markdown preview](docs/markdown-preview.md) to try headings, tables, code, and math. Rendering and syntax highlighting work together; use `:RenderMarkdown toggle` or `<leader>um` to switch rendering. Markdown uses built-in list indentation and preserves trailing spaces on save, since two spaces encode a hard line break.

**5. Language servers and Python debugging**
Mason installs `lua_ls`, `pyright`, `ts_ls`, `rust_analyzer`, and `clangd`. Inspect installation status using `:Mason` and active clients using `:checkhealth vim.lsp`. Python debugging uses Mason's debugpy environment for the adapter and the project's Python environment for the program.
