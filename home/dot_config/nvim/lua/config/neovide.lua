-- Neovide (GUI) settings. The shared Cmd-key mappings are in vim/core.vim.
if not vim.g.neovide then
  return
end

vim.o.guifont = "BlexMono Nerd Font:h18"

-- No cursor animation: jump instantly, no trail, no particle effects
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_short_animation_length = 0
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_vfx_mode = ""

-- Mac-style save/copy/paste
vim.keymap.set("n", "<D-s>", "<Cmd>w<CR>")
vim.keymap.set("x", "<D-c>", '"+y')
vim.keymap.set({ "n", "x" }, "<D-v>", '"+p')
vim.keymap.set({ "i", "c" }, "<D-v>", "<C-r>+")
