---@module "snacks"

return {
	"folke/snacks.nvim",
	event = { "BufReadPre", "BufNewFile" },
	---@type snacks.Config
	opts = {
		---@type snacks.bigfile.Config
		bigfile = {
			notify = true,
			size = 1.5 * 1024 * 1024, -- 1.5MB
		},
	},
}
