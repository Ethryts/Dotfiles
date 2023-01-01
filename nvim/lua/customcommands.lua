
--vim.cmd([[ :cd %:p:h ]])-- set initial directory to where this was opened from



vim.cmd([[
	command -nargs=1 T :Telescope <args>
]])


vim.api.nvim_create_user_command(
    'Run',
    function(opts)
		local path = vim.fn.expand("%")
		--vim.api.nvim_open_term
		--vim.cmd("!python3".. path)
		--io.popen("python3 " .. vim.fn.expand("%"))
    end,
    { nargs = 0 }
)
