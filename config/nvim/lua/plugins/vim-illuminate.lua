return {
	"RRethy/vim-illuminate",
	lazy = true,
	event = "BufRead",
	config = function()
		require("illuminate").configure({
			-- To get the buffer file type = :set filetype
			filetypes_denylist = {
				"oil",
				"dbui",
				"dbout", -- dbui results list
				"NvimTree",
			},
		})
	end,
}
