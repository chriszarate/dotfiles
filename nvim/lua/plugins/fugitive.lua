local keymap = vim.keymap.set
local silent = { silent = true }

keymap("n", "<leader>d", ":Gvdiff<cr>", silent)
keymap("n", "<leader>s", ":vert Git<cr>", silent)

-- Set working directory to git root
vim.api.nvim_create_autocmd({"VimEnter"}, { pattern = "*", command = "silent! Gcd"})
