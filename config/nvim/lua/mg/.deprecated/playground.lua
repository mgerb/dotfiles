local util = require("mg.util")

local M = {}

M.test_func = function()
	local out = vim.system({
		"curl",
		"-L",
		"-A",
		"Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0",
		"https://reddit.com/r/all.json",
		"|",
		"jq",
		".",
	}, { text = true }):wait()

	local output = vim.json.decode(out.stdout)

	local buf = vim.api.nvim_create_buf(false, false)
	vim.cmd("split")
	vim.api.nvim_set_option_value("filetype", "json", { buf = buf })
	vim.api.nvim_set_current_buf(buf)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { vim.json.encode(output) })
	require("conform").format({ async = true, lsp_fallback = true })
end

M.execute_system_command = function()
	local command_string = util.get_selection()
	local output = io.popen(command_string):read()
	local buf = vim.api.nvim_create_buf(false, false)
	vim.cmd("split")
	vim.api.nvim_set_current_buf(buf)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { vim.fn.trim(output) })
end

M._oil_get_cursor_dir = function()
	local oil = require("oil")
	local entry = oil.get_cursor_entry()
	local current_dir = oil.get_current_dir()
	if entry and entry.type == "directory" then
		return current_dir .. entry.parsed_name
	end
	return nil
end

M.telescope_live_grep_oil = function()
	local cursor_dir = M._oil_get_cursor_dir()
	if cursor_dir then
		require("telescope").extensions.live_grep_args.live_grep_args({
			theme = require("mg.custom.telescope").get_my_theme(),
			cwd = cursor_dir,
		})
	end
end

M.telescope_find_files_oil = function()
	local cursor_dir = M._oil_get_cursor_dir()
	if cursor_dir then
		local opts = vim.tbl_deep_extend("force", require("mg.custom.telescope").get_my_theme(), { cwd = cursor_dir })
		require("telescope.builtin").find_files(opts)
	end
end

vim.api.nvim_create_user_command("MG", function(input)
	M[input.args]()
end, {
	nargs = 1,
	complete = function()
		---@type string[]
		local output = {}
		for key, _ in pairs(M) do
			if not vim.startswith(key, "_") then
				table.insert(output, key)
			end
		end
		return output
	end,
})
