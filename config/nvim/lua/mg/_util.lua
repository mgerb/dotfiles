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

---Check if a require statement will work
---@param path string this is the same argument that would be passed into the `require` function
---@return boolean
M.check_require = function(path)
	local paths = vim.fn.split(path, "\\.")
	local full_path = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", unpack(paths))
	full_path = full_path .. ".lua"
	return vim.fn.filereadable(full_path) == 1
end

return M
