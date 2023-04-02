local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            timeout_ms = 5000,
            filter = function(c)
              return c.name == "null-ls"
            end
          })
        end
      })
    end
  end,

  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.erb_lint,
    null_ls.builtins.diagnostics.erb_lint,
  },
})
