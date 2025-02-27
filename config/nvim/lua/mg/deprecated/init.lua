require("mg.custom.nx")
require("mg.custom.angular")
require("mg.custom.playground")
local history_picker = require("mg.custom.history_picker")

vim.api.nvim_create_user_command("MGTSOrganizeImports", function()
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = { vim.fn.expand("%:p") },
	})
end, {})

vim.api.nvim_create_user_command("MGScratch", function(args)
	local lang = args.args

	if lang == "" then
		lang = "json"
	end

	vim.api.nvim_command("enew")
	vim.api.nvim_command("setlocal buftype=nofile")
	vim.api.nvim_command("setlocal bufhidden=hide")
	vim.api.nvim_command("setlocal filetype=json")
	-- go to insert mode
	vim.api.nvim_command("normal i")
end, {})

vim.api.nvim_create_user_command("MGHistory", function()
	history_picker.list_shell_history()
end, {})

vim.api.nvim_create_user_command("MGToggleSpellCheck", function()
	if vim.wo.spell then
		vim.wo.spell = false
	else
		vim.wo.spell = true
	end
end, {})
