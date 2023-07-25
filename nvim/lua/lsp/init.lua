local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	print("lsp not available")
	return
end


require("neodev").setup({})-- neovim config language compleiton
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
    'pylsp',
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
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

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


lspconfig['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pyright = {
            pythonVersion = 2.7
        },
        python = {
            analysis = {
                extraPaths = {
                    -- "\\\\cldawdetqap01\\Tomcat9\\webapps\\reldev\\WEB-INF\\lib\\Lib",
                    "Z:/Tomcat9/webapps/reldev/WEB-INF/lib/Lib",
                    -- "C:/Users/et01048090/Code/devenv/ntr",
                    -- "C:\\Users\\et01048090\\Code\\Dev Env\\ntr",
                    -- "C:\\Users\\et01048090\\Code\\Dev Env"
                },
            }
        }
    }
}

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
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.ruff,
		require("null-ls").builtins.diagnostics.eslint,
		--        require("null-ls").builtins.completion.spell,
	},
	
})
