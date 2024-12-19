--- Window specific options

-- Set the shell to Powershell on Windows
if vim.fn.has("win32") == 1 then
	vim.cmd("set shell=powershell.exe")
	vim.cmd("set shellcmdflag=-NoProfile\\ -Command")
end
