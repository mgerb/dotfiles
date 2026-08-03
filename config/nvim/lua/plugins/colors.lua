return {
	priority = 1000,
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		-- local color = "#00000f"
		---@type CatppuccinOptions
		require("catppuccin").setup({
			flavour = "mocha",
			color_overrides = {
				-- mocha = {
				-- 	base = color,
				-- 	mantle = color,
				-- 	crust = color,
				-- },

				-- defaults
				-- mocha = {
				-- 	base = "#1e1e2e",
				-- 	mantle = "#181825",
				-- 	crust = "#11111b",
				-- },

				-- darken defaults by 10%
				mocha = {
					base = "#0f0f17",
					mantle = "#0c0c12",
					crust = "#08080d",
				},
			},
			auto_integrations = true,
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
