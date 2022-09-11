-- Note: Plugin-specific keymaps are defined in ./plugins/*.lua.

local keymap = vim.keymap.set
local silent = { silent = true }

-- Leader
vim.g.mapleader = " "

-- Buffers
keymap("n", ",,", "<c-^>", silent)
keymap("n", "<leader>w", ":up<cr>")
keymap("n", "<leader>x", ":bdelete<cr>")

-- Search
keymap("n", "<cr>", ":noh<cr><cr>", silent)

-- Windows
keymap("n", "<leader><leader>", "<c-w>")
