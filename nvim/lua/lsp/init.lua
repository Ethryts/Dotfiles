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
	local keymap = vim.keymap.set
	--local keymap = vim.api.keymap
	local lspbuf = vim.lsp.buf
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true}
	keymap('n', 'gD', lspbuf.declaration, bufopts)
	keymap('n', 'gd', lspbuf.definition, bufopts)
	keymap('n', 'K', lspbuf.hover, bufopts)
	keymap('n', 'gi', lspbuf.implementation, bufopts)
	keymap('n', '<C-k>', lspbuf.signature_help, bufopts)
	keymap('n', '<leader>wa', lspbuf.add_workspace_folder, bufopts)
	keymap('n', '<leader>wr', lspbuf.remove_workspace_folder, bufopts)
	keymap('n', '<leader>D', lspbuf.type_definition, bufopts)
	keymap('n', '<leader>rn', lspbuf.rename, bufopts)
	keymap('n', '<leader>ca', lspbuf.code_action, bufopts)
	keymap('n', 'gr', lspbuf.references, bufopts)
	keymap('n', '<leader>=', lspbuf.format, bufopts)
	keymap('n', '<leader>wl',
		function()
			print(vim.inspect(lspbuf.list_workspace_folders()))
		end, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
-- 
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
    'clangd',
    'rust_analyzer',
    'omnisharp',
    -- 'pyright',
    'pylsp',
    'jedi_language_server',
    'tsserver',
    'volar',
    'sumneko_lua'
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
