return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        ruby = { "rubocop" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        c = { "clang_format" },
        cpp = { "clang_format" },
      },
      -- Format on save; fall back to LSP formatting when no formatter is set
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
    })

    -- Manual format (was <space>cf via vim.lsp.buf.format)
    vim.keymap.set({ "n", "v" }, "<space>cf", function()
      conform.format({ async = true, lsp_format = "fallback" })
    end, { noremap = true, silent = true, desc = "Format buffer/range" })
  end,
}
