return {
  -- Чтение PDF прямо в Neovim (рендер страниц через kitty graphics protocol)
  {
    "r-pletnev/pdfreader.nvim",
    lazy = false,
    dependencies = {
      -- Рендеринг изображений (обязателен: lua/pdfreader/image.lua требует snacks.image)
      {
        "folke/snacks.nvim",
        opts = { image = { enabled = true } },
      },
      -- Пикеры закладок, недавних книг и оглавления (опционален, но уже есть в NvChad)
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("pdfreader").setup()
    end,
  },
}
