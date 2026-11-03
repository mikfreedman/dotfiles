-- Neovide (GUI) settings. The shared Cmd-key mappings are in vim/core.vim.
if not vim.g.neovide then
  return
end

vim.o.guifont = "BlexMono Nerd Font:h18"

-- Mac-style save/copy/paste
vim.keymap.set("n", "<D-s>", "<Cmd>w<CR>")
vim.keymap.set("x", "<D-c>", '"+y')
vim.keymap.set({ "n", "x" }, "<D-v>", '"+p')
vim.keymap.set({ "i", "c" }, "<D-v>", "<C-r>+")
