return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        icons_enabled = vim.g.have_nerd_font,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_c = { { "filename", path = 1 } },
      },
    },
  },
  { "nvim-tree/nvim-web-devicons", lazy = true, enabled = vim.g.have_nerd_font },
}
