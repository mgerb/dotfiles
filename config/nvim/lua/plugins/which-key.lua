return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

		wk.setup({
			icons = {
				mappings = false,
			},
		})

		wk.add({
			{
				mode = { "t" },
				{ "<Esc>", [[<C-\><C-N><C-n>]], desc = "Terminal Esc" },
				{ "<C-h>", [[<C-\><C-N><C-w>h]], desc = "Terminal Left" },
				{ "<C-j>", [[<C-\><C-N><C-w>j]], desc = "Terminal Down" },
				{ "<C-k>", [[<C-\><C-N><C-w>k]], desc = "Terminal Up" },
				{ "<C-l>", [[<C-\><C-N><C-w>l]], desc = "Terminal Right" },
			},
			{
				mode = { "n", "v" },
				{ "<leader>y", [["+y]], desc = "System Copy" },
				{ "<leader>p", [["+p]], desc = "System Paste" },
				{ "<C-n>", ":NvimTreeToggle<CR>", desc = "Toggle Nvim Tree" },
				{
					"<leader>lf",
					"<cmd>lua require('conform').format({ async = true, lsp_format = 'fallback' })<cr>",
					desc = "Format",
				},

				-- jump around 10 lines at a time (not really used anymore)
				{ "<CS-j>", "10j", desc = "10j" },
				{ "<CS-k>", "10k", desc = "10k" },
				{ "<CS-h>", "10h", desc = "10h" },
				{ "<CS-l>", "10l", desc = "10l" },

				-- MG scripts
				{ "<leader>m", group = "MG Scripts" },
				{ "<leader>mp", ":MG playground<CR>", desc = "Playground" },
			},

			{
				mode = { "v" },
				{ "<leader>x", ":.lua<CR>", desc = "Run Lua" },

				-- move lines up/down
				{ "J", ":m '>+1<CR>gv=gv", desc = "Line Down" },
				{ "K", ":m '<-2<CR>gv=gv", desc = "Line Up" },
				{
					"<leader>F",
					"<CMD>lua require('mg').telescope.live_grep_with_selection()<CR>",
					desc = "Live Grep",
				},
				{
					"<leader>f",
					"<CMD>lua require('mg').telescope.find_files_with_selection()<CR>",
					desc = "Find Files",
				},
			},

			{
				mode = { "n" },
				{ "<esc>", ":noh<CR>", desc = "Clear highlighted searches" },

				-- Resize with arrows
				{ "<C-Up>", ":resize -2<CR>", desc = "Resize -" },
				{ "<C-Down>", ":resize +2<CR>", desc = "Resize +" },
				{ "<C-,>", ":vertical resize -2<CR>", desc = "V Resize -" },
				{ "<C-.>", ":vertical resize +2<CR>", desc = "V Resize +" },

				-- better window navigation
				{ "<C-h>", "<C-w>h", desc = "Move Left" },
				{ "<C-j>", "<C-w>j", desc = "Move Down" },
				{ "<C-l>", "<C-w>l", desc = "Move Right" },
				{ "<C-k>", "<C-w>k", desc = "Move Up" },

				-- harpoon navigation
				{ "<S-l>", "<CMD>lua require('harpoon.ui').nav_next()<CR>", desc = "Harpoon Next" },
				{ "<S-h>", "<CMD>lua require('harpoon.ui').nav_prev()<CR>", desc = "Harpoon Previous" },

				{ "<leader><leader>x", "<cmd>:source %<cr>", desc = "Source Lua File" },
				{ "<leader>?", "<cmd>lua require('dapui').eval(nil, { enter = true })<cr>", desc = "DAP Eval" },
				{ "<leader>A", "<cmd>:AerialOpen<cr>", desc = "Aerial" },
				{ "<leader>B", "<cmd>:DapToggleBreakpoint<cr>", desc = "DAP Toggle Breakpoint" },
				{
					"<leader>F",
					"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({theme = require('mg').telescope.get_theme()})<cr>",
					desc = "Live Grep",
				},
				{ "<leader>H", "<cmd>:%!xxd<cr><cmd>:setlocal ft=xxd<cr>", desc = "Hex View" },
				{ "<leader>Q", "<cmd>:qa!<cr>", desc = "Quit All Force" },
				{ "<leader>T", group = "Telescope" },
				{ "<leader>TC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
				{ "<leader>Tc", "<cmd>Telescope commands<cr>", desc = "Commands" },
				{ "<leader>Th", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
				{ "<leader>Tk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
				{ "<leader>a", group = "Angular Scripts" },
				{
					"<leader>aS",
					"<cmd>lua require('mg').angular.jump_to_angular_component_part('spec%.ts')<cr>",
					desc = "Test",
				},
				{
					"<leader>ac",
					"<cmd>lua require('mg').angular.jump_to_angular_component_part('ts')<cr>",
					desc = "Component",
				},
				{
					"<leader>as",
					"<cmd>lua require('mg').angular.jump_to_angular_component_part('scss')<cr>",
					desc = "SCSS",
				},
				{
					"<leader>at",
					"<cmd>lua require('mg').angular.jump_to_angular_component_part('html')<cr>",
					desc = "HTML",
				},
				{ "<leader>aj", group = "Jesting" },
				{ "<leader>ajf", "<cmd>JestingAttachNx<cr>", desc = "Attach to File" },
				{ "<leader>ajt", "<cmd>JestingAttachSingleTestNx<cr>", desc = "Attach to Single Test" },
				{ "<leader>aju", "<cmd>JestingUnattach<cr>", desc = "Unattach from Test" },
				{ "<leader>b", "<cmd>:Telescope buffers<cr>", desc = "Buffers" },
				{ "<leader>c", "<cmd>:bd<cr>", desc = "Close" },
				{ "<leader>C", "<cmd>:bd!<cr>", desc = "Close (Force)" },
				{ "<leader>d", group = "Diffview" },
				{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close" },
				{ "<leader>dd", "<cmd>DiffviewOpen<cr>", desc = "Open" },
				{ "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
				{ "<leader>dh", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Open HEAD~1" },
				{ "<leader>dl", "<cmd>DiffviewLog<cr>", desc = "Log" },
				{ "<leader>dr", "<cmd>DiffviewRefresh<cr>", desc = "Refresh" },
				{ "<leader>dt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Files" },
				{
					"<leader>e",
					"<cmd>lua vim.diagnostic.open_float({focusable = true})<cr>",
					desc = "Open Diagnostics",
				},
				{
					"<leader>f",
					"<cmd>lua require('telescope.builtin').find_files(require('mg').telescope.get_theme())<cr>",
					desc = "Find files",
				},
				{ "<leader>g", group = "Git" },
				{ "<leader>gB", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
				{ "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
				{ "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Stashes" },
				{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
				{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
				{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
				{ "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk" },
				{ "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk" },
				{ "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
				{ "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
				{ "<leader>gt", "<cmd>Telescope git_status<cr>", desc = "Status" },
				{ "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>h1", "<cmd> lua require 'harpoon.term'.gotoTerminal(1)<cr>", desc = "Terminal 1" },
				{ "<leader>h2", "<cmd> lua require 'harpoon.term'.gotoTerminal(2)<cr>", desc = "Terminal 2" },
				{ "<leader>h3", "<cmd> lua require 'harpoon.term'.gotoTerminal(3)<cr>", desc = "Terminal 3" },
				{ "<leader>ha", "<cmd> lua require 'harpoon.mark'.add_file()<cr>", desc = "Add File" },
				{ "<leader>hc", "<cmd> lua require 'harpoon.cmd-ui'.toggle_quick_menu()<cr>", desc = "CMD Commands" },
				{ "<leader>hh", "<cmd> lua require 'harpoon.ui'.toggle_quick_menu()<cr>", desc = "Menu" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>lD", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = "Diagnostics (All)" },
				{ "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
				{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
				{
					"<leader>ld",
					"<cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>",
					desc = "Diagnostics (File)",
				},
				{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
				{ "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
				{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
				{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
				{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
				{ "<leader>n", group = "Tree" },
				{ "<leader>nc", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse" },
				{ "<leader>ne", "<cmd>:NvimTreeToggle<cr>", desc = "Toggle" },
				{ "<leader>nr", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh" },
				{ "<leader>o", "<cmd>Oil<cr>", desc = "Oil" },
				{ "<leader>P", "<cmd>Lazy<cr>", desc = "Package Manager" },
				{ "<leader>q", "<cmd>:q<cr>", desc = "Quit" },
				{ "<leader>r", "<cmd>Telescope resume<cr>", desc = "Resume" },
				{ "<leader>t", "<cmd>tabnew<cr>", desc = "New Tab" },
				{ "<leader>u", "<cmd>:UndotreeToggle<cr>", desc = "Undo Tree" },
				{ "<leader>v", "<cmd>vs<cr>", desc = "V Split" },
				{ "<leader>w", "<cmd>:w<cr>", desc = "Write" },
				{ "<leader>x", "<cmd>:%bd<cr>", desc = "Close All Buffers" },
			},
		})
	end,
}
