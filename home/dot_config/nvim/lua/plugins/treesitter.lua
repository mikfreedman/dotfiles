-- Tree-sitter: syntax highlighting, indentation and folding from real parse trees.
-- Needs the `tree-sitter` CLI and a C compiler (bootstrap.sh installs the CLI).

local parsers = {
  "bash", "css", "diff", "dockerfile", "gitcommit", "go", "gomod", "html",
  "javascript", "jsdoc", "json", "lua", "markdown", "markdown_inline", "query",
  "regex", "rust", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(parsers)
      else
        vim.notify("tree-sitter CLI not found; skipping parser install (run bootstrap.sh)", vim.log.levels.WARN)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        callback = function(event)
          if pcall(vim.treesitter.start, event.buf) then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- Select/move by function, class, argument: vaf, dif, ]f, [f, ...
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })
      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      for keys, query in pairs({
        af = "@function.outer", ["if"] = "@function.inner",
        ac = "@class.outer", ic = "@class.inner",
        aa = "@parameter.outer", ia = "@parameter.inner",
      }) do
        vim.keymap.set({ "x", "o" }, keys, function()
          select.select_textobject(query, "textobjects")
        end, { desc = query })
      end
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Previous function" })
    end,
  },
}
