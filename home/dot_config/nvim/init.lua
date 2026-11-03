-- ---------------------------------------------------------------------------
-- Neovim config
--
-- Shared options and keybindings come from ~/.vim/core.vim (also used by Vim).
-- This file adds Neovim-only options; plugins live in lua/plugins/*.lua and
-- are pinned in lazy-lock.json.
-- ---------------------------------------------------------------------------

vim.cmd.source(vim.fn.expand("~/.vim/core.vim"))

-- Set NVIM_NO_NERD_FONT=1 if your terminal font has no Nerd Font glyphs.
vim.g.have_nerd_font = vim.env.NVIM_NO_NERD_FONT == nil

require("config.options")
require("config.lsp")
require("config.neovide")
require("config.lazy")

-- Machine-local settings - keep this at the end
local loc = vim.fn.expand("~/.config/nvim-local.lua")
if vim.uv.fs_stat(loc) then
  dofile(loc)
end
