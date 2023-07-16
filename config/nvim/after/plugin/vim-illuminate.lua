require("illuminate").configure({
	delay = 500,
	min_count_to_highlight = 2,
})
local palette = require("kanagawa.colors").setup().palette

vim.api.nvim_command("highlight MatchBackground guibg=" .. palette.waveBlue1)
vim.api.nvim_command("highlight MatchParen guibg=" .. palette.waveBlue1)
vim.api.nvim_command("highlight MatchWord guibg=" .. palette.waveBlue1)
vim.api.nvim_command("highlight MatchParenCur guibg=" .. palette.waveBlue1)
vim.api.nvim_command("highlight MatchWordCur guibg=" .. palette.waveBlue1)

vim.api.nvim_command("highlight IlluminatedWordWrite gui=NONE guibg=" .. palette.waveBlue1)
vim.api.nvim_command("highlight IlluminatedWordText gui=NONE guibg=" .. palette.waveBlue1)
vim.api.nvim_command("highlight IlluminatedWordRead gui=NONE guibg=" .. palette.waveBlue1)
