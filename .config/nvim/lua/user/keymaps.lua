local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- NOTE: see rest of mappings in which-key.lua

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Misc
map("n", "<C-s>", ":w<CR>", opts) -- save file
map("n", "<esc>", ":noh<CR>", opts) -- clear highlighted searches

-- comment
map("n", "<C-_>", "<CMD>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
map("x", "<C-_>", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", opts)

-- better window navigation
map("n", "<C-h>", "<c-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- nvim-tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

map("n", "<leader>k", ":m .-2<CR>==", opts)
map("n", "<leader>j", ":m .+1<CR>==", opts)
map("i", "<C-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("v", "J", ":m '>+1<CR>gv=gv", opts)

