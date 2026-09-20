local M = {}

M.languages = {
  "lua", "vim", "vimdoc", "query",
  "python", "javascript", "typescript", "tsx",
  "rust", "go", "c", "cpp", "html", "css",
  "json", "yaml", "markdown", "markdown_inline", "latex", "bash", "regex",
}

function M.attach(buf)
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
    return
  end
  local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
  if not lang or not pcall(vim.treesitter.language.add, lang) then
    return -- Keep normal syntax/indentation for files without an installed parser.
  end
  local ok, err = pcall(vim.treesitter.start, buf, lang)
  if not ok then
    vim.notify("Treesitter: " .. tostring(err), vim.log.levels.WARN)
    return
  end
  -- Markdown's built-in indentation handles lists; TS indentation is experimental.
  if lang ~= "markdown" and lang ~= "markdown_inline"
    and vim.treesitter.query.get(lang, "indents") then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

function M.setup()
  local ts = require("nvim-treesitter")
  ts.setup({})
  vim.treesitter.language.register("markdown", "copilot-chat")
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("AkmTreesitter", { clear = true }),
    callback = function(event) M.attach(event.buf) end,
  })
  vim.keymap.set({ "n", "x" }, "<C-Space>", function()
    vim.treesitter.select("parent")
  end, { desc = "Expand syntax selection" })
  vim.keymap.set("x", "<BS>", function()
    vim.treesitter.select("child")
  end, { desc = "Shrink syntax selection" })
  if vim.fn.executable("tree-sitter") == 1 then
    ts.install(M.languages):await(function(err)
      vim.schedule(function()
        if err then
          vim.notify("Treesitter parser installation: " .. tostring(err), vim.log.levels.ERROR)
          return
        end
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then M.attach(buf) end
        end
      end)
    end)
  end
end

return M
