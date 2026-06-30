-- Parsers to install (kept from the old `ensure_installed`)
local install_langs = { "c", "lua", "vim", "javascript", "css", "yaml", "json", "ruby", "html" }
-- Filetypes to actually start TS highlighting for. `c` is intentionally
-- excluded to match the old `highlight.disable = { "c", "rust" }`.
local highlight_fts = { "lua", "vim", "javascript", "css", "yaml", "json", "ruby", "html" }

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- required for Neovim 0.12+; `master` breaks highlighting here
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()

      -- The `main` branch compiles parsers with the external `tree-sitter` CLI.
      -- Only install when it's available, otherwise we'd error on every startup.
      -- (Install it with: sudo pacman -S tree-sitter-cli)
      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(install_langs)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = highlight_fts,
        callback = function()
          -- pcall: parser may still be installing on first launch
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  -- The `main` branch dropped the module system that nvim-treesitter-endwise
  -- relied on, so use tpope's treesitter-independent endwise (Ruby, Lua, sh, ...).
  {
    "tpope/vim-endwise",
    event = "InsertEnter",
  },
}
