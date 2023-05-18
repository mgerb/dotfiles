local map = require("mini.map")
map.setup({
	integrations = {
		map.gen_integration.diagnostic(),
		map.gen_integration.builtin_search(),
		map.gen_integration.gitsigns(),
	},
})
