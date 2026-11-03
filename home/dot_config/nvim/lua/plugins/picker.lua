-- Fuzzy finding and grep (replaces Command-T, FuzzyFinder and ack.vim)
return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return {
        defaults = { file_icons = vim.g.have_nerd_font },
      }
    end,
    keys = {
      { "<leader>f", "<Cmd>FzfLua files<CR>", desc = "Find files" },
      { "<leader>b", "<Cmd>FzfLua buffers<CR>", desc = "Buffers" },
      { "<leader>o", "<Cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
      { "<leader>a", "<Cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
      { "<leader>a", "<Cmd>FzfLua grep_visual<CR>", mode = "x", desc = "Grep selection" },
      { "<leader>A", "<Cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>h", "<Cmd>FzfLua helptags<CR>", desc = "Help" },
      { "<leader>D", "<Cmd>FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics" },
      { "<leader>.", "<Cmd>FzfLua resume<CR>", desc = "Resume last picker" },
    },
  },
}
