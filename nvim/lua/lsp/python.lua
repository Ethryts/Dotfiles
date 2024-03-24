m = {}

-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- local keymap = vim.keymap.set
    --local keymap = vim.api.keymap
    -- local lspbuf = vim.lsp.buf
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- print("on_attach " .. client)
end

function m:get_pyright_config(capabilities)
    local config = {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = require('lspconfig').util.root_pattern('.git'),
        settings = {
            python = {
                analysis = {
                    pythonVersion = '3.0',
                    extraPaths = {
                        "~/Code/she-etq/",
                        "~/Code/she-etq/Lib",
                    },

                }
            }
        }
    }
    return config
end

function m:get_pylsp_config(capabilities)
    local config = {

        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        maxLineLength = 120
                    },
                    jedi = {
                        extra_paths = {
                            "~/Code/she-etq/",
                            "~/Code/she-etq/Lib",
                        }
                    }
                }
            }
        }
    }
    return config
end

return m
