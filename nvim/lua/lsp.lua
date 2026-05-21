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

local configs = {
	lua_ls = {
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
	},
	gopls = {
		settings = {
			gopls = {
				staticcheck = true,
				gofumpt = true,
				usePlaceholders = true,
			},
		},
	},
	tsserver = {
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
	},
}

require('mason-lspconfig').setup_handlers({
	function(server_name)
		local config = configs[server_name] or {}
		require('lspconfig')[server_name].setup(config)
	end,
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
