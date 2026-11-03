-- Neovim-only options (shared ones are in vim/core.vim)

vim.o.signcolumn = "yes"      -- Always show the sign column so git/diagnostic signs don't shift text
vim.o.updatetime = 250        -- Faster CursorHold (diagnostic popups, gitsigns)
vim.o.inccommand = "split"    -- Live preview of :s substitutions
vim.o.confirm = true          -- Ask instead of failing on :q with unsaved changes
vim.o.winborder = "rounded"   -- Borders on floating windows (hover, signature help)

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
