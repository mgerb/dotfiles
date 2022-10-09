local nvim_tree = require("nvim-tree")

nvim_tree.setup({
  renderer = {
    highlight_opened_files = "all",
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 50,
  },
})
