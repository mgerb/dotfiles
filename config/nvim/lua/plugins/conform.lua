local mg_state = require("mg.state")

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
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			markdown = { { "prettierd", "prettier" } },
            nix = { "nixpkgs-fmt" }
		},
		formatters = {
			["clang-format"] = {
				prepend_args = { "-style={BasedOnStyle: llvm, IndentWidth: 4}" },
			},
		},
	},

	init = function()
		vim.g.conform_format_on_save = mg_state.get_value("conform_format_on_save") or false

		vim.api.nvim_create_user_command("ConformFormatOnSaveEnable", function()
			vim.g.conform_format_on_save = true
			mg_state.set_value("conform_format_on_save", true)
		end, {
			desc = "Disable autoformat-on-save",
		})
		vim.api.nvim_create_user_command("ConformFormatOnSaveDisable", function()
			vim.g.conform_format_on_save = false
			mg_state.set_value("conform_format_on_save", false)
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
