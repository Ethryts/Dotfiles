
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
-- init.lua

-- Define the function to transform the selected lines
function refactor_lines()
    -- Get the range of the selected lines in visual mode
    local start_line, end_line = vim.fn.line("'<"), vim.fn.line("'>")

    -- Get the indentation from the first line
    local indent = vim.fn.indent(start_line)

    -- Process each line in the range
    local new_lines = {}
    for line = start_line, end_line do
        local current_line = vim.fn.getline(line)
        local arg = current_line:match("my_function%('(.+)'%)")
        if arg then
            local new_line = string.rep(' ', indent) .. "my_function: '" .. arg .. "',"
            table.insert(new_lines, new_line)
        else
            -- If the current line doesn't match the pattern, add it as it is
            table.insert(new_lines, current_line)
        end
    end

    -- Create the function list
    local function_list = {"func_list = {"}
    vim.list_extend(function_list, new_lines)
    table.insert(function_list, string.rep(' ', indent) .. "}")

    -- Replace the selected lines with the new function list
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, function_list)
end

-- Bind the function to a key in visual mode
vim.api.nvim_set_keymap('v', '<Leader>r', ':lua refactor_lines()<CR>', {noremap = true, silent = true})
-- File: init.lua (or your Neovim Lua configuration file)
-- ~/.config/nvim/lua/refactor.lua
function refactor_python_code()
    local lines = vim.api.nvim_buf_get_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false)
    local switcher = {}
    local same_variable
    local thisValue

    for _, line in ipairs(lines) do
        -- local key, value = line:match('if (%w+) == "([^"]+)"')
        -- local key, value = line:match('if (%w+) == ("?[%w_]+"?)')
        local key, value = line:match('if (%w+) == ?"?([^"]+)"?')

        if key and value then

            -- vim.cmd('echo "'.. key ..'"')
            -- vim.cmd('echo "'.. value ..'"')
            -- vim.cmd('echo "'.. _ ..'"')
            -- local variable, assigned = lines[_+1]:match('(%w+) = "([^"]+)"')
            -- local variable, assigned = lines[_+1]:match('(%w+) = ("?[%w_]+"?)')
            local variable, assigned = lines[_+1]:match('(%w+) = ?("?[^"]+"?)')
            if variable and assigned then
                if _ == 1 then
                    same_variable = variable
                elseif variable ~= same_variable then
                    same_variable = nil
                end
                thisValue = key
                switcher[value] = assigned
            end
        end
    end


    if thisValue and same_variable then
        local output = {same_variable.." = {"}
        for k, v in pairs(switcher) do
            table.insert(output, string.format('    "%s": %s,', k, v))
        end
        table.insert(output, string.format("}.get(%s, None)", thisValue))

        vim.api.nvim_buf_set_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false, output)
    else
        print("No matching pattern found in the selected lines.")
    end
end

-- ~/.config/nvim/init.lua
vim.api.nvim_set_keymap('v', '<leader>s', '<cmd>lua refactor_python_code()<cr>', {noremap = true})

