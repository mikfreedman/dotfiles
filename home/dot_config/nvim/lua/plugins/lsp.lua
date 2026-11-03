-- Language servers, formatters and completion (replaces Syntastic and snipMate).
-- Keymaps and diagnostics settings are in lua/config/lsp.lua.

local servers = {
  "vtsls",          -- TypeScript / JavaScript
  "eslint",
  "gopls",          -- Go
  "rust_analyzer",  -- Rust
  "bashls",         -- Shell
  "yamlls",
  "jsonls",
  "marksman",       -- Markdown
  "lua_ls",         -- for editing this config
}

local tools = { "prettierd", "goimports", "shfmt", "stylua" }

return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = { ensure_installed = tools },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = servers,
      automatic_enable = true,
    },
    config = function(_, opts)
      vim.lsp.config("lua_ls", {
        settings = { Lua = { workspace = { library = { vim.env.VIMRUNTIME } } } },
      })
      require("mason-lspconfig").setup(opts)
    end,
  },

  -- Format on save
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true }) end, mode = { "n", "x" }, desc = "Format" },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        lua = { "stylua" },
      },
      format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
    },
  },

  -- Completion
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      -- <C-n>/<C-p> to move, <C-y> to accept, <C-e> to dismiss, <C-space> to open
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = true } },
      signature = { enabled = true },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
}
