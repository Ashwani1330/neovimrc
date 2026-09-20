<div align="center">
  <img src="assets/readme/retro-coder.gif" width="500" alt="Late-90s cyber anime character using a computer" />

  <pre>
╔══════════════════════════════════════════╗
║  N E O V I M // P E R S O N A L   R C  ║
╚══════════════════════════════════════════╝
  </pre>

  <p><code>FAST EDITS · SMART TOOLS · LATE-NIGHT GLOW</code></p>

  <p>
    <img src="https://img.shields.io/badge/SYSTEM-NEOVIM_0.12+-00ff66?style=plastic&labelColor=111111" alt="Neovim 0.12+" />
    <img src="https://img.shields.io/badge/CONFIG-LUA-b18cff?style=plastic&labelColor=111111" alt="Lua configuration" />
    <img src="https://img.shields.io/badge/STATUS-ONLINE-00ccff?style=plastic&labelColor=111111" alt="Status online" />
  </p>

  <p>
    <a href="#installation">[ BOOT ]</a>　
    <a href="#features">[ MODULES ]</a>　
    <a href="#keybindings">[ KEY MAP ]</a>　
    <a href="#troubleshooting">[ HELP ]</a>
  </p>

  <sub>animation via <a href="https://giphy.com/gifs/udK21RQeWtaGQ">GIPHY</a></sub>
</div>

> [!IMPORTANT]
> `SYSTEM REQUIREMENT:` **Neovim 0.12+** and **tree-sitter-cli 0.26.1+**. Windows users should boot the dedicated [windows branch](https://github.com/ashwani1330/neovimrc/tree/windows).

<details>
<summary><strong>[ SCREEN CAPTURE ] See the editor</strong></summary>
<br>
<img width="1916" height="1065" alt="Neovim configuration preview" src="https://github.com/user-attachments/assets/da42680f-f1ba-4545-9dc8-75ba9b34af0f" />
</details>

<a id="installation"></a>

## `01 // BOOT SEQUENCE`

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
git clone https://github.com/ashwani1330/neovimrc.git ~/.config/nvim
nvim
```

On first launch, `lazy.nvim` installs the plugins and Treesitter parsers. Run `:checkhealth` when it finishes.

<details>
<summary><strong>[ HARDWARE / SOFTWARE CHECK ]</strong></summary>

Alongside Neovim, install a C compiler, `git`, `ripgrep`, `fd`, `curl`, `tar`, and the Treesitter CLI from your package manager or an official release binary—not npm.

```bash
# Ubuntu / Debian
sudo apt update && sudo apt install neovim build-essential ripgrep fd-find git

# Fedora / RHEL
sudo dnf install neovim gcc make ripgrep fd-find git

# Arch Linux
sudo pacman -S neovim base-devel ripgrep fd git tree-sitter

# macOS
brew install neovim ripgrep fd gcc tree-sitter
```

Mason also needs Node.js for JavaScript-based language servers, Python for `debugpy`, and optionally Rust/Cargo for compiled tooling.
</details>

---

<a id="keybindings"></a>

## `02 // KEY MAP`

**Leader Key:** `Space`

<details>
<summary><strong>[ OPEN KEY DATABASE ]</strong></summary>

### `[ FILES / WINDOWS ]`

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

### `[ LSP / CODE INTELLIGENCE ]`

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

### `[ SEARCH / TELESCOPE ]`

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

### `[ AI / COPILOT ]`

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

### `[ GIT / FUGITIVE + GITSIGNS ]`

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

### `[ DEBUG / DAP ]`

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

### `[ UTILITY / EXTRA ]`

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

<a id="features"></a>

## `03 // LOADED MODULES`

| ID | Module | Provides |
| :---: | --- | --- |
| `LSP` | **Language intelligence** | Native LSP, Mason, nvim-cmp, LuaSnip |
| `TS` | **Syntax & structure** | Treesitter highlighting, folding, selection, and textobjects |
| `NAV` | **Navigation** | Telescope search, Oil buffers, and NvimTree sidebar |
| `AI` | **Pair programming** | Copilot ghost text and CopilotChat workflows |
| `DAP` | **Debugging** | Python, Rust, C, and C++ adapters |
| `GIT` | **Version control** | Gitsigns feedback and Fugitive commands |
| `TXT` | **Writing** | Rendered Markdown, LaTeX text, and CSV alignment |
| `UI` | **Interface** | Meowsoot night, Lualine, rounded windows, and native UI polish |

---

<a id="troubleshooting"></a>

## `04 // TROUBLESHOOTING`

<details>
<summary><strong>[ ERR:BUILD ] Telescope FZF is missing</strong></summary>

Install `make` and a C compiler, then run `:Lazy build telescope-fzf-native.nvim`.
</details>

<details>
<summary><strong>[ ERR:PARSE ] Treesitter highlighting is missing</strong></summary>

Confirm `tree-sitter --version` is 0.26.1 or newer, then run `:Lazy build nvim-treesitter`.
</details>

<details>
<summary><strong>[ ERR:GLYPH ] Icons look wrong</strong></summary>

Use a patched [Nerd Font](https://www.nerdfonts.com/) in your terminal.
</details>

<details>
<summary><strong>[ ERR:MARKUP ] Markdown or LaTeX does not render</strong></summary>

Install the `markdown`, `markdown_inline`, and `latex` parsers. For math conversion, run `uv tool install pylatexenc` and keep `~/.local/bin` on your `PATH`. Try the [Markdown preview](docs/markdown-preview.md) and toggle rendering with `<leader>um`.
</details>

<details>
<summary><strong>[ ERR:TOOLS ] Language servers or Python debugging are unavailable</strong></summary>

Inspect tools with `:Mason` and active clients with `:checkhealth vim.lsp`. Python debugging uses Mason's `debugpy` adapter and the active project interpreter.
</details>

---

<div align="center">
  <pre>-- EOF --  best viewed in a terminal after midnight  -- EOF --</pre>
</div>
