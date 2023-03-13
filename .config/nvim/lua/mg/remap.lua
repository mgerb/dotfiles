vim.g.mapleader = " "

vim.keymap.set("n", "<esc>", ":noh<CR>") -- clear highlighted searches

vim.keymap.set("n", "J", "mzJ`z") -- keep cursor in place when joining lines

-- copy/paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+p]])

-- comment
vim.keymap.set("n", "<C-/>", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>")
vim.keymap.set("x", "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
vim.keymap.set("i", "<C-/>", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>")

-- better window navigation
vim.keymap.set("n", "<C-h>", "<c-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>")

-- nvim-tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- jump around 10 lines at a time
vim.keymap.set("n", "<CS-j>", "10j")
vim.keymap.set("n", "<CS-k>", "10k")
vim.keymap.set("n", "<CS-h>", "10h")
vim.keymap.set("n", "<CS-l>", "10l")
