require("illuminate").configure({
	delay = 500,
	min_count_to_highlight = 2,
})
local dracula = require("dracula")

vim.api.nvim_command("highlight MatchBackground guibg=" .. dracula.colors().selection)
vim.api.nvim_command("highlight MatchParen guibg=" .. dracula.colors().selection)
vim.api.nvim_command("highlight MatchWord guibg=" .. dracula.colors().selection)
vim.api.nvim_command("highlight MatchParenCur guibg=" .. dracula.colors().selection)
vim.api.nvim_command("highlight MatchWordCur guibg=" .. dracula.colors().selection)

vim.api.nvim_command("highlight IlluminatedWordWrite gui=NONE guibg=" .. dracula.colors().selection)
vim.api.nvim_command("highlight IlluminatedWordText gui=NONE guibg=" .. dracula.colors().selection)
vim.api.nvim_command("highlight IlluminatedWordRead gui=NONE guibg=" .. dracula.colors().selection)
