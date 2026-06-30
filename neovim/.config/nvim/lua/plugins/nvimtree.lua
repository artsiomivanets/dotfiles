return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader><leader>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    { "<C-m>", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal file in tree" },
  },
  config = function()
    require("nvim-tree").setup({
      git = {
        ignore = false,
      },
    })
  end,
}
