--- Window specific options

-- Set the shell to Powershell on Windows
if vim.fn.has("win32") == 1 then
	if vim.fn.executable("bash.exe") then
		vim.cmd("set shell=bash.exe")
	else
		vim.cmd("set shell=powershell.exe")
	end
	vim.cmd("set shellcmdflag=-NoProfile\\ -Command")
end
