-- Editing plugins. The tpope ones are shared with Vim so the same keys work everywhere.
return {
  -- Tiny Vimscript plugins: load at startup so their keys always work
  { "tpope/vim-surround", lazy = false, dependencies = { "tpope/vim-repeat" } },
  { "tpope/vim-unimpaired", lazy = false },
  { "tpope/vim-abolish", lazy = false },
  { "godlygeek/tabular", cmd = "Tabularize" },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  { "vim-test/vim-test", cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast" } },

  -- Auto-close brackets and quotes
  { "nvim-mini/mini.pairs", event = "InsertEnter", opts = {} },

  -- Popup showing what your leader keys (and other prefixes) do
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { "<leader>c", group = "code" },
        { "<leader>r", group = "config" },
        { "<leader>e", desc = "Alternate file" },
        { "<leader>re", desc = "Edit config" },
        { "<leader>rv", desc = "Reload config" },
        { "<leader>s", desc = "Substitute" },
        { "<leader>v", desc = "Vertical split" },
        { "<leader>C", desc = "Copy path:line" },
        { "<leader>/", desc = "Toggle comment", mode = { "n", "x" } },
        { "<leader>g", desc = "Git blame" },
        { "<leader>u", desc = "Undo tree" },
        { "<leader>t", desc = "Test nearest" },
        { "<leader>T", desc = "Test file" },
      },
    },
  },
}
