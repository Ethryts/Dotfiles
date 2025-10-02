local header = {
"███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
"████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
"██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
"██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
"██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
"╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
 
}
return {
    { 'lewis6991/gitsigns.nvim'},
    { 'ryanoasis/vim-devicons',       lazy = true },
    { 'kyazdani42/nvim-web-devicons', lazy = true },
    -- {
    --     'nvimdev/dashboard-nvim',
    --     event = 'VimEnter',
    --     config = function()
    --         require('dashboard').setup {
    --             theme="hyper",
    --             shortcut_type="number",
    --             config={
    --                 header=header,
    --                 shortcut={},
    --             },
    --
    --         }
    --     end,
    --     dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    -- }
}
