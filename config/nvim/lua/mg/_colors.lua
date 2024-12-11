local M = {}

M.colors = {
	red = "#FF5555",
	red_dark = "#660000",
	orange = "#FFB86C",
	orange_dark = "#994f00",
	orange_darker = "#663500",
	green = "#50fa7b",
	green_dark = "#024a14",
}

---Utility function for setting highlight colors
---@param group string
---@param fg string
---@param bg string
---@param attr string
---@param sp string
function M.highlight(group, fg, bg, attr, sp)
	fg = fg and "guifg=" .. fg or "guifg=NONE"
	bg = bg and "guibg=" .. bg or "guibg=NONE"
	attr = attr and "gui=" .. attr or "gui=NONE"
	sp = sp and "guisp=" .. sp or ""

	vim.api.nvim_command("highlight " .. group .. " " .. fg .. " " .. bg .. " " .. attr .. " " .. sp)
end

return M
