--test
--vim.cmd([[ :cd %:p:h ]])  -- set initial directory to where this was opened from
-- vim.cmd([[ :cd ~/Code/ ]])    -- set initial directory to code

-- vim.cmd([[
--     syntax match Todo /.*TODO:.*/ containedin=.*Comment
-- ]])


vim.cmd([[
	command -nargs=1 T :Telescope <args>
]])

vim.cmd([[
	command -nargs=1 PyToDict :'<,'>s/^ *\(.*\) =\(.*\)/'\1': \2,
]])


vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = { '*' },
    callback = function()
        vim.api.nvim_command([[unmenu *]])
        vim.api.nvim_command[[anoremenu PopUp.Go\ to\ definition      <Cmd>lua vim.lsp.buf.definition()<CR>]]
        vim.api.nvim_command[[amenu     PopUp.Open\ in\ web\ browser  gx]]
        -- vim.api.nvim_command[[anoremenu PopUp.Inspect                 <Cmd>Inspect<CR>]]
        vim.api.nvim_command[[anoremenu PopUp.-1-                     <Nop>]]
        vim.api.nvim_command[[vnoremenu PopUp.Cut                     "+x]]
        vim.api.nvim_command[[vnoremenu PopUp.Copy                    "+y]]
        vim.api.nvim_command[[anoremenu PopUp.Paste                   "+gP]]
        vim.api.nvim_command[[vnoremenu PopUp.Paste                   "+P]]
        vim.api.nvim_command[[vnoremenu PopUp.Delete                  "_x]]
        vim.api.nvim_command[[nnoremenu PopUp.Select\ All             ggVG]]
        vim.api.nvim_command[[vnoremenu PopUp.Select\ All             gg0oG$]]
        vim.api.nvim_command[[inoremenu PopUp.Select\ All             <C-Home><C-O>VG]]
        vim.api.nvim_command[[anoremenu PopUp.-2-                     <Nop>]]
        -- vim.api.nvim_command([[aunmenu PopUp.How-to\ disable\ mouse]])
        -- vim.api.nvim_command([[menu PopUp.Toggle\ \Breakpoint <cmd>:lua require('dap').toggle_breakpoint()<CR>]])
        vim.api.nvim_command([[menu PopUp.-2- <Nop>]])
        -- vim.api.nvim_command([[menu PopUp.Start\ \Compiler <cmd>:CompilerOpen<CR>]])
        -- vim.api.nvim_command([[menu PopUp.Start\ \Debugger <cmd>:DapContinue<CR>]])
        -- vim.api.nvim_command([[menu PopUp.Run\ \Test <cmd>:Neotest run<CR>]])
        -- vim.api.nvim_command([[menu PopUp.Definition  <cmd>lua vim.lsp.buf.definition()<CR>]])
        -- vim.api.nvim_command([[menu PopUp.Back <c-t>]])
    end
})


-- replace single tabs with 4 tabs
vim.api.nvim_create_user_command(
    'CopyAll',
    function(opts)
        local save_cursor = vim.fn.getcurpos()
        vim.cmd('normal! ggVG"+y')
        vim.fn.setpos('.', save_cursor)
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    "W",
    function(opts)
        vim.cmd("w")
        vim.cmd('CopyAll')
    end,
    { nargs = 0 }
)


vim.api.nvim_create_user_command(
    "Scratch",
    function(opts)
        local file_type = ".py"
        if opts.args then
            file_type = opts.args
            if not string.find(file_type, ".") then
                file_type = "." .. file_type
            end
        end
        vim.cmd('edit ' .. '~/Code/Scratch/Scratch-' .. os.date("%Y%m%d%H%M%S") .. file_type)
        vim.cmd('write ++p')
    end,
    { nargs = '?' }

)

local function has_package_json(path)
    return vim.fn.filereadable(path .. "/package.json") == 1
end

local function directory_exists(dir_path)
    local stat = vim.loop.fs_stat(dir_path)
    return stat and stat.type == "directory"
end
local component_stub = [[
const %s = () => {
  return (
      <>
      </>
  )
}


export default %s
]]
local test_stub = [[
const %s = () => {
  return (
      <>
      </>
  )
}


export default %s
]]
local function create_component(args)
    local name = args.args
    if not name or name == "" then
        vim.print("Component Name Required")
        return
    end

    local root_path = vim.fn.getcwd() .. "/"
    local src_path = root_path .. "src/"
    local components_path = src_path .. "components/"
    local component_path = components_path .. name .. "/"
    local component_file = component_path .. name .. ".tsx"

    local file_content = string.format(component_stub, name, name)

    if not has_package_json(root_path) then
        vim.print("Package.json not found, is this a js project?")
        return
    end
    if not directory_exists(src_path) then
        vim.print("source path 'src' couldn't be found")
        return
    end
    if not directory_exists(components_path) then
        vim.print("Component Path '/components/' couldn't be found")
        return
    end
    if not directory_exists(component_path) then
        vim.fn.mkdir(component_path)
    end
    -- vim.fn.writefile({file_content},component_file)
    if vim.fn.filereadable(component_file) == 1 then
        vim.print("Component file " .. name .. ".tsx already exists")
        return
    end

    local file = io.open(component_file, "w")
    file:write(file_content)
    file:flush()
    file:close()
end
vim.api.nvim_create_user_command("CreateComponent", create_component, { nargs = 1 })

local char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
    if url == nil then
        return
    end
    url = url:gsub("\n", "\r\n")
    url = url:gsub("([^%w ])", char_to_hex)
    url = url:gsub(" ", "+")
    return url
end

local hex_to_char = function(x)
    return string.char(tonumber(x, 16))
end

local urldecode = function(url)
    if url == nil then
        return
    end
    url = url:gsub("+", " ")
    url = url:gsub("%%(%x%x)", hex_to_char)
    return url
end
local on_exit = function(obj)
    print(obj.code)
    print(obj.signal)
    print(obj.stdout)
    print(obj.stderr)
end

local function currentDiagSearch()
    local bufn = vim.api.nvim_get_current_buf()
    local diag = vim.diagnostic.get(bufn)

    local message = diag[1].message
    if not message then
        return
    end
    vim.print(message)
    local search = { "start", "https://www.google.com/search?q=" .. urlencode(message) }
    vim.print(search)
    vim.system(search, { text = true, cwd = "." }, on_exit)
end

vim.api.nvim_create_user_command("CurrentDiagSearch", currentDiagSearch, { nargs = 0 })

-- local function ToBookmarklet()
--     local filetype = vim.api.nvim_get_option_value("filetype", {})
--     if filetype != 'javascript' then
--         print('Not a Javascript file')
--         return
--     end
--
--     local js_lines = vim.api.nvim_buf_get_lines(0, 0, -1)
--     js_lines.insert(1, "javascript: ( () => {")
--     js_lines.insert(#js_lines+1,   "})()")
--     local outpath = vim.api.nvim_buf.get_name(0):gsub("%.js$",".bookmarklet.js")
--     local file = io.open(out_path,"w")
--     file:write(table.concat(js_lines," "))
--     file:close()
--
-- end
--
-- vim.api.nvim_create_user_command("ToBookmarklet", ToBookmarklet)


-- local function SearchCommand(opts)
--     local line1 = opts.line1
--     local line2 = opts.line2
--
-- end
-- vim.api.nvim_create_user_command("Search", SearchCommand, {nargs=0})
