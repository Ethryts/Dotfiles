
return {


    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        ---@class wk.Opts
        opts = {
            presets = 'helix',
            spec = {
                { "<leader>f", group = "find" } }

            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    -- {
    --   "folke/ts-comments.nvim",
    --   event = "VeryLazy",
    --   opts = {},
    -- },
    {
        "akinsho/toggleterm.nvim",
        enabled=true,
        opts = {
            open_mapping = [[<c-T>]],
            -- shell = 'bash',
            winbar = {
                enabled = true,
                name_formatter = function(term) --  term: Terminal
                    return term.name
                end
            }
        }
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },   -- optional `vim.uv` typings
}
