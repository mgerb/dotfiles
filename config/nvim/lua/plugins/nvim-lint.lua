return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint_d", "eslint" },
			javascriptreact = { "eslint_d", "eslint" },
			typescript = { "eslint_d", "eslint" },
			typescriptreact = { "eslint_d", "eslint" },
			zig = { "zlint" },
		}
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
