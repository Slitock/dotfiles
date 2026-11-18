local options = {
formatters_by_ft = {
  lua = { "stylua" },
  python = { "black" },
  sql = { "sql_formatter" },
},

formatters = {
  sql_formatter = {
    prepend_args = {
      "-c",
      vim.fn.json_encode({
        keywordCase = "upper",
        language = "sql",
        tabWidth = 2,
        useTabs = false,
      }),
    },
  },
},

format_on_save = {
  timeout_ms = 500,
  lsp_fallback = true,
},
}

return options
