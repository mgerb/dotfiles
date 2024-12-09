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

M.telescope_with_selected_text = function()
	local function getVisualSelection()
		vim.cmd('noau normal! "vy"')
		local text = vim.fn.getreg("v")
		vim.fn.setreg("v", {})

		text = string.gsub(text, "\n", "")
		if #text > 0 then
			return text
		else
			return ""
		end
	end

	local text = getVisualSelection()
	require("telescope").extensions.live_grep_args.live_grep_args({
		theme = require("mg.custom.telescope").get_my_theme(),
		default_text = text,
	})
end

return M
