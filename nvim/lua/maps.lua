-- General maps not associated with a plugin

local map = vim.keymap.set

local function ToggleQuickFix()
	local qf_exists = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then qf_exists = true end
	end
	if qf_exists then vim.cmd("cclose") else vim.cmd("copen") end
end

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
