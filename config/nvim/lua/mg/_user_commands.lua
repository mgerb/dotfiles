local util = require("mg._util")
local M = {}

---Temporary function used for testing things out
M.playground = function()
	util.curl_request({
		request_type = "GET",
		url = "https://reddit.com/r/all.json",
		extra_curl_args = {
			"-A",
			"Mozilla/5.0 test",
		},
		response_type = "json",
		open_response_in_buffer = true,
	})
end

local terminal_count = 0

---Open a terminal and change directories to cursor
M.oil_terminal = function()
	local cursor_dir = util.oil_get_cursor_dir()
	if cursor_dir then
		print(cursor_dir)
		vim.cmd("split | term")
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_name(buf, "oil_term_" .. terminal_count .. ": " .. cursor_dir)
		terminal_count = terminal_count + 1
		vim.fn.chansend(vim.b.terminal_job_id, "cd " .. cursor_dir .. "\n")
	end
end

---Live grep within the cursor folder in Oil
M.oil_live_grep = function()
	require("mg._telescope").live_grep_oil()
end

---Find files within the cursor folder in Oil
M.oil_find_files = function()
	require("mg._telescope").find_files_oil()
end

---@type "all" | "default"
local oil_current_column = "default"

M.oil_toggle_columns = function()
	local oil = require("oil")
	local oil_plugin = require("plugins.oil")

	if oil_current_column == "default" then
		oil.set_columns({ "icon", "size", "mtime" })
		oil_current_column = "all"
	else
		oil.set_columns(oil_plugin.DEFAULT_COLUMNS)
		oil_current_column = "default"
	end
end

---Start profiling functions/files
M.profiler_start = function()
	vim.cmd("profile start profile.log")
	vim.cmd("profile func *")
	vim.cmd("profile file *")
end

M.profiler_stop = function()
	vim.cmd("profile pause")
	vim.cmd("noautocmd qall!")
end

M.format_csv = function()
	vim.cmd("%!column -t -s ','")
end

-- Group each line in a buffer and show in a new buffer with a count
M.count_lines_by_content = function()
	-- Get all lines in the current buffer
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	-- Count occurrences
	local counts = {}
	for _, line in ipairs(lines) do
		if line ~= "" then -- ignore empty lines (optional)
			counts[line] = (counts[line] or 0) + 1
		end
	end

	-- Convert to array for sorting
	local result = {}
	local max_count = 0
	for text, count in pairs(counts) do
		table.insert(result, { count = count, text = text })
		if count > max_count then
			max_count = count
		end
	end

	-- Sort by count (descending), then alphabetically
	table.sort(result, function(a, b)
		if a.count == b.count then
			return a.text < b.text
		else
			return a.count > b.count
		end
	end)

	-- Figure out padding width for counts
	local width = tostring(max_count):len()

	-- Create a new buffer
	vim.cmd("new") -- opens in a new window
	local new_buf = vim.api.nvim_get_current_buf()

	-- Insert results with aligned counts
	local out_lines = {}
	for _, item in ipairs(result) do
		table.insert(out_lines, string.format("%" .. width .. "d %s", item.count, item.text))
	end

	vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, out_lines)
end

--- Remove all carriage returns from the document.
--- This usually occurs when pasting in text content
--- into WSL.
M.remove_carriage_returns = function()
	vim.cmd("%s/\\r//g")
end

---Get the untracked module if it exists. This is used to
---store lua commands, which cannot be checked into the repo.
---To do this, create a _untracked.lua file in this directory.
---@return table|nil
M._get_untracked_module = function()
	if util.check_require("mg._untracked") then
		return require("mg._untracked")
	end
	return nil
end

---This user command consumes module M, and adds a user
---command option for each key in the module, only if it
---does not start with "_", or is "setup".
---@param args any
vim.api.nvim_create_user_command("MG", function(args)
	local untracked = M._get_untracked_module()

	if M[args.args] then
		M[args.args](args)
	elseif untracked and untracked[args.args] then
		untracked[args.args](args)
	end
end, {
	nargs = 1,
	complete = function()
		local module = M

		-- Check if the untracked module exists and then
		-- append it to our module if it does.
		local untracked = M._get_untracked_module()

		if untracked then
			module = vim.tbl_deep_extend("force", module, untracked)
		end

		---@type string[]
		local output = {}

		for key, _ in pairs(module) do
			if not vim.startswith(key, "_") and key ~= "setup" then
				table.insert(output, key)
			end
		end

		return output
	end,
	range = true,
})
