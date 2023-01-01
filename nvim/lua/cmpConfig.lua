local luasnip = require 'luasnip' -- luasnip setup
local cmp = require 'cmp' -- nvim-cmp setup

local kind_icons = {
    Text = '',
    Method = 'm',
    Function = '',
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
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    luasnip = "[LuaSnip]",
    nvim_lua = "[Lua]",
    latex_symbols = "[LaTeX]",
}


cmp.setup {
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
        end, false
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert(
        require('keybind').cmp_mappings(cmp, luasnip)
    ),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'git' },
        { name = 'spell' },
    },
    experimental = {
        ghost_text = true
    }
}
