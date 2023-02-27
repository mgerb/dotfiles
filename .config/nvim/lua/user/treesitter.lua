local configs = require("nvim-treesitter.configs")
local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.ejs = "html"

local setup = {
  -- A list of parser names, or "all"
  ensure_installed = "all",
  -- List of parsers to ignore installing (for "all")
  ignore_install = { "phpdoc", "pug" },
  highlight = {
    enable = true,
  },
  additional_vim_regex_highlighting = false,
  matchup = {
    enable = true,
  },
}

configs.setup(setup)
