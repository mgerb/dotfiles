local dracula = require("dracula")
require("illuminate").configure()

vim.cmd("hi def IlluminatedWordWrite guibg=" .. dracula.colors().selection)
vim.cmd("hi def IlluminatedWordText guibg=" .. dracula.colors().selection)
vim.cmd("hi def IlluminatedWordRead guibg=" .. dracula.colors().selection)
