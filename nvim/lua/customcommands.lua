
--vim.cmd([[ :cd %:p:h ]])  -- set initial directory to where this was opened from
-- vim.cmd([[ :cd ~/Code/ ]])    -- set initial directory to code

vim.cmd([[
    syntax match Todo /.*TODO:.*/ containedin=.*Comment
]])


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
    'CopyAll',
    function(opts)
        local save_cursor = vim.fn.getcurpos()
        vim.cmd('normal! ggVG"+y')
        vim.fn.setpos('.', save_cursor)
    end,
    {nargs = 0}
)

vim.api.nvim_create_user_command(
    "W",
    function(opts)
        vim.cmd("w")
        vim.cmd('CopyAll')
    end,
    {nargs=0}
)

vim.api.nvim_create_user_command(
    "Scratch",
    function(opts)
        local file_type = ".py"
        if opts.args then
            file_type = opts.args
            if not string.find(file_type,".") then
                file_type = "." .. file_type
            end
        end
        vim.cmd('edit ' .. '~/Code/Scratch/Scratch-' .. os.date("%Y%m%d%H%M%S") ..file_type)
        vim.cmd('write ++p')
    end,
    {nargs='?'}

)

