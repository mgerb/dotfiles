return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = true,
	cmd = { "NvimTreeToggle" },
	opts = {
		renderer = {
			highlight_opened_files = "all",
		},
		update_focused_file = {
			enable = true,
		},
		view = {
			width = 40,
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
