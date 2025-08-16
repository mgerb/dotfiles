local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("nix", {
	s("mg-flake", {
		t({
			"{",
			'  description = "',
		}),
		i(1),
		t({ '";', "", "" }),

		t({
			"  inputs = {",
			'    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";',
			'    flake-utils.url = "github:numtide/flake-utils";',
			"  };",
			"",
			"",
		}),

		t({
			"  outputs = {",
			"    self,",
			"    nixpkgs,",
			"    flake-utils,",
			"  }:",
			"    flake-utils.lib.eachDefaultSystem (system: let",
			"      pkgs = import nixpkgs {",
			"        inherit system;",
			"      };",
			"    in {",
			"      devShells.default = pkgs.mkShell {",
			"        buildInputs = with pkgs; [",
			"          ",
		}),
		i(2), -- insert buildInputs here
		t({ "", "        ];", "", "        shellHook = ''", "" }),
		i(3), -- insert shellHook here
		t({ "", "        '';", "      };", "    });", "}" }),
	}),
})
