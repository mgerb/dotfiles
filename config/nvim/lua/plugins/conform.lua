local mg = require("mg")

return {
	"stevearc/conform.nvim",
	event = "BufRead",
	opts = {
		notify_on_error = true,
		notify_on_conform = true,
		format_on_save = function()
			if not vim.g.conform_format_on_save then
				return
			end
			return { timeout_ms = 500, lsp_fallback = true }
		end,
		formatters_by_ft = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			lua = { "stylua" },
			python = { "black" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			htmlangular = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			jsonc = { "prettierd", "prettier" },
			markdown = { "prettierd", "prettier" },
			nix = { "alejandra", "nixpkgs-fmt", "nixfmt" },
			rust = { "rustfmt", lsp_format = "fallback" },
			sql = { "pg_format" },
			zig = { "zigfmt", lsp_format = "fallback" },
		},
		formatters = {
			["clang-format"] = {
				prepend_args = { "-style={BasedOnStyle: llvm, IndentWidth: 4}" },
			},
		},
	},

	init = function()
		vim.g.conform_format_on_save = mg.state.get_value("conform_format_on_save") or false

		vim.api.nvim_create_user_command("ConformFormatOnSaveEnable", function()
			vim.g.conform_format_on_save = true
			mg.state.set_value("conform_format_on_save", true)
		end, {
			desc = "Disable autoformat-on-save",
		})
		vim.api.nvim_create_user_command("ConformFormatOnSaveDisable", function()
			vim.g.conform_format_on_save = false
			mg.state.set_value("conform_format_on_save", false)
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
