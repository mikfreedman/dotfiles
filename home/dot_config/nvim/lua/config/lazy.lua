-- Bootstrap lazy.nvim (https://lazy.folke.io)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out } }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = { colorscheme = { "base16-railscasts", "habamax" } },
  change_detection = { notify = false },
  -- Plugins update only when you run :Lazy update and commit lazy-lock.json.
  checker = { enabled = false },
  ui = { icons = vim.g.have_nerd_font and {} or {
    cmd = "⌘", config = "🛠", event = "📅", ft = "📂", init = "⚙", keys = "🗝",
    plugin = "🔌", runtime = "💻", require = "🌙", source = "📄", start = "🚀",
    task = "📌", lazy = "💤 ",
  } },
})
