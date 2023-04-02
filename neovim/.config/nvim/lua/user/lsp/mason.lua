local names = require("user.lsp.tool_names")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = names.servers
})
