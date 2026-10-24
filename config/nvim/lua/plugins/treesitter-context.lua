return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		max_lines = 3,
		multiline_threshold = 3,
		-- Keep the function header when nested blocks exceed the line limit.
		trim_scope = "inner",
	},
}
