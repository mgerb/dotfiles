require("lspconfig")

-- NOTE: if having formatting conflicts add language server to this list
local language_servers = { "tsserver", "sumneko_lua", "gopls", "html", "rust_analyzer" }

require("user.lsp.lsp-installer").setup(language_servers)
require("user.lsp.lsp-config").setup()
require("user.lsp.null-ls")
