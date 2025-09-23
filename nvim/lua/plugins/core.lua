--
-- local function ensure_tool(tool)
--     local psw = vim.fn.inputsecret("")
--     if vim.fn.executable(tool) == 0 then
--         vim.notify(tool.." not found! Installing...", vim.log.levels.WARN)
--         -- Use the appropriate package manager command for your system
--         local is_mac = vim.fn.has("macunix") == 1
--         local is_linux = vim.fn.has("unix") == 1
--         if is_mac then
--             os.execute("brew install "..tool)
--         elseif is_linux then
--             vim.notify("installing for linux", vim.log.levels.WARN)
--             os.execute("echo '" .. psw .. "' | sudo -S apt-get install "..tool .. " -y")
--         end
--     end
-- end
--
--
local kind_icons = {
    Text = '',
    Method = 'm',
    Function = '󰊕',
    Constructor = '',
    FIELD = 'ﭟ',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '{}',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
}
local menuString = {
    buffer = "[Buf]",
    nvim_lsp = "[LSP]",
    luasnip = "[Snip]",
    vim_dadbod_completion = "[DB]",
    nvim_lua = "[Lua]",
    latex_symbols = "[TeX]",
    path = "[Path]"
}

return {

    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
    },
    {
        enabled=false,
        'hrsh7th/nvim-cmp',
        event = "VeryLazy",
        dependencies = {
            'hrsh7th/cmp-path',         -- completion based on paths
            'hrsh7th/cmp-git',          -- completion based on git branches and stuff
            'hrsh7th/cmp-nvim-lsp',     -- completion based on LSP source
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            'kristijanhusak/vim-dadbod-completion',
            'kyazdani42/nvim-web-devicons',
        },
        config = function(luasnip, opts)
            local luasnip = require('luasnip') -- luasnip setup
            local cmp = require('cmp')         -- nvim-cmp setup
            cmp.setup({
                preselect = cmp.PreselectMode.None,
                completion = { completeopt = "menu,menuone,noselect" },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local prsnt, lspkind = pcall(require, "lspkind")
                        vim_item.kind = string.format('%s ', kind_icons[vim_item.kind])
                        -- Kind icons
                        -- Source
                        vim_item.menu = menuString[entry.source.name]
                        return vim_item
                    end
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                    false
                },
                window = {
                    completion = cmp.config.window.bordered({max_height=100}),
                    documentation = cmp.config.window.bordered(),
                    vim.snippet
                },
                mapping = cmp.mapping.preset.insert(
                    require('keybind').cmp_mappings(cmp, luasnip)
                ),
                sources = {
                    { name = 'nvim_lsp', priority=5},
                    { name = "vim-dadbod-completion", priority=5},
                    { name = 'luasnip' , priority=3},
                    { name = 'path' , priority=3},
                    { name = 'git' , priority=3},
                    { name = 'spell' , priority=3},
                    { name = "lazydev", group_index = 0 , priority=5},
                },
                experimental = {
                    ghost_text = true,
                },
                store_selection_keys="<Tab>",
            })
        end,
    },                      -- completion ctr space
    {
        'L3MON4D3/LuaSnip', -- Snippets Engine plugin
        event = "VeryLazy",
        dependencies = {
            "rafamadriz/friendly-snippets"

        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    },

    {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
        config = true,
    },                   -- This is for luarocks, used by other plugins
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        opts = {

            -- A list of parser names, or "all"
            ensure_installed = { "lua", "python", "c_sharp", "javascript", "css", "java", "c" },
            autotag = {
                enabled = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = "<S-TAB>",
                    node_decremental = "<TAB>",
                },
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            highlight = {
                enable = true,

                -- additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true
            }
        },
        config=function(ts,opts)
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.opt.foldenable = true
            vim.opt.foldlevel = 20
            require("nvim-treesitter.configs").setup(opts)
            -- ts.setup(opts)

        end
    },
    {"nvim-treesitter/playground", dependencies="nvim-treesitter/nvim-treesitter"},
    {
        'TimUntersberger/neogit',
        dependencies = 'nvim-lua/plenary.nvim',
        event = "VeryLazy",
    },

}
