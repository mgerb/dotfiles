-- local Job = require("plenary.job")

-- local function is_valid_git_repo()
-- 	local valid = false
-- 	Job:new({
-- 		command = "git",
-- 		args = { "status" },
-- 		on_exit = function(_result, return_val)
-- 			if return_val ~= 0 then
-- 				valid = false
-- 			else
-- 				valid = true
-- 			end
-- 		end,
-- 	}):sync()
--
-- 	return valid
-- end

local test_func = function()
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

local handler = function(args)
	vim.print(args)
end

vim.api.nvim_create_user_command("MGRun", handler, {
	nargs = 1,
	complete = function()
		return { "test", "run" }
	end,
})
