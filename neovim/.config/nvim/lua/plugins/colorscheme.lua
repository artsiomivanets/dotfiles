return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- load before other plugins so colors apply first
  config = function()
    vim.o.background = "light"
    require("gruvbox").setup({
      undercurl = true,
      underline = true,
      bold = true,
      italic = {},
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = "soft",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")
  end,
}
