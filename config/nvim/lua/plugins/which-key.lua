local mappings = {
	["A"] = { "<cmd>:AerialOpen<cr>", "Aerial" },
	a = {
		name = "Angular Scripts",
		c = { "<cmd>lua require('mg.custom.angular').jump_to_angular_component_part('ts')<cr>", "Component" },
		j = {
			name = "Jesting",
			f = { "<cmd>JestingAttachNx<cr>", "Attach to File" },
			t = { "<cmd>JestingAttachSingleTestNx<cr>", "Attach to Single Test" },
			u = { "<cmd>JestingUnattach<cr>", "Unattach from Test" },
		},
		m = { "<cmd>lua require('mg.custom.angular').jump_to_nearest_module()<cr>", "Module" },
		s = { "<cmd>lua require('mg.custom.angular').jump_to_angular_component_part('scss')<cr>", "SCSS" },
		S = { "<cmd>lua require('mg.custom.angular').jump_to_angular_component_part('spec%.ts')<cr>", "Test" },
		t = { "<cmd>lua require('mg.custom.angular').jump_to_angular_component_part('html')<cr>", "HTML" },
		x = {
			name = "NGRX",
			r = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('reducer')<cr>", "NGRX Reducer" },
			e = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('effects')<cr>", "NGRX Effects" },
			a = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('actions')<cr>", "NGRX Actions" },
			f = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('facade')<cr>", "NGRX Facade" },
			s = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('selectors')<cr>", "NGRX Selectors" },
		},
		g = {
			name = "Generate",
			c = {
				"<cmd>lua require('mg.custom.nx').run_nx_generator('component')<cr>",
				"Component",
			},
			C = {
				"<cmd>lua require('mg.custom.nx').run_nx_generator('component-store')<cr>",
				"Component Store",
			},
			d = {
				"<cmd>lua require('mg.custom.nx').run_nx_generator('directive')<cr>",
				"Directive",
			},
			p = { "<cmd>lua require('mg.custom.nx').run_nx_generator('pipe')<cr>", "Pipe" },
			s = { "<cmd>lua require('mg.custom.nx').run_nx_generator('service')<cr>", "Service" },
		},
	},
	["b"] = { "<cmd>:Telescope buffers<cr>", "Buffers" },

	-- DAP
	["B"] = { "<cmd>:DapToggleBreakpoint<cr>", "DAP Toggle Breakpoint" },
	["?"] = { "<cmd>lua require('dapui').eval(nil, { enter = true })<cr>", "DAP Eval" },

	["c"] = { "<cmd>:bdelete<cr>", "Close" },
	["q"] = { "<cmd>:q<cr>", "Quit" },
	["Q"] = { "<cmd>:qa!<cr>", "Quit All Force" },
	["w"] = { "<cmd>:w<cr>", "Write" },
	["e"] = { "<cmd>lua vim.diagnostic.open_float({focusable = true})<cr>", "Open Diagnostics" },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('mg.custom.telescope').get_my_theme())<cr>",
		"Find files",
	},
	["F"] = {
		"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({theme = require('mg.custom.telescope').get_my_theme()})<cr>",
		"Live Grep",
	},
	["v"] = { "<cmd>vs<cr>", "V Split" },
	["r"] = { "<cmd>Telescope resume<cr>", "Resume" },
	["t"] = { "<cmd>tabnew<cr>", "New Tab" },
	d = {
		name = "Diffview",
		c = { "<cmd>DiffviewClose<cr>", "Close" },
		d = { "<cmd>DiffviewOpen<cr>", "Open" },
		h = { "<cmd>DiffviewOpen HEAD~1<cr>", "Open HEAD~1" },
		f = { "<cmd>DiffviewFileHistory %<cr>", "File History" },
		l = { "<cmd>DiffviewLog<cr>", "Log" },
		r = { "<cmd>DiffviewRefresh<cr>", "Refresh" },
		t = { "<cmd>DiffviewToggleFiles<cr>", "Toggle Files" },
	},
	g = {
		name = "Git",
		B = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
		b = { "<cmd>Telescope git_branches<cr>", "Branches" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		S = { "<cmd>Telescope git_stash<cr>", "Stashes" },
		c = { "<cmd>Telescope git_commits<cr>", "Commits" },
		d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		t = { "<cmd>Telescope git_status<cr>", "Status" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
	},
	h = {
		name = "Harpoon",
		a = { "<cmd> lua require 'harpoon.mark'.add_file()<cr>", "Add File" },
		h = { "<cmd> lua require 'harpoon.ui'.toggle_quick_menu()<cr>", "Menu" },
		c = { "<cmd> lua require 'harpoon.cmd-ui'.toggle_quick_menu()<cr>", "CMD Commands" },
		["1"] = {
			"<cmd> lua require 'harpoon.term'.gotoTerminal(1)<cr>",
			"Terminal 1",
		},
		["2"] = {
			"<cmd> lua require 'harpoon.term'.gotoTerminal(2)<cr>",
			"Terminal 2",
		},
		["3"] = {
			"<cmd> lua require 'harpoon.term'.gotoTerminal(3)<cr>",
			"Terminal 3",
		},
	},
	["H"] = { "<cmd>:%!xxd<cr><cmd>:setlocal ft=xxd<cr>", "Hex View" },
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>",
			"Diagnostics (File)",
		},
		D = {
			"<cmd>lua require('telescope.builtin').diagnostics()<cr>",
			"Diagnostics (All)",
		},
		f = { "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		m = { "<cmd>Mason<cr>", "Mason" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	m = {
		name = "MG Scripts",
		o = { "<cmd>MGTSOrganizeImports<cr>", "TS Organize Imports" },
		t = { "<cmd>MetricsGetTime<cr>", "Metrics Get Time" },
		d = { "<cmd>MetricsDebug<cr>", "Metrics Debug" },
	},
	n = {
		name = "Tree",
		c = { "<cmd>NvimTreeCollapse<cr>", "Collapse" },
		r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" },
		e = { "<cmd>:NvimTreeToggle<cr>", "Toggle" },
	},
	o = { "<cmd>Oil<cr>", "Oil" },
	p = { "<cmd>Lazy<cr>", "Package Manager" },
	T = {
		name = "Telescope",
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		C = { "<cmd>Telescope command_history<cr>", "Command History" },
		h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
	},
	["u"] = { "<cmd>:UndotreeToggle<cr>", "Undo Tree" },
	["x"] = { "<cmd>:%bd<cr>", "Close All Buffers" },
}

return {
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			local wk = require("which-key")
			wk.register(mappings, { prefix = "<leader>" })
		end,
	},
}
