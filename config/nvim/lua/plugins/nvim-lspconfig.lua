return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			htmx = {
				filetypes = { "rs", "html", "rust" },
			},
			angularls = {
				root_dir = require("lspconfig").util.root_pattern("package.json"),
			},
			docker_compose_language_service = {
				filetypes = { "yml", "yaml" },
			},
		}

		require("mason").setup()
		require("mason-tool-installer").setup({})

		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = true,
			underline = true,
		})

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		-- manually add LSP here
		local lspconfig = require("lspconfig")
		lspconfig.rust_analyzer.setup({})
		lspconfig.nil_ls.setup({})
		lspconfig.lua_ls.setup({})

		-- zig
		lspconfig.zls.setup({})
		-- prevent loclist from popping up on save
		vim.g.zig_fmt_parse_errors = 0
	end,
}
