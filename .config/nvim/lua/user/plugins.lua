local util = require("util")
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer = require("packer")

packer.init({
	-- set our snapshot directory inside the nvim config folder
	snapshot_path = util.join_paths(vim.fn.stdpath("config"), "packer_snapshots"),
})

local use = packer.use

use("wbthomason/packer.nvim")
use("nvim-lua/plenary.nvim")
use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
use("kyazdani42/nvim-web-devicons")
use("kyazdani42/nvim-tree.lua")
use("famiu/bufdelete.nvim")
use("folke/which-key.nvim")
use("numToStr/Comment.nvim")
use("akinsho/toggleterm.nvim")
use({ "nvim-telescope/telescope.nvim", requires = {
	{ "nvim-telescope/telescope-live-grep-args.nvim" },
} })
use("lewis6991/gitsigns.nvim")
use("windwp/nvim-autopairs")
use("sindrets/diffview.nvim")
use("windwp/nvim-ts-autotag")
use("norcalli/nvim-colorizer.lua")
use("folke/todo-comments.nvim")
use("ThePrimeagen/harpoon")
use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && npm install" })
use("editorconfig/editorconfig-vim")
use("nvim-lualine/lualine.nvim")

use("justinrassier/jesting.nvim")

use({
	"github/copilot.vim",
	branch = "release",
	config = function()
		local sysname = vim.loop.os_uname().sysname
		if sysname == "Darwin" then
			vim.g.copilot_node_command = "/Users/mgerber/.nvm/versions/node/v16.18.1/bin/node"
		end
	end,
})

-- official dracula vim theme
-- use("dracula/vim")

-- old dracula theme I was using - kept breaking with updates
use("Mofiqul/dracula.nvim")

-- other color schemes to test out
use("EdenEast/nightfox.nvim")
use("folke/tokyonight.nvim")
use("ellisonleao/gruvbox.nvim")
--

-- lsp
use("williamboman/mason.nvim")
use("williamboman/mason-lspconfig.nvim")
use("neovim/nvim-lspconfig")
use("jose-elias-alvarez/null-ls.nvim")

-- completions
use("hrsh7th/nvim-cmp")
use("hrsh7th/cmp-nvim-lsp")
use("hrsh7th/cmp-buffer") -- buffer completions
use("hrsh7th/cmp-path") -- path completions
use("hrsh7th/cmp-cmdline") -- cmdline completions
use("ray-x/lsp_signature.nvim")

-- luasnip
use("L3MON4D3/LuaSnip")
use("saadparwaiz1/cmp_luasnip")

-- angular
use("johnpapa/vscode-angular-snippets")

use({ "akinsho/bufferline.nvim", tag = "*" })

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
	require("packer").sync()
end
