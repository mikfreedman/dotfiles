-- File browsing (replaces NERDTree)
return {
  -- Sidebar tree on \ and | , like the old NERDTree maps
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "\\", "<Cmd>Neotree toggle<CR>", desc = "File tree" },
      { "|", "<Cmd>Neotree reveal<CR>", desc = "Reveal file in tree" },
    },
    opts = {
      window = { width = 30 },
      filesystem = {
        follow_current_file = { enabled = false },
        hijack_netrw_behavior = "disabled", -- oil.nvim handles `nvim .`
        filtered_items = { hide_dotfiles = false, hide_gitignored = true },
      },
      default_component_configs = vim.g.have_nerd_font and {} or {
        icon = { folder_closed = "+", folder_open = "-", folder_empty = "~", default = "*" },
        git_status = { symbols = {} },
      },
    },
  },

  -- Edit a directory like a buffer: rename/move/delete files by editing text, then :w
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = { { "-", "<Cmd>Oil<CR>", desc = "Open parent directory" } },
    opts = {
      default_file_explorer = true,
      columns = vim.g.have_nerd_font and { "icon" } or {},
      view_options = { show_hidden = true },
    },
  },
}
