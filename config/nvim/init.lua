require("mg")

-- Set the shell to Powershell on Windows
if vim.fn.has("win32") == 1 then
	vim.cmd("set shell=powershell.exe")
	vim.cmd("set shellcmdflag=-NoProfile\\ -Command")
end

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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
