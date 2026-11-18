return {
  -- Менеджер серверов, линтеров и форматировщиков
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "black",
        "clangd",
        "stylua",
        "sqlls",         -- SQL LSP
        "sql-formatter", -- Форматировщик SQL
      },
    },
  },

  -- Подсветка синтаксиса
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "c",
        "cpp",
        "markdown",
        "markdown_inline",
        "sql", -- Подсветка SQL
      },
    },
  },
}
