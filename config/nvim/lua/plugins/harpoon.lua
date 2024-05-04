return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	opts = {
		menu = { width = vim.api.nvim_win_get_width(0) - 40 },
		global_settings = { enter_on_sendcmd = true },
	},
}
