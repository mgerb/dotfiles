return {
	"briangwaltney/paren-hint.nvim",
	event = "BufRead",
	lazy = true,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("paren-hint")
	end,
}
