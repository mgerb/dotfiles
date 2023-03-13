local util = require("mg.util")

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

local config = {
	-- set our snapshot directory inside the nvim config folder
	snapshot_path = util.join_paths(vim.fn.stdpath("config"), "packer_snapshots"),
}

return require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- LSP
		use({
			"VonHeikemen/lsp-zero.nvim",
			branch = "v1.x",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" }, -- Required
				{ "williamboman/mason.nvim" }, -- Optional
				{ "williamboman/mason-lspconfig.nvim" }, -- Optional
				{ "jose-elias-alvarez/null-ls.nvim" },
				{ "jay-babu/mason-null-ls.nvim" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" }, -- Required
				{ "hrsh7th/cmp-nvim-lsp" }, -- Required
				{ "hrsh7th/cmp-buffer" }, -- Optional
				{ "hrsh7th/cmp-path" }, -- Optional
				{ "hrsh7th/cmp-cmdline" }, -- Optional
				{ "saadparwaiz1/cmp_luasnip" }, -- Optional
				{ "hrsh7th/cmp-nvim-lua" }, -- Optional

				-- Snippets
				{ "L3MON4D3/LuaSnip" }, -- Required
				{ "rafamadriz/friendly-snippets" }, -- Optional
			},
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-live-grep-args.nvim" } },
			config = function()
				require("telescope").load_extension("live_grep_args")
			end,
		})

		use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

		-- Copilot
		use({
			"github/copilot.vim",
			branch = "release",
			config = function()
				local sysname = vim.loop.os_uname().sysname
				if sysname == "Darwin" then
					vim.g.copilot_node_command = "/Users/mgerber/.nvm/versions/node/v16.19.0/bin/node"
				end
			end,
		})

		-- misc
		use({
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
		})
		use("folke/which-key.nvim")
		use("theprimeagen/harpoon")
		use("mbbill/undotree")
		use("lewis6991/gitsigns.nvim")
		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
		use({ "akinsho/toggleterm.nvim", tag = "*" })
		use("numToStr/Comment.nvim")
		use("RRethy/vim-illuminate")
		use("stevearc/aerial.nvim")
		use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && npm install" })
		use("justinrassier/jesting.nvim")
		use("editorconfig/editorconfig-vim")

		use("windwp/nvim-ts-autotag")
		use("norcalli/nvim-colorizer.lua")
		use("folke/todo-comments.nvim")
		use("windwp/nvim-autopairs")
		use("famiu/bufdelete.nvim")
		use({ "akinsho/bufferline.nvim", tag = "*" })

		-- color schemes
		-- use("folke/tokyonight.nvim")
		use("Mofiqul/dracula.nvim")

		-- angular
		use("johnpapa/vscode-angular-snippets")
	end,
	config = config,
})
