local M = {}

M.get_my_theme = function(opts)
	opts = opts or {}

	local theme_opts = {
		theme = "dropdown",
		results_title = false,
		sorting_strategy = "ascending",
		layout_strategy = "center",
		layout_config = {
			preview_cutoff = 1, -- Preview should always show (unless previewer = false)
			anchor = "CENTER",
			width = function(_, max_columns, _)
				return math.min(max_columns, 180)
			end,

			height = function(_, _, max_lines)
				return math.min(max_lines, 20)
			end,
		},
		border = true,
		borderchars = {
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
	}
	if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
		theme_opts.borderchars = {
			prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		}
	end

	return vim.tbl_deep_extend("force", theme_opts, opts)
end

return M
