local M = {}

M.state = require("mg._state")
M.colors = require("mg._colors")
M.util = require("mg._util")
M.angular = require("mg._angular")
M.telescope = require("mg._telescope")

M._setup_options = function()
	local guifont = "FiraCode Nerd Font Mono"

	local options = {
		backup = false, -- creates a backup file
		-- clipboard = "unnamedplus",            -- allows neovim to access the system clipboard
		cmdheight = 1, -- more space in the neovim command line for displaying messages
		completeopt = { "menuone", "noselect" }, -- mostly just for cmp
		conceallevel = 0, -- so that `` is visible in markdown files
		fileencoding = "utf-8", -- the encoding written to a file
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		mouse = "a", -- allow the mouse to be used in neovim
		pumheight = 10, -- pop up menu height
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		showtabline = 2, -- always show tabs
		smartcase = true, -- smart case
		smartindent = true, -- make indenting smarter again
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = true, -- force all vertical splits to go to the right of current window
		swapfile = false, -- creates a swapfile
		termguicolors = true, -- set term gui colors (most terminals support this)
		timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
		updatetime = 50, -- faster completion (4000ms default)
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		expandtab = true, -- convert tabs to spaces
		shiftwidth = 4, -- the number of spaces inserted for each indentation
		tabstop = 4, -- insert 2 spaces for a tab
		softtabstop = 4,
		cursorline = false, -- highlight the current line
		number = true, -- set numbered lines
		relativenumber = false, -- set relative numbered lines
		numberwidth = 4, -- set number column width to 2 {default 4}
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		wrap = false, -- display lines as one long line
		scrolloff = 8, -- is one of my fav
		sidescrolloff = 8,
		guifont = guifont .. ":h14", -- the font used in graphical neovim applications
		spell = false,
		spelllang = "en_us",
		-- undodir = os.getenv("HOME") .. "/.vim/undodir",
		undofile = true, -- enable persistent undo
	}

	for k, v in pairs(options) do
		vim.opt[k] = v
	end

	vim.opt.isfname:append("@-@")

	-- if in neovide
	if vim.fn.exists("g:neovide") then
		vim.opt.guifont = guifont .. ":h12"
		vim.g.neovide_cursor_animation_length = 0.01
	end
end

---Windows specific setup
M._setup_windows = function()
	-- Set the shell to Powershell on Windows
	if vim.fn.has("win32") == 1 then
		vim.cmd("set shell=powershell.exe")
		vim.cmd("set shellcmdflag=-NoProfile\\ -Command")
	end
end

-- TODO: separate nvim setup stuff from lib stuff so they we can source these easier during dev
M.setup = function()
	vim.g.mapleader = " "
	vim.g.maplocalleader = "\\"
	M._setup_options()
	M._setup_windows()
	require("mg._user_commands")

	-- NOTE: This only works when NOT using oil
	-- this is currently handled in the oil config, but we'll
	-- leave this here in case we stop using oil.
	--
	-- Set the current working directory to the directory of
	-- the current file or path in which Neovim was opened with.
	-- e.g. `nvim . or nvim /path/to/file`
	local function update_directory(data)
		--buffer is a directory
		local directory = vim.fn.isdirectory(data.file) == 1

		if not directory then
			return
		end

		--change to the directory
		vim.cmd.cd(data.file)
	end

	vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = update_directory })
end

return M
