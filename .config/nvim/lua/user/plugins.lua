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
	-- snapshot = "1", // startup snapshot - not working??
	-- set our snapshot directory inside the nvim config folder
	snapshot_path = util.join_paths(vim.fn.stdpath("config"), "packer_snapshots"),
})

local use = packer.use

use("wbthomason/packer.nvim")
use("nvim-lua/plenary.nvim")
use("kyazdani42/nvim-web-devicons")
use("kyazdani42/nvim-tree.lua")
use("famiu/bufdelete.nvim")
use("folke/which-key.nvim")
use("numToStr/Comment.nvim")
use("akinsho/toggleterm.nvim")
use("lewis6991/impatient.nvim")
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

-- color scheme
use("Mofiqul/dracula.nvim")

-- lsp
use("neovim/nvim-lspconfig")
use("williamboman/nvim-lsp-installer")
use("jose-elias-alvarez/null-ls.nvim")

-- completions
use("hrsh7th/nvim-cmp")
use("hrsh7th/cmp-nvim-lsp")
use("hrsh7th/cmp-buffer") -- buffer completions
-- use("hrsh7th/cmp-path") -- path completions
use("hrsh7th/cmp-cmdline") -- cmdline completions
use("ray-x/lsp_signature.nvim")

-- luasnip
use("saadparwaiz1/cmp_luasnip")
use("L3MON4D3/LuaSnip")

-- angular
use("johnpapa/vscode-angular-snippets")

use({ "akinsho/bufferline.nvim", tag = "*" })
use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

--
-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
	require("packer").sync()
end
