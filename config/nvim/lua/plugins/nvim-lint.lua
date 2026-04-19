return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			zig = { "zlint" },
		}
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
