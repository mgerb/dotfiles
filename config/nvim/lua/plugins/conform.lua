return {
	"stevearc/conform.nvim",
	event = "BufRead",
	opts = {
		notify_on_error = true,
		-- format_on_save = {
		-- 	timeout_ms = 500,
		-- 	lsp_fallback = true,
		-- },
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			lua = { "stylua" },
			python = { "black" },
			rust = { "rust-analyzer" },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
		},
	},
	formatters = {
		["clang-format"] = {
			prepend_args = { "-style={BasedOnStyle: llvm, IndentWidth: 4}" },
		},
	},
}
