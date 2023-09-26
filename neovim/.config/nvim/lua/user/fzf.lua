require'fzf-lua'.setup {
  files = {
    fd_opts = "--no-ignore -E .git -E node_modules -E public"
  },
  winopts = {
    on_create = function()
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>", { silent = true, noremap = true })
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", "<Up>", { silent = true, noremap = true })
      vim.api.nvim_buf_set_keymap(0, "t", "<C-o>", "<CR>", { silent = true, noremap = true })
    end,
  },
}
