return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
    { "<leader>fa", function() require("fzf-lua").grep({ search = "" }) end, desc = "Live grep" },
    { "<leader>b", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
  },
  config = function()
    require("fzf-lua").setup {
      files = {
        fd_opts = "--no-ignore -E .git -E node_modules -E public",
      },
      winopts = {
        on_create = function()
          vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>", { silent = true, noremap = true })
          vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", "<Up>", { silent = true, noremap = true })
          vim.api.nvim_buf_set_keymap(0, "t", "<C-o>", "<CR>", { silent = true, noremap = true })
        end,
      },
    }
  end,
}
