local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print("lsp not available")
    return
end


require("neodev").setup({}) -- neovim config language compleiton
local null_ls = require("null-ls")
local lspconfig = require('lspconfig')
require("mason").setup()
require("mason-lspconfig").setup({
})


local diagnosticSigns = {
    { name = "DiagnosticSignError", text = '' },
    { name = "DiagnosticSignWarn", text = '' },
    { name = "DiagnosticSignHint", text = '' },
    { name = "DiagnosticSignInfo", text = '' }
}

for _, sign in ipairs(diagnosticSigns) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    sings = {
        active = diagnosticSigns
    },
    severity_sort = true,
    float = {
        style = "minimal",
        border = "rounded",
        source = "always"
    }
}
vim.diagnostic.config(config)

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- local keymap = vim.keymap.set
    --local keymap = vim.api.keymap
    -- local lspbuf = vim.lsp.buf
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- print("on_attach " .. client)
end

-- Add additional capabilities supported by nvim-cmp
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
    'clangd',
    'rust_analyzer',
    'omnisharp',
    -- 'pylsp',
    -- 'jedi_language_server',
    'tsserver',
    'volar',
    'html',
    'lua_ls',
    'jdtls',
    'sqlls',
    'esbonio',

}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        root_dir = lspconfig.util.root_pattern('.git'),
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

python_lsp = require('lsp.python')

-- lspconfig['pylsp'].setup(python_lsp.get_pylsp_config(capabilities))
lspconfig['pyright'].setup(python_lsp.get_pyright_config(capabilities))


-- lspconfig['pylsp'].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     pylsp = {
--         plugins = {
--             flake8 = {
--                 enabled = true
--             }
--         }
--
--     }
-- }

--
-- local etq_source = {
--     name = "etq_source",
--     filetypes = { ["py"] = true },
--     methods = { [require("null-ls").methods.COMPLETION] = true },
--     generator = {
--         fn = function(params)
--             vim.api.nvim_echo(params, true)
--             return "I am a source!"
--         end,
--     },
--     id = 1,
-- }
null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.refactoring,
        -- etq_source,
        null_ls.builtins.diagnostics.flake8.with({extra_args={"--max-line-length","88", "--extend-ignore","E203","--ignore","F405"}}),
        -- null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.xmlformat
        --        require("null-ls").builtins.completion.spell,
        --
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format({
                        async = false,
                        filter = function(client)
                            return client.name == "null-ls"
                        end,
                    })
                end,
            })
        end
    end,
})
