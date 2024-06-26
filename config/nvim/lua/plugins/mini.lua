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
		"echasnovski/mini.cursorword",
		version = "*",
		event = "BufRead",
		lazy = true,
		opts = {
			delay = 800,
		},
		config = function()
			require("mini.cursorword").setup()
		end,
		init = function()
			local palette = require("kanagawa.colors").setup().palette

			vim.api.nvim_command("highlight MatchBackground guibg=" .. palette.waveBlue1)
			vim.api.nvim_command("highlight MatchParen guibg=" .. palette.waveBlue1)
			vim.api.nvim_command("highlight MatchWord guibg=" .. palette.waveBlue1)
			vim.api.nvim_command("highlight MatchParenCur guibg=" .. palette.waveBlue1)
			vim.api.nvim_command("highlight MatchWordCur guibg=" .. palette.waveBlue1)

			vim.api.nvim_command("highlight MiniCursorword gui=NONE guibg=" .. palette.waveBlue1)
			vim.api.nvim_command("highlight MiniCursorwordCurrent gui=NONE guibg=" .. palette.waveBlue1)
			vim.api.nvim_command("highlight MiniCursorwordWrite gui=NONE guibg=" .. palette.waveBlue1)
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
