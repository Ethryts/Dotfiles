
local keymap = vim.api.nvim_set_keymap

-- Variabels

local opts = {noremap= true, silent = true}
keymap('','<space>','<Nop>',opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--
keymap("v","p", '"_dP', opts)-- visual mode paste over will delete to _ register and then paste

keymap('i','jk','<Esc>',opts)
--Telescope
keymap('n','<leader>ff',"<cmd>lua require('telescope.builtin').find_files()<cr>" ,opts)
keymap('n','<leader>fg','<cmd>lua  require("telescope.builtin").live_grep()<cr>', opts)
keymap('n','<leader>fc',"<cmd>lua require('telescope.builtin').commands()<cr>", opts)
keymap('n','<C-leader>',"<cmd>lua require('telescope.builtin').quickfix()<cr>", opts)
keymap('n','<leader>fq',"<cmd>lua require('telescope.builtin').pickers()<cr>",opts)
keymap('n','<leader>fb','<cmd>lua  require("telescope.builtin").buffers()<cr>', opts)
keymap('n','<leader>fh','<cmd>lua  require("telescope.builtin").help_tags()<cr>', opts)
keymap('n','<leader>fp','<cmd>lua  require("telescope").extensions.project.project{}<cr>', opts)
keymap('n','<leader>te','<cmd>lua  require("telescope.builtin").diagnostics()<cr>', opts)


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

