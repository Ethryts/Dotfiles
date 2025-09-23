-- vim.cmd([[colorscheme tokyonight-night]])
vim.cmd([[colorscheme onedark]])
-- vim.cmd([[hi WinSeparator cterm=bold gui=bold guifg=grey]])
vim.api.nvim_set_hl(0, 'WinSeparator', {fg='#485F91', bg='', bold=true})
local LineNr = vim.api.nvim_get_hl(0, {name='LineNr'})
-- vim.api.nvim_set_hl(0, 'LineNr', {fg='#aea5a8', bg='', bold=true})
vim.api.nvim_set_hl(0, "LineNr", { link = "Special" })
vim.api.nvim_set_hl(0, 'LineNrAbove', LineNr)
vim.api.nvim_set_hl(0, 'LineNrBelow', LineNr)
--
-- vim.opt.background = "dark" -- or "light" faor light mode
-- vim.cmd([[
-- 	augroup user_colors
-- 	autocmd!
-- 	autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
-- 	autocmd ColorScheme * hi NormalNC guibg=NONE
-- 	hi Normal guibg=NONE ctermbg=NONE    
-- 	hi LineNr guibg=NONE ctermbg=NONE
-- 	hi Folded guibg=None ctermbg=None    
-- 	hi NonText guibg=None ctermbg=None    
-- 	hi SpecialKey guibg=None ctermbg=None    
-- 	hi VertSplit guibg=None ctermbg=None    
-- 	hi SignColumn guibg=None ctermbg=None    
-- 	hi EndOfBuffer guibg=None ctermbg=None  
-- 	augroup END
-- ]])
--

-- vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("hi LineNr guifg = lightgrey")
