local wk = require("which-key")

vim.o.timeout = true
vim.o.timeoutlen = 300

wk.setup()

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
		xr = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('reducer')<cr>", "NGRX Reducer" },
		xe = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('effects')<cr>", "NGRX Effects" },
		xa = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('actions')<cr>", "NGRX Actions" },
		xf = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('facade')<cr>", "NGRX Facade" },
		xs = { "<cmd>lua require('mg.custom.angular').jump_to_ngrx_parts('selectors')<cr>", "NGRX Selectors" },
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
	b = {
		name = "Bufferline",
		h = { "<cmd>BufferLineMovePrev<cr>", "Move Previous" },
		l = { "<cmd>BufferLineMoveNext<cr>", "Move Next" },
		s = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by Directory" },
	},
	["c"] = { "<cmd>:Bdelete<cr>", "Close" },
	["q"] = { "<cmd>:q<cr>", "Quit" },
	["w"] = { "<cmd>:w<cr>", "Write" },
	["e"] = { "<cmd>lua vim.diagnostic.open_float({focusable = true})<cr>", "Open Diagnostics" },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('mg.custom.telescope').get_my_theme())<cr>",
		"Find files",
	},
	["F"] = {
		"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args(require('mg.custom.telescope').get_my_theme())<cr>",
		"Live Grep",
	},
	["r"] = { "<cmd>Telescope resume<cr>", "Resume" },
	d = {
		name = "Diffview",
		c = { "<cmd>DiffviewClose<cr>", "Close" },
		d = { "<cmd>DiffviewOpen<cr>", "Open" },
		h = { "<cmd>DiffviewOpen HEAD~1<cr>", "Open HEAD~1" },
		f = { "<cmd>DiffviewFileHistory %<cr>", "File History" },
		l = { "<cmd>DiffViewLog<cr>", "Log" },
		r = { "<cmd>DiffviewRefresh<cr>", "Refresh" },
		t = { "<cmd>DiffviewToggleFiles<cr>", "Toggle Files" },
	},
	g = {
		name = "Git",
		b = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
		B = { "<cmd>Telescope git_branches<cr>", "Branches" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		S = { "<cmd>Telescope git_stash<cr>", "Stashes" },
		c = { "<cmd>Telescope git_commits<cr>", "Commits" },
		d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		t = { "<cmd>Telescope git_status<cr>", "Status" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
	},
	h = {
		name = "Harpoon",
		a = { "<cmd> lua require 'harpoon.mark'.add_file()<cr>", "Add File" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
		h = { "<cmd> lua require 'harpoon.ui'.toggle_quick_menu()<cr>", "Menu" },
		t = { "<cmd>Telescope harpoon marks<cr>", "Telescope" },
	},
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
		f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		m = { "<cmd>Mason<cr>", "Mason" },
		q = { "<cmd>lua vim.lsp.diagnostic.setloclist()<cr>", "Quickfix" },
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
	},
	n = {
		name = "Tree",
		b = { "<cmd>Neotree buffers<cr>", "Buffers" },
		c = { "<cmd>NvimTreeCollapse<cr>", "Collapse" },
		r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" },
		e = { "<cmd>:NvimTreeToggle<cr>", "Toggle" },
	},
	p = {
		name = "Packer",
		a = { "<cmd>MGPackerSnapshot<cr>", "Snapshot" },
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	t = {
		name = "Terminal",
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		t = { "<cmd>ToggleTermToggleAll<cr>", "Toggle All" },
	},
	["u"] = { "<cmd>:UndotreeToggle<cr>", "Undo Tree" },
	["x"] = { "<cmd>:%bd<cr>", "Close All Buffers" },
}

wk.register(mappings, { prefix = "<leader>" })
