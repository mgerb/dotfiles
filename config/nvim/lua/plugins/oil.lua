---@module "oil"

local DEFAULT_COLUMNS = { "icon", "size", "mtime" }

return {
	"stevearc/oil.nvim",
	---@type oil.SetupOpts
	opts = {
		columns = DEFAULT_COLUMNS,
		keymaps = {
			["<C-r>"] = "actions.refresh",
			["<C-v>"] = "actions.select_vsplit",
			["<C-l>"] = false,
			["<C-h>"] = false,
			["<C-s>"] = false,
		},
		view_options = {
			show_hidden = true,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	DEFAULT_COLUMNS = DEFAULT_COLUMNS,
}
