return {
	priority = 1000,
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		local color = "#00000f"
		require("catppuccin").setup({
			flavour = "mocha",
			color_overrides = {
				mocha = {
					base = color,
					mantle = color,
					crust = color,
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
