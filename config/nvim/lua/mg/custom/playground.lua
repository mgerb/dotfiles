local Job = require("plenary.job")

local function is_valid_git_repo()
	local valid = false
	Job:new({
		command = "git",
		args = { "status" },
		on_exit = function(_result, return_val)
			if return_val ~= 0 then
				valid = false
			else
				valid = true
			end
		end,
	}):sync()

	return valid
end

vim.api.nvim_create_user_command("MGRun", function(opts)
	if is_valid_git_repo() then
		print("valid")
	else
		print("not valid")
	end
end, {})
