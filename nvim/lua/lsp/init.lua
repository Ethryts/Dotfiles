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
    'pyright',
    'pylsp',
    'jedi_language_server',
    'tsserver',
    'volar',
    'lua_ls'
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

--spconfig['html'].setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
--	filetypes = { 'handlebars','html'}
--}


null_ls.setup({
	sources = {
		require("null-ls").builtins.diagnostics.eslint,
		--        require("null-ls").builtins.completion.spell,
	},
})
