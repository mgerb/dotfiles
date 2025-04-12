---@module "snacks"

return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		---@type snacks.bigfile.Config
		bigfile = {
			notify = true,
			size = 1.5 * 1024 * 1024, -- 1.5MB
		},
	},
}
