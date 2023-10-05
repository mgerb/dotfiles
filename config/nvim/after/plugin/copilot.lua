-- fixes tab key mapping conflict with cmp
vim.g.copilot_assume_mapped = true
local sysname = vim.loop.os_uname().sysname
if sysname == "Darwin" then
	vim.g.copilot_node_command = "/Users/mgerber/.nvm/versions/node/v16.19.0/bin/node"
end
