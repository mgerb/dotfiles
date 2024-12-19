return {
	{
		"echasnovski/mini.comment",
		version = "*",
		lazy = true,
		event = "BufRead",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.notify",
		version = "*",
		config = function()
			require("mini.notify").setup()
		end,
	},
}
