---@module "tree-sitter-manager"
return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		---@type tree-sitter-manager.Config
		local options = {
			auto_install = true,
		}

		require("tree-sitter-manager").setup(options)
	end,
}
