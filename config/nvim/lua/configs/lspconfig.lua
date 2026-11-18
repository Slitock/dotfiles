-- Получаем базовые возможности для автодополнения
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Безопасно подтягиваем стандартные функции обработчиков NvChad
local nv_lsp = require "nvchad.configs.lspconfig"

-- Базовые сервера
local servers = { "html", "cssls", "pyright", "clangd" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    capabilities = capabilities,
    on_attach = nv_lsp.on_attach,
    on_init = nv_lsp.on_init,
  })
  vim.lsp.enable(lsp)
end

-- Отдельная настройка sqlls с безопасным определением пути
vim.lsp.config("sqlls", {
  capabilities = capabilities,
  on_attach = nv_lsp.on_attach,
  on_init = nv_lsp.on_init,
  root_dir = function(bufnr_or_fname)
    local util = require "lspconfig.util"
    local fname = type(bufnr_or_fname) == "number" and vim.api.nvim_buf_get_name(bufnr_or_fname) or bufnr_or_fname

    if not fname or fname == "" then
      return vim.fn.getcwd()
    end

    return util.root_pattern(".sqllsrc.json", ".git")(fname) or util.path.dirname(fname) or vim.fn.getcwd()
  end,
})
vim.lsp.enable "sqlls"
