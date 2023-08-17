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
        settings = {
            -- pyright = {
            -- },
            python = {
                analysis = {
                    pythonVersion = '3.0',
                    extraPaths = {
                        -- "\\\\cldawdetqap01\\Tomcat9\\webapps\\reldev\\WEB-INF\\lib\\Lib",
                        -- "Z:/Tomcat9/webapps/reldev/WEB-INF/lib/Lib",
                        "~/Code/she-etq/",
                        "~/Code/she-etq/Lib",
                        -- "C:/Users/et01048090/Code/devenv/ntr",
                        -- "C:\\Users\\et01048090\\Code\\Dev Env\\ntr",
                        -- "C:\\Users\\et01048090\\Code\\Dev Env"
                    },

                }
            }
        }
    }
    return config
end

return m
