return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	cmd = { "Telescope" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		if vim.fn.has("win32") ~= 1 then
			require("telescope").setup({
				extensions = {
					fzf = {},
				},
			})
			require("telescope").load_extension("fzf")
		end
	end,
}
