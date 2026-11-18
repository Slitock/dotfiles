require "nvchad.mappings"

local map = vim.keymap.set

-- Навигация и режим команд
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- LSP маппинги
map("n", "<leader>ra", function()
  vim.lsp.buf.rename()
end, { desc = "LSP Rename" })

-- Работа с базами данных (vim-dadbod-ui)
map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })

-- Markdown Preview (открытие/закрытие превью в браузере)
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
