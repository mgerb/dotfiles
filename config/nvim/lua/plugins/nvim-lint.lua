return {
	"mfussenegger/nvim-lint",
	event = "BufRead",
	lazy = true,
	enabled = false,
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "mypy" },
		}

		vim.api.nvim_create_autocmd({
			"BufWritePost",
		}, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
