---@module "blink.cmp"

return {
	"saghen/blink.cmp",
	version = "1.*",
	lazy = false,
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = (function()
				return "make install_jsregexp"
			end)(),
		},
		"rafamadriz/friendly-snippets",
		{
			"saghen/blink.compat",
			version = "2.*",
			lazy = true,
			opts = {},
		},
	},
	---@type blink.cmp.Config
	opts = {
		snippets = {
			preset = "luasnip",
		},
		keymap = {
			preset = "none",
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},
		completion = {
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
		},
		cmdline = {
			keymap = {
				preset = "cmdline",
			},
			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
				menu = {
					auto_show = true,
				},
			},
			sources = function()
				local cmd_type = vim.fn.getcmdtype()
				if cmd_type == "/" or cmd_type == "?" then
					return { "buffer" }
				end
				return { "path", "cmdline" }
			end,
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				sql = { "snippets", "dadbod", "buffer" },
			},
			providers = {
				buffer = {
					opts = {
						max_async_buffer_size = 1000000000,
						max_total_buffer_size = math.huge,
					},
				},
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
			},
		},
	},
	config = function(_, opts)
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		luasnip.config.set_config({
			history = false,
			updateevents = "TextChanged,TextChangedI",
		})

		for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/mg/snippets/*.lua", true)) do
			loadfile(ft_path)()
		end

		luasnip.filetype_extend("typescript", { "angular" })
		luasnip.filetype_extend("html", { "angular" })
		luasnip.filetype_extend("python", { "django" })

		require("blink.cmp").setup(opts)
	end,
}
