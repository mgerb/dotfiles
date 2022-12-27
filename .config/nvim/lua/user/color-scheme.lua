-- Color scheme overrides for the old Dracula theme I was using.
-- Switched to the official vim Dracula because they kept merging
-- in changes breaking this one.
--
-- local dracula = require("dracula")
--
-- dracula.setup({
-- 	overrides = {
-- 		["@text"] = { fg = dracula.colors().bright_white },
-- 		["@text.strong"] = { fg = dracula.colors().bright_white },
-- 		["@tag"] = { fg = dracula.colors().pink },
-- 		["@tag.delimiter"] = { fg = dracula.colors().white },
-- 		["@comment"] = { fg = dracula.colors().comment },
-- 		htmlEndTag = { fg = dracula.colors().white },
-- 		htmlTag = { fg = dracula.colors().pink },
-- 		htmlTagN = { fg = dracula.colors().pink },
-- 		htmlTagName = { fg = dracula.colors().pink },
-- 		Function = { fg = dracula.colors().green },
-- 		Search = { fg = dracula.colors().orange, bg = dracula.colors().comment },
-- 		IncSearch = { fg = dracula.colors().black, bg = dracula.colors().orange },
-- 		CurSearch = { link = "IncSearch" },
-- 		["@property"] = { fg = dracula.colors().fg },
-- 	},
-- })

vim.cmd([[colorscheme dracula]])
vim.o.background = "dark"

local highlight = function(group, fg, bg, attr, sp)
	fg = fg and "guifg=" .. fg or "guifg=NONE"
	bg = bg and "guibg=" .. bg or "guibg=NONE"
	attr = attr and "gui=" .. attr or "gui=NONE"
	sp = sp and "guisp=" .. sp or ""

	vim.api.nvim_command("highlight " .. group .. " " .. fg .. " " .. bg .. " " .. attr .. " " .. sp)
end

local colors = {
	red = "#FF5555",
	red_dark = "#660000",
	orange = "#FFB86C",
	orange_dark = "#994f00",
	orange_darker = "#663500",
	green = "#50fa7b",
	green_dark = "#024a14",
}

highlight("GitSignsAdd", colors.green, nil, "none", nil)
highlight("GitSignsChange", colors.orange, nil, "none", nil)
highlight("GitSignsDelete", colors.red, nil, "none", nil)

highlight("DiffAdd", nil, colors.green_dark, "none", nil)
highlight("DiffChange", nil, colors.orange_darker, "none", nil)
highlight("DiffDelete", nil, colors.red_dark, "none", nil)
highlight("DiffText", nil, colors.orange_dark, "none", nil)
