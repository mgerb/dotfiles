local M = {}

M.get_separator = function()
	if M.is_windows then
		return "\\"
	end
	return "/"
end

M.join_paths = function(...)
	local separator = M.get_separator()
	return table.concat({ ... }, separator)
end

M.create_folder_if_not_exists = function(folder_path)
	-- Check if the folder exists
	if vim.fn.isdirectory(folder_path) == 0 then
		-- If it doesn't exist, create it
		vim.fn.mkdir(folder_path, "p")
	end
end

M.get_visual_selection = function()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

---Load a file into anew buffer
---@param file string full path to file file
M.load_file_into_buffer = function(file)
	local uri = vim.uri_from_fname(file)
	local new_buff = vim.uri_to_bufnr(uri)
	vim.api.nvim_win_set_buf(0, new_buff)
	vim.fn.execute("edit")
end

---Get the full directory path of the item under the cursor in Oil
---Will return nil if it is not a directory
---@return string | nil
M.oil_get_cursor_dir = function()
	local oil = require("oil")
	local entry = oil.get_cursor_entry()
	local current_dir = oil.get_current_dir()
	if entry and entry.type == "directory" then
		return current_dir .. entry.parsed_name
	end
	return nil
end

return M
