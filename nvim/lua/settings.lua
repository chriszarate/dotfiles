local statusline = require("statusline")

local options = {
	background       = "dark",      -- dark mode
	colorcolumn      = "+1",        -- column to show max line length
	foldenable       = false,       -- open all folds by default
	foldmethod       = "syntax",    -- use syntax highlighting to inform folds
	ignorecase       = true,        -- ignore case when search (but see "smartcase")
	lazyredraw       = true,        -- don't redraw screen during macros and untyped commands
	list             = true,        -- with listchars, show invisibles
	listchars        = "tab:│ ,trail:#",
	number           = true,        -- line numbers
	relativenumber   = true,        -- line numbers relative to the current line
	shell            = "/bin/bash", -- most plugins expect bash
	signcolumn       = "yes",       -- always show the sign column
	smartcase        = true,        -- respect case when it includes uppercase letters
	statusline       = statusline,  -- status line
	termguicolors    = true,        -- true color
	textwidth        = 80,          -- set width of text column
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
