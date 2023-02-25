local path = require("plenary.path")
local find_nearest_file = require("user.custom.utils").find_nearest_file
local get_project_name_from_path = require("user.custom.utils").get_project_name_from_path
local popup = require("plenary.popup")

local M = {}

-- Add current file to the nearest barrel file
vim.api.nvim_create_user_command("AddToBarrel", function()
	local current_buffer = vim.api.nvim_buf_get_name(0)
	local nearest_barrel = find_nearest_file(current_buffer, "index%.ts")

	local working_dir = tostring(path:new(nearest_barrel):parent())

	local export_path = path:new(current_buffer):make_relative(working_dir):gsub("%.ts$", "")
	local export_string = "export * from './" .. export_path .. "';"
	local nearest_barrel_path = path:new(nearest_barrel):absolute()
	local file = io.open(nearest_barrel_path)
	if file ~= nil then
		-- first check if the export is already there
		local file_contents = file:read("*all")
		file:close()

		-- esacpe the export string for lua patterns
		local escaped_export_string = export_string:gsub("%.", "%%.")
		escaped_export_string = escaped_export_string:gsub("%*", "%%*")
		escaped_export_string = escaped_export_string:gsub("%-", "%%-")

		if string.match(tostring(file_contents), escaped_export_string) == nil then
			-- open a new file handle to actually write to the file since after reading the contents it doesn't seem to write
			local write_file = io.open(nearest_barrel_path, "a")
			if write_file ~= nil then
				write_file:write(export_string)
				write_file:close()
				print("Added export to barrel file (" .. nearest_barrel_path .. ")")
			end
		else
			print("Export already exists in barrel file")
		end
	end
end, {})

local inline_testing_augroup = vim.api.nvim_create_augroup("InlineTesting", { clear = true })
local inline_testing_ns = vim.api.nvim_create_namespace("InlineTesting")
local inline_testing_results = {}
local test_results_winnr = nil

local console_logs = {}
local capturing_logs = false
local console_log_win = nil
local console_log_buf = nil

--
-- Private functions
--
vim.api.nvim_create_user_command("OpenTestResultsPanel", function()
	M.create_popup_of_test_results(inline_testing_results)
end, {})

function M.create_popup_of_test_results(test_result)
	-- creat a new buffer
	local bufnr = vim.api.nvim_create_buf(false, true)

	-- assemble list of test results
	local lines = {}
	for _, result in ipairs(test_result) do
		local text = result.passed and "✅" or "❌"
		table.insert(lines, text .. " " .. result.name)
	end

	-- add a line of text
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

	local width = 125
	local height = 25
	local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
	-- open a window in the center of the screen
	test_results_winnr, win = popup.create(bufnr, {
		title = "Test Results",
		line = math.floor(((vim.o.lines - height) / 2) - 1),
		col = math.floor((vim.o.columns - width) / 2),
		minwidth = width,
		minheight = height,
		borderchars = borderchars,
	})

	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<CR>",
		"<Cmd>lua require('user.custom.commands').select_menu_item()<CR>",
		{}
	)
end

function M.select_menu_item()
	local line_num = vim.fn.line(".")
	print(line_num)
	vim.api.nvim_win_close(test_results_winnr, true)
	test_results_winnr = nil

	-- get the test result for the selected line
	local test_result = inline_testing_results[line_num]

	-- move the cursor to the test result
	vim.api.nvim_win_set_cursor(0, { test_result.line_num + 1, 0 })
end

function M.add_extmark_to_test_result(test_results)
	local bufnr = vim.api.nvim_get_current_buf()
	local diagnostics_tbl = {}
	for _, result in ipairs(test_results) do
		if result.passed == true then
			local text = { "✅" }
			vim.api.nvim_buf_set_extmark(bufnr, inline_testing_ns, result.line_num, 0, { virt_text = { text } })
		else
			table.insert(diagnostics_tbl, {
				bufnr = bufnr,
				lnum = result.line_num,
				col = 0,
				end_lnum = result.line_num,
				end_col = 0,
				severity = vim.diagnostic.severity.ERROR,
				message = "Test Failed: " .. result.error_message,
			})
		end
	end
	vim.diagnostic.set(inline_testing_ns, bufnr, diagnostics_tbl, {})
end

function M.get_matching_it_statements_for_line(line)
	return string.match(line, "it%(['\"](.*)['\"].*%)")
end

function M.clear_namespace_for_current_buffer(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, inline_testing_ns, 0, -1)
	vim.diagnostic.reset(inline_testing_ns, bufnr)
end

function M.clear_console_log_stuff()
	console_logs = {}
	if console_log_win ~= nil then
		if vim.api.nvim_win_is_valid(console_log_win) then
			vim.api.nvim_win_close(console_log_win, true)
		end
		console_log_win = nil
	end
	if console_log_buf ~= nil then
		if vim.api.nvim_buf_is_valid(console_log_buf) then
			vim.api.nvim_buf_delete(console_log_buf, { force = true })
		end
		console_log_buf = nil
	end
end

function M.open_console_log_win()
	if #console_logs > 0 then
		local current_win = vim.api.nvim_get_current_win()
		if console_log_win == nil then
			vim.fn.execute("80 vnew")
			console_log_win = vim.api.nvim_get_current_win()
		end
		if console_log_buf == nil then
			console_log_buf = vim.api.nvim_get_current_buf()
			-- set buffer to be a scratch buffer
			vim.api.nvim_buf_set_option(console_log_buf, "buflisted", false)
		end
		vim.api.nvim_buf_set_lines(console_log_buf, 0, -1, false, console_logs)
		vim.api.nvim_win_set_buf(console_log_win, console_log_buf)

		-- set cursor back to the original window
		vim.api.nvim_set_current_win(current_win)
	end
end

return M