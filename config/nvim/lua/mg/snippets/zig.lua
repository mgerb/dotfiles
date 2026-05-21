local ls = require("luasnip")
local extras = require("luasnip.extras")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local rep = extras.rep

ls.add_snippets("zig", {
	s("mg-interface", {
		t({ "const " }),
		i(1, "Interface"),
		t({
			" = struct {",
			"    const Self = @This();",
			"",
			"    ptr: *anyopaque,",
			"    vtable: *const VTable,",
			"",
			"    const VTable = struct {",
			"        ",
		}),
		i(2, "method"),
		t(": *const fn (ptr: *anyopaque"),
		i(3, ", arg: Arg"),
		t(") "),
		i(4, "void"),
		t({
			",",
			"    };",
			"",
			"    pub fn ",
		}),
		rep(2),
		t("(self: Self"),
		rep(3),
		t(") "),
		rep(4),
		t({
			" {",
			"        return self.vtable.",
		}),
		rep(2),
		t("(self.ptr"),
		i(5, ", arg"),
		t({
			");",
			"    }",
			"};",
		}),
	}),
})
