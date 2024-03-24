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

vim.cmd("colorscheme tokyonight-night")
vim.cmd("hi LineNr guifg = lightgrey")
