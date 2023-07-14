local harpoon = require("harpoon")

harpoon.setup({
	menu = { width = vim.api.nvim_win_get_width(0) - 40 },
	global_settings = { enter_on_sendcmd = true },
})

require("telescope").load_extension("harpoon")
