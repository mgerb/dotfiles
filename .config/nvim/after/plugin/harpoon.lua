local harpoon = require("harpoon")

harpoon.setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 40,
	},
})

require("telescope").load_extension("harpoon")
