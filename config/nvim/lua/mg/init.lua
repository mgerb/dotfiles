local M = {}

M.state = require("mg._state")
M.colors = require("mg._colors")
M.util = require("mg._util")
M.angular = require("mg._angular")
M.telescope = require("mg._telescope")

---Import and execute all setup lua files
M.setup = function()
	require("mg._options")
	require("mg._windows")
	require("mg._user_commands")
end

return M
