local configs = require("nvim-treesitter.configs")
local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
ft_to_parser.ejs = "html"

local setup = {
	-- "all" causes too many errors so I just added everyone I may ever potentially use
	-- A list of parser names, or "all"
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"comment",
		"cpp",
		"css",
		"elixir",
		"go",
		"gomod",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"make",
		"rust",
		"scss",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"c_sharp",
		"cuda",
		"dart",
		"gowork",
		"graphql",
		"help",
		"http",
		"java",
		"json5",
		"kotlin",
		"latex",
		"llvm",
		"markdown",
		"python",
		"regex",
		"ruby",
		"sql",
		"svelte",
		-- "swift",
		"yaml",
	},
	-- ensure_installed = "all",

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "phpdoc", "pug" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser) list of language that will be disabled
		disable = { "" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},
}

configs.setup(setup)
