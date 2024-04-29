-- Cache values in mg_cache.json

local M = {}
local cache_file_name = "mg_cache.json"

M.get_cache_file_path = function()
	return vim.fn.stdpath("data") .. "/" .. cache_file_name
end

M.get_value = function(key)
	local file_path = M.get_cache_file_path()
	if vim.fn.getfsize(file_path) > 0 then
		local file = vim.fn.readfile(file_path)
		local decoded_file = vim.fn.json_decode(file)
		if decoded_file[key] then
			return decoded_file[key]
		else
			return nil
		end
	else
		return nil
	end
end

M.set_value = function(key, value)
	local file_path = M.get_cache_file_path()

	if vim.fn.getfsize(file_path) > 0 then
		local file = vim.fn.readfile(file_path)
		local decoded_file = vim.fn.json_decode(file)
		decoded_file[key] = value
		local encoded_file = vim.fn.json_encode(decoded_file)
		vim.fn.writefile({ encoded_file }, file_path)
	else
		local contents = {}
		contents[key] = value
		local encoded_contents = vim.fn.json_encode(contents)
		vim.fn.writefile({ encoded_contents }, file_path)
	end
end

return M
