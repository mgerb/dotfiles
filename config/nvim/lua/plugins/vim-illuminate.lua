return {
	"RRethy/vim-illuminate",
	lazy = true,
	event = "BufRead",
	config = function()
		require("illuminate").configure({
			filetypes_denylist = {
				"oil",
				"dbui",
				"NvimTree",
			},
		})
	end,
}
