require("user.custom.angular.nx-auto-test")

function _MG_TS_ORGANIZE_IMPORTS()
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = { vim.fn.expand("%:p") },
	})
end
