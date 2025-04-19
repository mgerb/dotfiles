local util = require("mg._util")

local M = {}

M.get_theme = function(opts)
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

M.find_files_with_selection = function()
	local text = require("mg._util").get_visual_selection({ remove_new_lines = true })
	local opts = vim.tbl_deep_extend("force", M.get_theme(), {
		default_text = text,
	})
	require("telescope.builtin").find_files(opts)
end

M.live_grep_with_selection = function()
	local text = require("mg._util").get_visual_selection({ remove_new_lines = true })
	require("telescope").extensions.live_grep_args.live_grep_args({
		theme = M.get_theme(),
		default_text = text,
	})
end

---Live grep within the cursor folder in Oil
M.live_grep_oil = function()
	local cursor_dir = util.oil_get_cursor_dir()
	if cursor_dir then
		require("telescope").extensions.live_grep_args.live_grep_args({
			theme = M.get_theme(),
			cwd = cursor_dir,
		})
	end
end

---Find files within the cursor folder in Oil
M.find_files_oil = function()
	local cursor_dir = util.oil_get_cursor_dir()
	if cursor_dir then
		local opts = vim.tbl_deep_extend("force", M.get_theme(), { cwd = cursor_dir })
		require("telescope.builtin").find_files(opts)
	end
end

return M
