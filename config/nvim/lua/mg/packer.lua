-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		use("nvim-lua/plenary.nvim")

		-- LSP
		use({
			"VonHeikemen/lsp-zero.nvim",
			branch = "v2.x",
			requires = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },
				{ "jose-elias-alvarez/null-ls.nvim" },
				{ "jay-babu/mason-null-ls.nvim" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-cmdline" },
				{ "saadparwaiz1/cmp_luasnip" },
				{ "hrsh7th/cmp-nvim-lua" },
				{ "ray-x/lsp_signature.nvim" },

				-- Snippets
				{ "L3MON4D3/LuaSnip" },
			},
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-live-grep-args.nvim" } },
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

		-- git
		use("lewis6991/gitsigns.nvim")
		use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

		-- misc
		use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" }, tag = "nightly" })
		use("folke/which-key.nvim")
		use("theprimeagen/harpoon")
		use("mbbill/undotree")
		use("numToStr/Comment.nvim")
		use("RRethy/vim-illuminate")
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})
		use("editorconfig/editorconfig-vim")
		use("norcalli/nvim-colorizer.lua")
		use("folke/todo-comments.nvim")
		use("windwp/nvim-ts-autotag")
		use("windwp/nvim-autopairs")

		-- color schemes
		use("rebelot/kanagawa.nvim")

		-- angular
		use("johnpapa/vscode-angular-snippets")
		use({ "justinrassier/nvim-treesitter-angular", branch = "fixes" })
		use("justinrassier/jesting.nvim")

		use("mgerb/metrics.nvim")
		-- use("/Users/mgerber/Desktop/git/metrics.nvim")
	end,
})
