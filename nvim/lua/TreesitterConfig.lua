require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = { "lua", "python","c_sharp","javascript", "css",  "java", "c"},
	autotag ={
		enabled = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	highlight = {
		enable = true,

		-- additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true
	}

}
