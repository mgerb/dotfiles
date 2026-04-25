local ls = require("luasnip")
local d = ls.dynamic_node
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node

local divider = string.rep("-", 76)

-- Get the comment syntax.
local function comment_parts()
	local commentstring = vim.bo.commentstring
	local prefix, suffix = commentstring:match("^(.-)%%s(.*)$")

	prefix = vim.trim(prefix or "//")
	suffix = vim.trim(suffix or "")

	if prefix == "" then
		prefix = "//"
	end

	prefix = prefix .. " "
	if suffix ~= "" then
		suffix = " " .. suffix
	end

	return prefix, suffix
end

local function doc_comment()
	local prefix, suffix = comment_parts()
	local function line(text)
		return prefix .. text .. suffix
	end

	return sn(nil, {
		t({
			line(divider),
			prefix,
		}),
		i(1),
		t({
			suffix,
			line(divider),
		}),
		i(0),
	})
end

-- ----------------------------------------------------------------------------
-- Adds a snippet to create a doc comment like this.
-- ----------------------------------------------------------------------------
ls.add_snippets("all", {
	s("mg-doc", {
		d(1, doc_comment),
	}),
})
