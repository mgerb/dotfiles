return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
			opts.sources.providers = opts.sources.providers or {}
			opts.sources.providers.lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			}

			if not vim.tbl_contains(opts.sources.default, "lazydev") then
				table.insert(opts.sources.default, 1, "lazydev")
			end
		end,
	},
}
