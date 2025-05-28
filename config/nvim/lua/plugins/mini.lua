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
			local notify = require("mini.notify")
			notify.setup()

			vim.notify = notify.make_notify({})
		end,
	},
}
