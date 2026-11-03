return {
  -- :Git, :Git blame (<leader>g) - shared with Vim
  { "tpope/vim-fugitive", cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "GBrowse" } },

  -- Changed lines in the sign column, hunk staging, inline blame
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, keys, fn, desc)
          vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = desc })
        end
        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Previous hunk")
        map("n", "<leader>cs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>cr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>cp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>cb", gs.toggle_current_line_blame, "Toggle line blame")
      end,
    },
  },
}
