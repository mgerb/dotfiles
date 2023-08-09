local opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<esc>", ":noh<CR>", { silent = true }) -- clear highlighted searches

map("n", "J", "mzJ`z", { silent = true }) -- keep cursor in place when joining lines

-- copy/paste from system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>P", [["+p]])

-- comment
map("n", "<C-/>", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>", { silent = true })
map("x", "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { silent = true })
map("i", "<C-/>", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>", { silent = true })

-- better window navigation
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { silent = true })
map("n", "<C-Down>", ":resize +2<CR>", { silent = true })
map("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Navigate buffers
map("n", "<S-l>", "<CMD>lua require('harpoon.ui').nav_next()<CR>", { silent = true })
map("n", "<S-h>", "<CMD>lua require('harpoon.ui').nav_prev()<CR>", { silent = true })

-- nvim-tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

map("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- jump around 10 lines at a time
map("n", "<CS-j>", "10j", { silent = true })
map("n", "<CS-k>", "10k", { silent = true })
map("n", "<CS-h>", "10h", { silent = true })
map("n", "<CS-l>", "10l", { silent = true })

map("v", "<CS-j>", "10j", { silent = true })
map("v", "<CS-k>", "10k", { silent = true })
map("v", "<CS-h>", "10h", { silent = true })
map("v", "<CS-l>", "10l", { silent = true })

-- terminal
map("t", "<Esc>", [[<C-\><C-N><C-n>]])
map("t", "<C-h>", [[<C-\><C-N><C-w>h]], { silent = true })
map("t", "<C-j>", [[<C-\><C-N><C-w>j]], { silent = true })
map("t", "<C-k>", [[<C-\><C-N><C-w>k]], { silent = true })
map("t", "<C-l>", [[<C-\><C-N><C-w>l]], { silent = true })

-- telescope visual mode find bindings
local function getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

map("v", "<leader>F", function()
	local text = getVisualSelection()
	require("telescope").extensions.live_grep_args.live_grep_args({
		theme = require("mg.custom.telescope").get_my_theme(),
		default_text = text,
	})
end, opts)
