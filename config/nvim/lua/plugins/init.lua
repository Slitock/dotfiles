return {
  -- LSP конфигурация
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },

  -- Улучшенный UI для селектов и инпутов
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.window = opts.window or {}
        opts.window.completion = {
          border = "rounded",
          max_height = 8, -- максимум 8 строк в списке
        }
        return opts
      end,
  },
  {
      "mfussenegger/nvim-jdtls",
      ft = { "java" },
  },
}
