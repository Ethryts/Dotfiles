---@diagnostic disable: undefined-global

require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use 'tpope/vim-fugitive'
	-- Themes
	use { "EdenEast/nightfox.nvim", tag = "v1.0.0" }
	use 'ellisonleao/gruvbox.nvim'
	use 'folke/tokyonight.nvim'

	--visual Plugins
	use 'ryanoasis/vim-devicons'
	use 'kyazdani42/nvim-web-devicons'
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	use {
		'lewis6991/gitsigns.nvim',
		-- tag = 'release' -- To use the latest release
	}
	use 'jose-elias-alvarez/null-ls.nvim'

	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	}
	use "rafamadriz/friendly-snippets"

	use { "akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end }

	use {
		'williamboman/mason.nvim',
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
	use "folke/neodev.nvim"
	use 'hrsh7th/nvim-cmp' -- completion ctr space
	use 'hrsh7th/cmp-path' -- completion based on paths
	--use 'hrsh7th/cmp-spell'					-- completion based on spelling
	use 'hrsh7th/cmp-git' -- completion based on git branches and stuff
	use 'hrsh7th/cmp-nvim-lsp' -- completion based on LSP source
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets Engine plugin

	use { -- Auto Brackets
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	use 'nvim-lua/plenary.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } }
	}
	use 'nvim-telescope/telescope-project.nvim'
	use 'gbrlsnchs/telescope-lsp-handlers'
	use 'nvim-telescope/telescope-file-browser.nvim'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'nvim-treesitter/nvim-treesitter-context'

	--use { -- Spellcheck using treeSitter
	--'lewis6991/spellsitter.nvim',
	--}
	--Other
	--
	use({
  "folke/noice.nvim",
  config = function()
    require("noice").setup()
  end,
  requires = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
})
end)

require('Comment').setup()

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()


vim.cmd [[colorscheme tokyonight]]
require("toggleterm").setup({
	open_mapping = [[<c-T>]],
	winbar = {
		enabled = true,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end
	}
})


require('gitsigns').setup({})
require('TelescopeConfig')
--require('TreesitterConfig')
--require('felineConfig')
require('neogit').setup {}
--require 'spellsitter'.setup {
--	enabled = true
--}
require('nightfox').setup({
	options = {
		-- Compiled file's destination location
		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
		compile_file_suffix = "_compiled", -- Compiled file suffix
		transparent = false, -- Disable setting background
		terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
		dim_inactive = false, -- Non focused panes set to alternative background
		styles = { -- Style to be applied to different syntax groups
			comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
			conditionals = "NONE",
			constants = "NONE",
			functions = "NONE",
			keywords = "NONE",
			numbers = "NONE",
			operators = "NONE",
			strings = "NONE",
			types = "NONE",
			variables = "NONE",
		},
		inverse = { -- Inverse highlight for different types
			match_paren = false,
			visual = false,
			search = false,
		},
		modules = { -- List of various plugins and additional options
			Telescope = true

		},
	}
})






local kind_icons = {
	Text = '',
	Method = 'm',
	Function = '',
	Constructor = '',
	FIELD = 'ﭟ',
	Variable = '',
	Class = '',
	Interface = '',
	Module = '{}',
	Property = '',
	Unit = '',
	Value = '',
	Enum = '',
	Keyword = '',
	Snippet = '',
	Color = '',
	File = '',
	Reference = '',
	Folder = '',
	EnumMember = '',
	Constant = '',
	Struct = '',
	Event = '',
	Operator = '',
	TypeParameter = '',
}
local menuString = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	luasnip = "[LuaSnip]",
	nvim_lua = "[Lua]",
	latex_symbols = "[LaTeX]",
}





local luasnip = require 'luasnip' -- luasnip setup
local cmp = require 'cmp' -- nvim-cmp setup
cmp.setup {
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local prsnt, lspkind = pcall(require, "lspkind")
			--if not prsnt then
			-- From kind_icons array
			--	vim_item.kind = string.format('%s ', kind_icons[vim_item.kind])
			--else
			-- From lspkind
			--vim_item.kind = string.format('%s ', kind_icons[vim_item.kind])
			--return lspkind.cmp_format()
			--end
			vim_item.kind = string.format('%s ', kind_icons[vim_item.kind])
			-- Kind icons
			-- Source
			vim_item.menu = menuString[entry.source.name]
			return vim_item
		end
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end, false
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<esc>'] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close()
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'git' },
		{ name = 'spell' },
	},
}
