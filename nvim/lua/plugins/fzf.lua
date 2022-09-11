local keymap = vim.keymap.set
local silent = { silent = true }

-- Open full-screen instead of in floating window
vim.g.fzf_layout = { window = "enew" }

-- Configure bat previews
vim.fn.setenv("BAT_STYLE", "changes,header,numbers")

-- Keymaps
keymap("n", "<leader>b", ":Buffers<cr>", silent)
keymap("n", "<leader>c", ":Commands<cr>", silent)
keymap("n", "<leader>f", ":GFiles?<cr>", silent)
keymap("n", "<leader>h", ":History<cr>", silent)
keymap("n", "<leader>p", ":Files<cr>", silent)
keymap("n", "<leader>/", ":Rg<cr>", silent)
keymap("n", "<leader>#", ":Rg <c-r><c-w><cr>", silent)
