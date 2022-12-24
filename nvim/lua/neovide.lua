--This is a configuraiton file for the NEOVIDE neovim client
-- https://neovide.dev/configuration.html


vim.cmd([[
if exists("g:neovide")
    "g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	let g:neovide_transparency = 0.8
	"let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
endif
]])-- set initial directory to where this was opened from
