local util = {}

util.get_separator = function()
	if util.is_windows then
		return "\\"
	end
	return "/"
end

util.join_paths = function(...)
	local separator = util.get_separator()
	return table.concat({ ... }, separator)
end

util.create_folder_if_not_exists = function(folder_path)
	-- Check if the folder exists
	if vim.fn.isdirectory(folder_path) == 0 then
		-- If it doesn't exist, create it
		vim.fn.mkdir(folder_path, "p")
	end
end

return util
