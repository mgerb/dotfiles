local M = {}

local plugin_conf = require "custom.plugins.configs"
local userPlugins = require "custom.plugins"

M.plugins = {
   status = {
      colorizer = true,
   },

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   default_plugin_config_replace = {
      nvim_treesitter = plugin_conf.treesitter,
      nvim_tree = plugin_conf.nvimtree,
      gitsigns = plugin_conf.gitsigns,
   },

   install = userPlugins,
}

M.mappings = {
   plugins = {
      lspconfig = {
         set_loclist = "",
      },
   },
}

M.ui = {
   theme = "onedark",
}

return M
