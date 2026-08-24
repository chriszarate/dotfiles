require('mason').setup()

require('mason-tool-installer').setup({
	ensure_installed = {
		'bashls',
		'cssls',
		'dockerls',
		'eslint',
		'gopls',
		'harper_ls',
		'html',
		'intelephense',
		'jsonls',
		'lua_ls',
		'prettier',
		'sqlls',
		'shfmt',
		'stylua',
		'typescript-language-server',
		'yamlls',
	},
})

require('mason-lspconfig').setup()

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config('gopls', {
	settings = {
		gopls = {
			staticcheck = true,
			gofumpt = true,
			usePlaceholders = true,
		},
	},
})

vim.lsp.config('ts_ls', {
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = 'all',
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = 'all',
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
})

vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = 'none',
		source = 'if_many',
	},
	underline = true,
	virtual_text = nil,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.INFO] = 'I',
			[vim.diagnostic.severity.HINT] = 'H',
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = 'ErrorMsg',
			[vim.diagnostic.severity.WARN] = 'WarningMsg',
		},
	},
})
