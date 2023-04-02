require'fzf-lua'.setup {
  files = {
    prompt = 'Files> ',
    cmd = "rg --files --no-ignore -g '!node_modules'"
  },
  winopts = {
    on_create = function()
      vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>", { silent = true, noremap = true })
      vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", "<Up>", { silent = true, noremap = true })
      vim.api.nvim_buf_set_keymap(0, "t", "<C-o>", "<CR>", { silent = true, noremap = true })
    end,
  },
}
