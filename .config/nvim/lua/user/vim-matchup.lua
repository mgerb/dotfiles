local dracula = require("dracula")

vim.cmd("hi MatchBackground guibg=" .. dracula.colors().selection)
vim.cmd("hi MatchParen guibg=" .. dracula.colors().selection)
vim.cmd("hi MatchWord guibg=" .. dracula.colors().selection)
vim.cmd("hi MatchParenCur guibg=" .. dracula.colors().selection)
vim.cmd("hi MatchWordCur guibg=" .. dracula.colors().selection)

vim.cmd("hi def IlluminatedWordWrite guibg=" .. dracula.colors().selection)
vim.cmd("hi def IlluminatedWordText guibg=" .. dracula.colors().selection)
vim.cmd("hi def IlluminatedWordRead guibg=" .. dracula.colors().selection)

vim.g.matchup_matchparen_offscreen = { method = "popup" }
