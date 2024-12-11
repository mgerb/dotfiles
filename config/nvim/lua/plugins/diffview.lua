return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewLog" },
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	init = function()
		-- defer so we don't get race conditions with the initial load
		vim.defer_fn(function()
			local highlight = require("mg").colors.highlight
			local colors = require("mg").colors.colors

			highlight("DiffAdd", nil, colors.green_dark, "none", nil)
			highlight("DiffChange", nil, colors.orange_darker, "none", nil)
			highlight("DiffDelete", nil, colors.red_dark, "none", nil)
			highlight("DiffText", nil, colors.orange_dark, "none", nil)
		end, 500)
	end,
}
