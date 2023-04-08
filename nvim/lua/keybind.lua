local keymap = vim.keymap.set
local M = {}

-- Variabels

local opts = { noremap = true, silent = true }

-- Leader
keymap('', '<space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basic keybinds
keymap("v", "p", '"_dP', opts) -- visual mode paste over will delete to _ register and then paste
keymap('i', 'jk', '<Esc>', opts)

-- +++++++++++++++++++++
--Telescope
-- +++++++++++++++++++++
local telescopeBuiltin = require('telescope.builtin')
keymap('n', '<leader>ff', telescopeBuiltin.find_files, opts)
keymap('n', '<leader>fg', telescopeBuiltin.live_grep, opts)
keymap('n', '<leader>fc', telescopeBuiltin.commands, opts)
keymap('n', '<C-leader>', telescopeBuiltin.quickfix, opts)
keymap('n', '<leader>fq', telescopeBuiltin.pickers, opts)
keymap('n', '<leader>fb', telescopeBuiltin.buffers, opts)
keymap('n', '<leader>fh', telescopeBuiltin.help_tags, opts)
keymap('n', '<leader>te', telescopeBuiltin.diagnostics, opts)
keymap('n', '<leader>fp', require("telescope").extensions.project.project, opts)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- +++++++++++++++++++++
-- cmp mappings
-- +++++++++++++++++++++
function M.cmp_mappings(cmp, luasnip)
    return {
        ["<C-p>"] = cmp.mapping(function(fallback)
            if not cmp.visible() then
                cmp.complete()
            end
            cmp.select_prev_item()
        end),
        ["<C-n>"] = cmp.mapping(function(fallback)
            if not cmp.visible() then
                cmp.complete()
            end
            cmp.select_next_item()
        end),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Enter>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<esc>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }

end

-- +++++++++++++++++++++
-- Harpoon Mappings
-- +++++++++++++++++++++
local harpoon = require('harpoon.mark')
local harpoonLeader = '<leader>h'
keymap('n', harpoonLeader .. 'A', function() return harpoon.set_current_at(1) end, opts)
keymap('n', harpoonLeader .. 'S', function() return harpoon.set_current_at(2) end, opts)
keymap('n', harpoonLeader .. 'D', function() return harpoon.set_current_at(3) end, opts)
keymap('n', harpoonLeader .. 'F', function() return harpoon.set_current_at(4) end, opts)

local harpoonUI = require('harpoon.ui')
keymap('n', harpoonLeader .. 'a', function() return harpoonUI.nav_file(1) end, opts)
keymap('n', harpoonLeader .. 's', function() return harpoonUI.nav_file(2) end, opts)
keymap('n', harpoonLeader .. 'd', function() return harpoonUI.nav_file(3) end, opts)
keymap('n', harpoonLeader .. 'f', function() return harpoonUI.nav_file(4) end, opts)
-- +++++++++++++++++++++
--LSP Mappings
-- +++++++++++++++++++++

keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)

vim.cmd("set omnifunc=syntaxcomplete#Complete")
-- See `:help vim.lsp.*` for documentation on any of the below functions
keymap('n', 'gD', vim.lsp.buf.declaration, opts)
keymap('n', 'gd', vim.lsp.buf.definition, opts)
keymap('n', 'gi', vim.lsp.buf.implementation, opts)
keymap('n', 'gr', vim.lsp.buf.references, opts)

keymap('n', 'K', vim.lsp.buf.hover, opts)
keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
keymap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)

keymap('n', '<leader>D', vim.lsp.buf.type_definition, opts)
keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
keymap('n', '<space>ca', vim.lsp.buf.code_action, opts)
keymap('n', '<leader>=', vim.lsp.buf.format, opts)

return M
