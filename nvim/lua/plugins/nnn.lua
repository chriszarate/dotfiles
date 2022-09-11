local keymap = vim.keymap.set
local silent = { silent = true }

require("nnn").setup({
	action               = {
		["<c-s>"] = "split",
		["<c-v>"] = "vsplit",
	},
	layout               = "enew", -- Full-screen instead of floating window
	replace_netrw        = 1,      -- Replace netrw when opening a directory
	set_default_mappings = 0,      -- Disable default mappings
})

-- Configure bat previews
vim.fn.setenv("BAT_STYLE", "changes,header,numbers")

-- Keymaps
keymap("n", "_", ":NnnPicker %:p:h<cr>", silent)
keymap("n", "-", ":NnnPicker<cr>", silent)
