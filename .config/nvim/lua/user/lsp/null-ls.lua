local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.stylelint,

		-- null_ls.builtins.diagnostics.cspell,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.stylelint,

		null_ls.builtins.code_actions.eslint,
	},

	debug = true,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
					-- organize imports of typescript file
					-- NOTE: not working well at the moment
					-- tends to format imports differently
					-- vim.lsp.buf.execute_command({
					-- 	command = "_typescript.organizeImports",
					-- 	arguments = { vim.fn.expand("%:p") },
					-- })
				end,
			})
		end
	end,
})
