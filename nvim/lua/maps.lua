-- General maps not associated with a plugin

local map = vim.keymap.set

local function CompletionAccept()
	if vim.fn.pumvisible() == 1 then
		if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
			return '<c-y>'  -- Confirm selection
		else
			return '<c-e><cr>' -- Dismiss menu and insert carriage return
		end
	else
		return '<cr>' -- Normal Enter behavior when menu is closed
	end
end

local function CompletionCycleBackwards()
	return vim.fn.pumvisible() == 1 and '<c-p>' or '<s-tab>'
end

local function ToggleQuickFix()
	local qf_exists = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then qf_exists = true end
	end
	if qf_exists then vim.cmd("cclose") else vim.cmd("copen") end
end

-- Completion
map('i', '<cr>', CompletionAccept, { expr = true, noremap = true })
map('i', '<s-tab>', CompletionCycleBackwards, { expr = true, noremap = true })

-- Movement
map("n", ",,", "<c-^>", { silent = true })
map("n", "[j", "<c-o>")
map("n", "]j", "<c-i>")
map("n", "<space><space>", "<c-w>")

-- Miscellaneous
map("n", "<leader>q", ToggleQuickFix, { silent = true })
map("n", "<leader>w", "<cmd>up<cr>", { silent = true })
map("n", "<leader>W", "<cmd>noa w<cr>", { silent = true })
map("n", "<leader>x", "<cmd>bdelete<cr>", { silent = true })
map("n", "cp", ':let @+ = expand("%")<cr>', { silent = true })
map("n", "<cr>", ":noh<cr><cr>", { silent = true })
