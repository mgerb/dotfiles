local util = require("mg.util")

local M = {}

---Jump from one angular file to another
---@param extension "ts" | "html" | "spec%.ts" | "scss" | string
M.jump_to_angular_component_part = function(extension)
	local path = require("plenary.path")
	local buf_name = vim.api.nvim_buf_get_name(0)
	local buf_path = path:new(buf_name)
	local relative_path = buf_path:make_relative()
	-- extract just the filename
	local filename = string.match(relative_path, "([^/]+)$")

	-- find the name before .component
	local component_name = string.match(filename, "(.-)%.component")

	-- assemble the destination based on the extension
	local full_destination = buf_path:parent() .. "/" .. component_name .. ".component" .. "." .. extension

	local exists = vim.fn.filereadable(full_destination)
	-- don't open a buffer if the file doesn't exist since you may end up creating a file without knowing it
	if exists == 0 then
		vim.notify("File doesn't exist: " .. full_destination, vim.log.levels.WARN)
		return
	end

	util.load_file_into_buffer(full_destination)
end

return M
