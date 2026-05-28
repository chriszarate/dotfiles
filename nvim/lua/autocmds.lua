-- Autocommands

local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
	command = "silent! Gcd",
	pattern = "*",
})

autocmd("BufEnter", {
	callback = function()
		local file = vim.fn.expand("%:t")
		local command = "fish_title vim"
		if file ~= "" then command = command .. " " .. file end
		local title_str = vim.fn.trim(vim.fn.system('fish -c "' .. command .. '"'))
		vim.opt.titlestring = title_str
		vim.opt.title = true
	end,
	group = vim.api.nvim_create_augroup("TerminalTitle", { clear = true }),
	pattern = "*",
})

autocmd('LspAttach', {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		if client:supports_method('textDocument/implementation') then
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
			end

			map("n", "<localleader>a", vim.lsp.buf.code_action)
			map("n", "<localleader>d", vim.lsp.buf.definition)
			map("n", "<localleader>D", vim.lsp.buf.declaration)
			map("n", "<localleader>i", vim.lsp.buf.implementation)
			map("n", "<localleader>k", vim.lsp.buf.hover)
			map("n", "<localleader>n", vim.lsp.buf.rename)
			map("n", "<localleader>r", vim.lsp.buf.references)
			map("n", "<localleader>t", vim.lsp.buf.type_definition)
			map("n", "<localleader>y", vim.diagnostic.open_float)

			map("n", "[x", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end)
			map("n", "]x", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end)
			map("n", "[X", function()
				vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true })
			end)
			map("n", "]X", function()
				vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, float = true })
			end)
		end

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		end

		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if not client:supports_method('textDocument/willSaveWaitUntil')
				and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
				end,
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
			})
		end
	end,
	group = vim.api.nvim_create_augroup('my.lsp', {}),
})
