
--vim.cmd([[ :cd %:p:h ]])  -- set initial directory to where this was opened from
-- vim.cmd([[ :cd ~/Code/ ]])    -- set initial directory to code



vim.cmd([[
	command -nargs=1 T :Telescope <args>
]])

vim.cmd([[
	command -nargs=1 PyToDict :'<,'>s/^ *\(.*\) =\(.*\)/'\1': \2,
]])



-- replace single tabs with 4 tabs
vim.api.nvim_create_user_command(
    'PyRetab',
    function(opts)
		vim.cmd([[%s/^\s*/&&&&/g]])
		vim.cmd([[noh]])
    end,
    { nargs = 0 }
)

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
