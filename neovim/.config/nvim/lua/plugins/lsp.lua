return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", config = true },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local names = require("user.lsp.tool_names")

    -- Mason: install LSP servers + standalone tools (formatters/linters)
    require("mason").setup()
    require("mason-tool-installer").setup({ ensure_installed = names.tools })
    require("mason-lspconfig").setup({
      ensure_installed = names.servers,
      automatic_enable = true, -- auto vim.lsp.enable() installed servers
    })

    -- Global defaults merged into every server (Nvim 0.11+ native API)
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- Per-server overrides from lua/user/lsp/server_configs/<name>.lua
    for _, server in ipairs(names.servers) do
      local ok, conf = pcall(require, "user.lsp.server_configs." .. server)
      if ok then
        vim.lsp.config(server, conf)
      end
    end

    -- RuboCop's built-in LSP (`rubocop --lsp`) surfaces offenses as diagnostics.
    -- mason-lspconfig has no server mapping for it, so enable it explicitly.
    -- The binary is installed via mason-tool-installer (see tool_names.tools).
    vim.lsp.enable("rubocop")

    -- Diagnostics
    vim.diagnostic.config({
      virtual_text = false,
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    -- Diagnostic navigation (global)
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[r", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "]r", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

    -- Buffer-local LSP mappings on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set("n", "ge", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      end,
    })
  end,
}
