local which_key = require("which-key")

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	-- prefix: use "<leader>f" for example for mapping everything related to finding files
	-- the prefix is prepended to every mapping part of `mappings`
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	a = {
		name = "Angular Scripts",
		m = { "<cmd>lua require('user.custom.angular').jump_to_nearest_module()<cr>", "Module" },
		c = { "<cmd>lua require('user.custom.angular').jump_to_angular_component_part('ts')<cr>", "Component" },
		t = { "<cmd>lua require('user.custom.angular').jump_to_angular_component_part('html')<cr>", "HTML" },
		s = { "<cmd>lua require('user.custom.angular').jump_to_angular_component_part('scss')<cr>", "SCSS" },
		j = { "<cmd>lua require('user.custom.angular').jump_to_angular_component_part('spec%.ts')<cr>", "Test" },

		xr = { "<cmd>lua require('user.custom.angular').jump_to_ngrx_parts('reducer')<cr>", "NGRX Reducer" },
		xe = { "<cmd>lua require('user.custom.angular').jump_to_ngrx_parts('effects')<cr>", "NGRX Effects" },
		xa = { "<cmd>lua require('user.custom.angular').jump_to_ngrx_parts('actions')<cr>", "NGRX Actions" },
		xf = { "<cmd>lua require('user.custom.angular').jump_to_ngrx_parts('facade')<cr>", "NGRX Facade" },
		xs = { "<cmd>lua require('user.custom.angular').jump_to_ngrx_parts('selectors')<cr>", "NGRX Selectors" },
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
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Find files",
	},
	-- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Word" },
	["F"] = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Find Word" },
	["r"] = { "<cmd>Telescope resume<cr>", "Resume" },

	d = {
		name = "Diffview",
		c = { "<cmd>DiffviewClose<cr>", "Close" },
		d = { "<cmd>DiffviewOpen<cr>", "Open" },
		h = { "<cmd>DiffviewOpen head~1<cr>", "Open head~1" },
		f = { "<cmd>DiffviewFileHistory<cr>", "File History" },
		l = { "<cmd>DiffViewLog<cr>", "Log" },
		r = { "<cmd>DiffviewRefresh<cr>", "Refresh" },
		t = { "<cmd>DiffviewToggleFiles<cr>", "Toggle Files" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
		b = { "<cmd>Telescope git_branches<cr>", "Branches" },
		c = { "<cmd>Telescope git_commits<cr>", "Commits" },
		S = { "<cmd>Telescope git_stash<cr>", "Stashes" },
		t = { "<cmd>Telescope git_status<cr>", "Status" },
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
			"<cmd>Telescope diagnostics<cr>",
			"Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
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
		o = { "<cmd>lua _MG_TS_ORGANIZE_IMPORTS()<cr>", "TS Organize Imports" },
	},

	n = {
		name = "NvimTree",
		c = { "<cmd>NvimTreeCollapse<cr>", "Collapse" },
		r = { "<cmd>NvimTreeRefresh<cr>", "Refresh" },
		e = { "<cmd>:NvimTreeToggle<cr>", "Tree" },
	},

	p = {
		name = "Packer",
		a = { "<cmd>PackerSnapshot 1<cr>", "Snapshot" },
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
}

which_key.setup(setup)
which_key.register(mappings, opts)
