local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   -- webdev
   b.formatting.prettier,
   b.diagnostics.eslint,

   -- Go
   b.formatting.gofmt,
   b.formatting.goimports,

   -- Rust
   b.formatting.rustfmt,

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },


  -- other stuff
  b.completion.spell,
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,
   }
end

return M

