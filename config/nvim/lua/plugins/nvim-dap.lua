local function GetCodelldbPath()
	local reg = require("mason-registry")
	local codelldb = reg.get_package("codelldb")
	local extension_path = codelldb:get_install_path() .. "/extension/"
	return extension_path .. "adapter/codelldb"
end

local executable_file_path_cache = ""

return {
	"mfussenegger/nvim-dap",
	lazy = true,
	cmd = { "DapToggleBreakpoint" },
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"mason-org/mason-registry",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		ui.setup()

		require("nvim-dap-virtual-text").setup()

		vim.defer_fn(function()
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = GetCodelldbPath(),
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					type = "codelldb",
					name = "Launch",
					request = "launch",
					program = function()
						-- check if executable_file_path_cache is a valid file
						if executable_file_path_cache == "" or vim.fn.filereadable(executable_file_path_cache) ~= 1 then
							executable_file_path_cache =
								vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug", "file")
						end
						return executable_file_path_cache
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
		end, 500)

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F13>", dap.restart)

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
