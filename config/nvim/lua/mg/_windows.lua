--- Window specific options

-- Set the shell to Powershell on Windows
if vim.fn.has("win32") == 1 then
	-- bash had some weird behavior, but it wasn't consisten
	-- across all windows machines I have used. Just stick
	-- to powershell.
	--
	-- if vim.fn.executable("bash.exe") then
	-- 	vim.cmd("set shell=bash.exe")
	-- else
	-- 	vim.cmd("set shell=powershell.exe")
	-- end

	vim.cmd("set shell=powershell.exe")
	vim.cmd("set shellcmdflag=-NoProfile\\ -Command")
end
