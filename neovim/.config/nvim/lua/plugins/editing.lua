return {
  {
    "kylechui/nvim-surround",
    version = "*", -- latest stable release (lazy semver)
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        -- Skip the treesitter provider: it uses nvim-treesitter's `master`-only
        -- `locals` module, which errors on the `main` branch / Neovim 0.12.
        providers = { "lsp", "regex" },
      })
      vim.cmd("hi link IlluminatedWordText Cursorline")
      vim.cmd("hi link IlluminatedWordRead Cursorline")
      vim.cmd("hi link IlluminatedWordWrite Cursorline")
    end,
  },
}
