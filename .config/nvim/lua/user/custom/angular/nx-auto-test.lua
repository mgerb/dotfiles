-- credits to @justinrassier for writing this
local get_project_name_from_path = require("user.custom.utils").get_project_name_from_path
local inline_testing_augroup = vim.api.nvim_create_augroup("InlineTesting", { clear = true })

vim.api.nvim_create_user_command("AttachToTest", function()
	-- get current buffer name
	local buf_name = vim.api.nvim_buf_get_name(0)
	local ns = vim.api.nvim_create_namespace("InlineTesting")
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = inline_testing_augroup,
		pattern = buf_name,
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
			vim.diagnostic.reset(ns, bufnr)

			local current_buffer = vim.api.nvim_buf_get_name(0)
			local project_name = get_project_name_from_path(current_buffer)

			-- add an hour glass to each test line
			local line_num = 0
			for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
				-- get the test name from the it statement
				local test = string.match(line, "it%(['\"](.*)['\"].*%)")
				local text = { "⌛" }

				if test ~= nil then
					vim.api.nvim_buf_set_extmark(bufnr, ns, line_num, 0, { virt_text = { text } })
				end
				line_num = line_num + 1
			end

			vim.fn.jobstart({
				"nx",
				"test",
				project_name,
				"--testFile=" .. current_buffer,
				"--json",
				"--outputFile=/tmp/results.json",
				"--skip-nx-cache",
			}, {
				stdout_buffered = true,
				on_exit = function()
					-- read in JSON file
					local file = io.open("/tmp/results.json", "r")
					if file ~= nil then
						local json = file:read("*all")
						local results = vim.fn.json_decode(json)
						file:close()

						-- get the test results
						local testResults = results.testResults[1].assertionResults

						-- -- make a map of test name to result
						local testMap = {}
						for _, result in ipairs(testResults) do
							-- table.insert(testMap, {name = result.title, status = result.status})
							testMap[result.title] = {
								status = result.status,
								error_message = result.failureMessages[1],
							}
						end
						-- get current buffer
						vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

						-- for each line in buffer check if it has a test
						local diagnostics_tbl = {}
						local line_num = 0
						for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
							-- get the test name from the it statement
							local test = string.match(line, "it%(['\"](.*)['\"].*%)")

							if test ~= nil then
								local result = testMap[test]
								if result ~= nil then
									if result.status == "passed" then
										local text = { "✅" }
										vim.api.nvim_buf_set_extmark(bufnr, ns, line_num, 0, { virt_text = { text } })
									elseif result.status == "failed" then
										table.insert(diagnostics_tbl, {
											bufnr = bufnr,
											lnum = line_num,
											col = 0,
											end_lnum = line_num,
											end_col = 0,
											severity = vim.diagnostic.severity.ERROR,
											message = result.error_message,
										})
									end
								end
							end
							line_num = line_num + 1
						end
						vim.diagnostic.set(ns, bufnr, diagnostics_tbl, {})
					end
				end,
			})
		end,
	})
end, {})