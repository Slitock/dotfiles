return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          local cmp = require "cmp"
          cmp.setup.buffer {
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "nvim_lsp" },
              {
                name = "buffer",
                option = {
                  -- Заставляет cmp читать ключевые слова языка из синтаксического подсветчика Vim
                  get_bufnrs = function()
                    return { vim.api.nvim_get_current_buf() }
                  end,
                },
              },
            },
          }
        end,
      })
    end,
  },
}
