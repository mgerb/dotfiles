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

M.setup = function()
	vim.api.nvim_create_user_command("MG", function(args)
		M[args.args](args)
	end, {
		nargs = 1,
		complete = function()
			---@type string[]
			local output = {}
			for key, _ in pairs(M) do
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
