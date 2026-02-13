local keymap = vim.keymap.set
local M = {}

local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Basic keybinds
keymap('i', 'jk', '<Esc>', opts("Exit insert mode"))
keymap('t', 'jk', '<C-\\><C-n>', opts("Exit terminal mode"))

keymap("v", "p", '"_dP', opts()) -- visual mode paste over will delete to _ register and then paste
keymap('n', 'gp', '`[v`]', opts("Select last pasted content"))


keymap('n', '<leader>/', "<cmd>execute 'lvimgrep /'.@/.'/ % | lopen'<CR>",
  opts("Open Last search in local quick fix list"))

local diagnostic = vim.diagnostic
keymap('n', '<leader>e', diagnostic.open_float, opts())
-- keymap('n', '[d', function() diagnostic.jump({ count = 1 }) end, opts())
-- keymap('n', ']d', function() diagnostic.jump({ count = -1 }) end, opts())
keymap('n', '<leader>q', diagnostic.setloclist, opts("Set Location List with Diagnostics"))

-- +++++++++++++++++++++
--LSP Mappings
-- +++++++++++++++++++++
-- vim.cmd("set omnifunc=syntaxcomplete#Complete")

local lsp = vim.lsp.buf
-- See `:help vim.lsp.*` for documentation on any of the below functions
keymap('n', 'gD', lsp.declaration, opts())
keymap('n', 'gd', lsp.definition, opts())
keymap('n', 'gi', lsp.implementation, opts())
keymap('n', 'gr', lsp.references, opts())

keymap('n', 'gt', lsp.type_definition, opts("go to type definition"))

keymap('n', 'K', lsp.hover, opts("Show hover documentation"))
keymap('n', '<C-k>', lsp.signature_help, opts("Show signature help"))
keymap('n', '<leader>wa', lsp.add_workspace_folder, opts("Add Workspace Folder"))
keymap('n', '<leader>wr', lsp.remove_workspace_folder, opts("Remove Workspace Folder"))
keymap('n', '<leader>wl', function()
  print(vim.inspect(lsp.list_workspace_folders()))
end, opts("List Workspace Folder"))


keymap('n', '<leader>ca', lsp.code_action, opts("select code action"))
keymap('n', '<leader>rn', lsp.rename, opts("rename symbol"))
keymap('n', '<leader>cf', lsp.format, opts("format"))

return M
