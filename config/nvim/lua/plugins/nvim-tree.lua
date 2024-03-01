local function open_nvim_tree(data)
	--buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	--change to the directory
	vim.cmd.cd(data.file)
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = true,
    cmd = { "NvimTreeToggle" },
    opts = {
        renderer = {
            highlight_opened_files = "all",
        },
        update_focused_file = {
            enable = true,
        },
        view = {
            width = 40,
        },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}
