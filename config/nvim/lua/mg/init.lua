require("mg.options")
require("mg.windows")
require("mg.user_commands")

local M = {
	state = require("mg.state"),
	colors = require("mg.colors"),
}

local lazy_modules = {
	util = "mg.util",
	angular = "mg.angular",
	telescope = "mg.telescope",
}

return setmetatable(M, {
	__index = function(t, key)
		local module_name = lazy_modules[key]
		if not module_name then
			return nil
		end

		local module = require(module_name)
		rawset(t, key, module)
		return module
	end,
})
