function map( mode, shortcut, command)
	vim.api.nvim_set_keymap(mode,shortcut, command,{noremap = true, silent = true})
end



-- Variabels
--

map('n',' ','')
vim.g.mapleader = ' '


map('i','jk','<Esc>')
map('n','<leader>ff',"<cmd>lua require('telescope.builtin').find_files()<cr>")
map('n','<leader>fc',"<cmd>lua require('telescope.bui:cmltin').commands()<cr>")
--map('n','<C-leader>',"<cmd>lua require('telescope.builtin').quickfix()<cr>")
map('n','<leader>fq',"<cmd>lua require('telescope.builtin').pickers()<cr>")


-- Using Lua functions
map('n','<leader>ff','<cmd>lua  require("telescope.builtin").find_files()<cr>')
map('n','<leader>fg','<cmd>lua  require("telescope.builtin").live_grep()<cr>')
map('n','<leader>fb','<cmd>lua  require("telescope.builtin").buffers()<cr>')
map('n','<leader>fh','<cmd>lua  require("telescope.builtin").help_tags()<cr>')


