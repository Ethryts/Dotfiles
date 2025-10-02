local keymap = vim.keymap.set
local M = {}



-- Variabels

local opts = { noremap = true, silent = true }

local spread = vim.tbl_deep_extend
-- Leader
-- keymap('', '<space>', '<Nop>', opts)
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

-- Basic keybinds
keymap("v", "p", '"_dP', opts) -- visual mode paste over will delete to _ register and then paste
keymap('i', 'jk', '<Esc>', opts)
keymap('n', 'gp', '`[v`]', { noremap = true, silent = true, desc = "Select last pasted content" })
-- -- Terminal
keymap('t', 'jk', '<C-\\><C-n>', opts)

-- +++++++++++++++++++++
--Telescope
-- +++++++++++++++++++++
local telescopeBuiltin = require('telescope.builtin')
local fzf = require('fzf-lua')

local file_picker = fzf.files
-- keymap('n', '<leader>ff', telescopeBuiltin.find_files, { noremap = true, silent = true, desc = "Find File" })
keymap('n', '<leader>ff', file_picker, { noremap = true, silent = true, desc = "Find File" })
keymap('n', '<leader>fg', telescopeBuiltin.live_grep, { noremap = true, silent = true, desc = "Find Grep" })
keymap('n', '<leader>fc', telescopeBuiltin.commands, { noremap = true, silent = true, desc = "Find Commands" })
keymap('n', '<C-Space>', telescopeBuiltin.quickfix, { noremap = true, silent = true, desc = "Find Quickfix" })
keymap('n', '<leader>fq', telescopeBuiltin.pickers, { noremap = true, silent = true, desc = "Find Pickers" })
-- keymap('n', '<leader>ft', telescopeBuiltin.builtin, { noremap = true, silent = true, desc = "Find Builtins" })
keymap('n', '<leader>fb', telescopeBuiltin.buffers, { noremap = true, silent = true, desc = "Find Buffers" })
keymap('n', '<leader>fh', telescopeBuiltin.help_tags, { noremap = true, silent = true, desc = "Find Help Tags" })
keymap('n', '<leader>fd', telescopeBuiltin.diagnostics, { noremap = true, silent = true, desc = "Find Diagnostics" })
keymap('n', '<leader>fp', require("telescope").extensions.project.project,
    { noremap = true, silent = true, desc = "Find Project" })
keymap('n', '<leader>ft', require("telescope").extensions.picker_list.picker_list,
    { noremap = true, silent = true, desc = "Find Telescope Pickers" })

keymap('n','<leader>/', "<cmd>execute 'lvimgrep /'.@/.'/ % | lopen'<CR>", {noremap=true, silent = true, desc = "Open Last search in local quick fix list"})

-- require("telescope").load_extension("refactoring")
--
-- -- remap to open the Telescope refactoring menu in visual mode
keymap(
    "v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)
--
-- +++++++++++++++++++++
-- cmp mappings
-- +++++++++++++++++++++
function M.cmp_mappings(cmp, luasnip)
    return {
        ["<C-p>"] = cmp.mapping(function(fallback)
            if not cmp.visible() then
                cmp.complete()
            else
                cmp.select_prev_item()
            end
        end, { 'i', 's' }),
        ["<C-n>"] = cmp.mapping(function(fallback)
            if not cmp.visible() then
                cmp.complete()
            else
                cmp.select_next_item()
            end
        end, { 'i', 's' }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<enter>'] = cmp.mapping.complete({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Esc>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            -- c = cmp.mapping.close()
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            -- if cmp.visible() then
            --     cmp.select_next_item()
            if luasnip.expand_or_locally_jumpable() then
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
-- local harpoon = require('harpoon.mark')
-- local harpoonLeader = '<leader>h'
-- keymap('n', harpoonLeader .. 'A', function() return harpoon.set_current_at(1) end, opts)
-- keymap('n', harpoonLeader .. 'S', function() return harpoon.set_current_at(2) end, opts)
-- keymap('n', harpoonLeader .. 'D', function() return harpoon.set_current_at(3) end, opts)
-- keymap('n', harpoonLeader .. 'F', function() return harpoon.set_current_at(4) end, opts)
--
-- local harpoonUI = require('harpoon.ui')
-- keymap('n', harpoonLeader .. 'a', function() return harpoonUI.nav_file(1) end, opts)
-- keymap('n', harpoonLeader .. 's', function() return harpoonUI.nav_file(2) end, opts)
-- keymap('n', harpoonLeader .. 'd', function() return harpoonUI.nav_file(3) end, opts)
-- keymap('n', harpoonLeader .. 'f', function() return harpoonUI.nav_file(4) end, opts)
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

keymap('n', 'K', vim.lsp.buf.hover , opts)
keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
keymap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)

keymap('n', '<leader>D', vim.lsp.buf.type_definition, opts)
keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
keymap('n', '<space>ca', vim.lsp.buf.code_action, opts)
keymap('n', '<leader>cf', vim.lsp.buf.format, opts)

return M
