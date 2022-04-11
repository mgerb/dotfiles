local map = require("core.utils").map

-- telescope
map("n", "<leader>fp", ":Telescope media_files <CR>")
map("n", "<leader>te", ":Telescope <CR>")

-- bufferline
map("n", "<S-l>", ":BufferLineCycleNext <CR>")
map("n", "<S-h>", ":BufferLineCyclePrev <CR>")

-- other
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>w", ":w<CR>")

