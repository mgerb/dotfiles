-- vim.cmd[[colorscheme tokyonight]]
vim.cmd([[colorscheme dracula]])

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
