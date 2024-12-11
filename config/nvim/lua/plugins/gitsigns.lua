return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	cmd = { "Gitsigns" },
	event = "BufRead",
	opts = {
		current_line_blame = true,
	},
	init = function()
		-- defer so we don't get race conditions with the initial load
		vim.defer_fn(function()
			local highlight = require("mg").colors.highlight
			local colors = require("mg").colors.colors

			highlight("GitSignsAdd", colors.green, nil, "none", nil)
			highlight("GitSignsChange", colors.orange, nil, "none", nil)
			highlight("GitSignsDelete", colors.red, nil, "none", nil)
		end, 500)
	end,
}
