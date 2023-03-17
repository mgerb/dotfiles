vim.g.mapleader = " "

vim.keymap.set("n", "<esc>", ":noh<CR>", { silent = true }) -- clear highlighted searches

vim.keymap.set("n", "J", "mzJ`z", { silent = true }) -- keep cursor in place when joining lines

-- copy/paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+p]])

-- comment
vim.keymap.set("n", "<C-/>", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>", { silent = true })
vim.keymap.set(
	"x",
	"<C-/>",
	"<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ silent = true }
)
vim.keymap.set("i", "<C-/>", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>", { silent = true })

-- better window navigation
vim.keymap.set("n", "<C-h>", "<c-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true })

-- nvim-tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- jump around 10 lines at a time
vim.keymap.set("n", "<CS-j>", "10j", { silent = true })
vim.keymap.set("n", "<CS-k>", "10k", { silent = true })
vim.keymap.set("n", "<CS-h>", "10h", { silent = true })
vim.keymap.set("n", "<CS-l>", "10l", { silent = true })
