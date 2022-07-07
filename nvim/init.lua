local keybinds = require('keybind')
local plugins = require('plugins')
vim.cmd([[ :cd %:p:h ]])
	

require'lspconfig'.pyright.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.volar.setup{}
require'lspconfig'.html.setup{}


vim.opt.background = "dark" -- or "light" faor light mode
vim.cmd([[colorscheme gruvbox
]])
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end

command -nargs=1 T :Telescope <args>
]])

vim.opt.termguicolors = true
vim.opt.autoindent = true

vim.opt.smd = false --turn off mode mesage
vim.g.noru = true -- turno off ruler

local o = vim.o





o.nu = true
o.rnu = true
o.smartcase = true
o.scrolloff = 8
o.incsearch = true
o.hlsearch = false











