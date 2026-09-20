# Markdown preview

Open this file in Neovim to try the updated setup. Use `<leader>um` to toggle rendering.

## Lists and links

- [x] Treesitter highlighting and Markdown rendering work together
- [x] Fenced code uses its own language parser
- [x] LaTeX math renders through `latex2text`
- [ ] Try editing a line in insert mode to see the source

[Markdown renderer documentation](https://github.com/MeanderingProgrammer/render-markdown.nvim)

## Code

```lua
local function greet(name)
  return "Hello, " .. name
end
```

## Table

| Feature | Shortcut |
| --- | --- |
| Toggle Markdown rendering | Space, u, m |
| Expand syntax selection | Ctrl+Space |
| Shrink syntax selection | Backspace in visual mode |
| Accept Copilot suggestion | Alt+Enter |

## Math

Inline math: $\alpha + \beta = \gamma$.

$$
\frac{1}{2} + \sum_{i=1}^{n} i = \frac{1 + n(n+1)}{2}
$$

Math is displayed as a Unicode text approximation inside the terminal.

## Quote

> Source text remains editable. Rendering changes the display of the buffer.
