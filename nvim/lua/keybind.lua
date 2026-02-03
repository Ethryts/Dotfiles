local keymap = vim.keymap.set
local M = {}

local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- Basic keybinds
keymap("v", "p", '"_dP', opts()) -- visual mode paste over will delete to _ register and then paste
keymap('i', 'jk', '<Esc>', opts())
keymap('n', 'gp', '`[v`]', opts("Select last pasted content"))
keymap('t', 'jk', '<C-\\><C-n>', opts())

-- +++++++++++++++++++++
-- Picker
-- +++++++++++++++++++++
local fzf = require('fzf-lua')

-- keymap('n', '<leader>ff', telescopeBuiltin.find_files, opts("Find File" ))
keymap('n', '<leader>ff', fzf.files, opts("Find File"))
keymap('n', '<leader>fg', fzf.live_grep, opts("Find Grep"))
keymap('n', '<leader>fc', fzf.commands, opts("Find Commands"))
keymap('n', '<leader>fq', fzf.quickfix, opts("Find Quickfix"))
-- keymap('n', '<leader>fq', telescopeBuiltin.pickers, opts("Find Pickers" ))
keymap('n', '<leader>fb', fzf.buffers, opts("Find Buffers"))
keymap('n', '<leader>fh', fzf.help_tags, opts("Find Help Tags"))
keymap('n', '<leader>fd', fzf.diagnostics_workspace, opts("Find Diagnostics"))
keymap('n', '<leader>fp', require("telescope").extensions.project.project, opts("Find Project"))
keymap('n', '<leader>ft', fzf.builtin, opts("Find Pickers"))

keymap('n', '<leader>/', "<cmd>execute 'lvimgrep /'.@/.'/ % | lopen'<CR>",
    opts("Open Last search in local quick fix list"))

-- require("telescope").load_extension("refactoring")
--
-- -- remap to open the Telescope refactoring menu in visual mode
keymap("v", "<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { noremap = true })

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local diagnostic = vim.diagnostic
keymap('n', '<leader>e', diagnostic.open_float, opts())
keymap('n', '[d', function() diagnostic.jump({ count = 1 }) end, opts())
keymap('n', ']d', function() diagnostic.jump({ count = -1 }) end, opts())
keymap('n', '<leader>q', diagnostic.setloclist, opts("Set Location List with Diagnostics"))

-- +++++++++++++++++++++
--LSP Mappings
-- +++++++++++++++++++++
vim.cmd("set omnifunc=syntaxcomplete#Complete")

local lsp = vim.lsp.buf
-- See `:help vim.lsp.*` for documentation on any of the below functions
keymap('n', 'gD', lsp.declaration, opts())
keymap('n', 'gd', lsp.definition, opts())
keymap('n', 'gi', lsp.implementation, opts())
keymap('n', 'gr', lsp.references, opts())

keymap('n', 'gt', lsp.type_definition, opts("go to type definition"))

keymap('n', 'K', lsp.hover, opts())
keymap('n', '<C-k>', lsp.signature_help, opts())
keymap('n', '<leader>wa', lsp.add_workspace_folder, opts("Add Workspace Folder"))
keymap('n', '<leader>wr', lsp.remove_workspace_folder, opts("Remove Workspace Folder"))
keymap('n', '<leader>wl', function()
    print(vim.inspect(lsp.list_workspace_folders()))
end, opts("List Workspace Folder"))


keymap('n', '<leader>ca', lsp.code_action, opts("select code action"))
keymap('n', '<leader>rn', lsp.rename, opts("rename symbol"))
keymap('n', '<leader>cf', lsp.format, opts("format"))

return M
