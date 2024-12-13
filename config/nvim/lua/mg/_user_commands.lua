local M = {}

---Temporary function used for testing things out
M.playground = function()
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

M.telescope_live_grep_oil = function()
	require("mg._telescope").live_grep_oil()
end

M.telescope_find_files_oil = function()
	require("mg._telescope").find_files_oil()
end

---Get the untracked module if it exists
---@return table|nil
M._get_untracked_module = function()
	if require("mg._util").check_require("mg._untracked") then
		return require("mg._untracked")
	end
	return nil
end

M.setup = function()
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
end

return M
