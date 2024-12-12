return {
	lazy = false,
	priority = 1000,
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}

-- kanagawa
-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme kanagawa-wave")
-- 	end,
-- }
