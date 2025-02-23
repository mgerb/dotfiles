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

---Open a terminal and change directories to cursor
M.oil_terminal = function()
	local cursor_dir = util.oil_get_cursor_dir()
	if cursor_dir then
		print(cursor_dir)
		vim.cmd("split")
		vim.cmd("term")
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
