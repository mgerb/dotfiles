return {
	"stevearc/oil.nvim",
	opts = {
		keymaps = {
			["<C-r>"] = "actions.refresh",
			["<C-v>"] = "actions.select_vsplit",
			["<C-l>"] = false,
			["<C-h>"] = false,
			["<C-s>"] = false,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
