-- LSP behaviour. Servers are installed by mason and enabled by mason-lspconfig
-- (see lua/plugins/lsp.lua).
--
-- Built-in defaults you get for free in Neovim 0.11+:
--   K      hover docs            grn  rename          gra  code action
--   grr    references            gri  implementation  gO   document symbols
--   [d ]d  prev/next diagnostic  <C-s> (insert) signature help

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { source = true },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(event)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("<leader>d", vim.diagnostic.open_float, "Line diagnostics")
  end,
})
