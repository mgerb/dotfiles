require("mg.custom.nx")
require("mg.custom.angular")

local packer = require("packer")

vim.api.nvim_create_user_command("MGTSOrganizeImports", function()
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = { vim.fn.expand("%:p") },
	})
end, {})

vim.api.nvim_create_user_command("MGPackerSnapshot", function()
	local date = os.date("*t")
	local dateString = string.format("%d-%02d-%02d", date.year, date.month, date.day)
	packer.snapshot(dateString .. ".json")
end, {})
