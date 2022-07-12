local keybinds = require('keybind')
local plugins = require('plugins')
vim.cmd([[ :cd %:p:h ]])


require'lspconfig'.pyright.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.volar.setup{}
require'lspconfig'.html.setup{}


vim.opt.background = "dark" -- or "light" faor light mode
vim.cmd([[
	augroup user_colors
	autocmd!
	autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
	autocmd ColorScheme * hi NormalNC guibg=NONE
	hi Normal guibg=NONE ctermbg=NONE    
	hi LineNr guibg=NONE ctermbg=NONE
	hi Folded guibg=None ctermbg=None    
	hi NonText guibg=None ctermbg=None    
	hi SpecialKey guibg=None ctermbg=None    
	hi VertSplit guibg=None ctermbg=None    
	hi SignColumn guibg=None ctermbg=None    
	hi EndOfBuffer guibg=None ctermbg=None  
	augroup END

]])


vim.cmd("colorscheme nightfox")
vim.cmd("hi LineNr guifg = lightgrey")


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

command -nargs=1 T :Telescope <args>

]])

FILENAME = {
	["plugin"] = "\\Users\\Ethan\\AppData\\Local\\nvim\\lua\\plugins.lua",
	["keybinds"] = "\\Users\\Ethan\\AppData\\Local\\nvim\\lua\\plugins.lua",
	["ts"] = "\\Users\\Ethan\\AppData\\Local\\nvim\\lua\\TreesitterConfig.lua",
	["telescope"] = "\\Users\\Ethan\\AppData\\Local\\nvim\\lua\\Telescope.lua",
	["init"] = "\\Users\\Ethan\\AppData\\Local\\nvim\\init.lua",
}


vim.api.nvim_create_user_command(
	'Init', 
	function(opts)
		vim.cmd("e " .. FILENAME[string.lower(opts.args)])
	end,
	{nargs = 1}
)





vim.opt.autoindent = true -- Autoindent
vim.opt.smd = false --turn off mode mesage
vim.g.noru = true -- turno off ruler
local o = vim.o


o.nu = true -- number
o.rnu = true -- relative number
o.ignorecase = true
o.smartcase = true

o.scrolloff = 8
o.incsearch = true
o.hlsearch = true





