
return {
    "williamboman/mason-lspconfig.nvim",
    {
        "neovim/nvim-lspconfig",
        event="VeryLazy",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                -- pyright will be automatically installed with mason and loaded with lspconfig
                pyright = {},
                tsserver = {},
                html = {},
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup {
                        on_attach = function(_, bufnr)
                            local opts = { noremap = true, silent = true }
                            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                        end,
                    }
                end,
            })
        end

    },
    { "williamboman/mason.nvim", opts = {} },
}
