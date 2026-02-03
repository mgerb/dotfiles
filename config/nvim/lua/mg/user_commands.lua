local util = require("mg.util")
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
	require("mg.telescope").live_grep_oil()
end

---Find files within the cursor folder in Oil
M.oil_find_files = function()
	require("mg.telescope").find_files_oil()
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

--- When in oil, open the sqlite db file with vim-dadbod-ui
M.oil_open_sqlite_db = function()
	local oil = require("oil")
	local entry = oil.get_cursor_entry()
	local current_dir = oil.get_current_dir()

	if not entry or entry.type ~= "file" then
		vim.notify("Cursor is not on a file", vim.log.levels.WARN)
		return
	end

	if not current_dir then
		vim.notify("Unable to resolve current directory", vim.log.levels.ERROR)
		return
	end

	local file_path = vim.fs.joinpath(current_dir, entry.parsed_name)

	if vim.fn.filereadable(file_path) == 0 then
		vim.notify("File does not exist: " .. file_path, vim.log.levels.ERROR)
		return
	end

	local extension = vim.fn.fnamemodify(file_path, ":e")
	local is_sqlite = extension == "db" or extension == "sqlite" or extension == "sqlite3"
	if not is_sqlite then
		vim.notify("Not a sqlite db file: " .. file_path, vim.log.levels.WARN)
		return
	end

	local db_url = "sqlite:" .. file_path
	local name = vim.fn.fnamemodify(file_path, ":t")
	local dbs = vim.g.dbs

	if type(dbs) ~= "table" then
		vim.g.dbs = { { name = name, url = db_url } }
	else
		local is_list = true
		for key, _ in pairs(dbs) do
			if type(key) ~= "number" then
				is_list = false
				break
			end
		end

		if is_list then
			local updated = false
			for _, db in ipairs(dbs) do
				if db.name == name then
					db.url = db_url
					updated = true
					break
				end
			end

			if not updated then
				table.insert(dbs, { name = name, url = db_url })
			end
		else
			dbs[name] = db_url
		end
	end

	vim.cmd("DBUI")
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
		table.insert(out_lines, string.format("%" .. width .. "d %s", item.count, vim.trim(item.text)))
	end

	vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, out_lines)
end

--- Remove all carriage returns from the document.
--- This usually occurs when pasting in text content
--- into WSL.
M.remove_carriage_returns = function()
	vim.cmd("%s/\\r//g")
end

--- Open :messages in a new buffer
M.messages = function()
	vim.cmd("new")
	vim.cmd("put =execute('messages')")
end

--- Prompt for a timestamp and update the latest commit's author/committer dates
M.git_amend_commit_time = function()
	local default_timestamp = os.date("%a %b %d %H:%M:%S %Y %z")

	vim.ui.input({
		prompt = "Commit timestamp: ",
		default = default_timestamp,
	}, function(input)
		if not input or input == "" then
			return
		end

		local command_preview =
			string.format("GIT_COMMITTER_DATE='%s' git commit --amend --no-edit --date '%s'", input, input)

		local confirm = vim.fn.confirm("Run?\n" .. command_preview, "&Yes\n&No", 2)
		if confirm ~= 1 then
			return
		end

		local result = vim.system({
			"git",
			"commit",
			"--amend",
			"--no-edit",
			"--date",
			input,
		}, {
			env = { GIT_COMMITTER_DATE = input },
			text = true,
		}):wait()

		if result.code ~= 0 then
			vim.notify(result.stderr, vim.log.levels.ERROR)
			return
		end

		vim.notify("Updated commit timestamps to: " .. input, vim.log.levels.INFO)
	end)
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
