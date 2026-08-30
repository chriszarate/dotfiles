vim.opt.background = "dark"
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy' }
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "#" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"
vim.opt.showtabline = 0
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
-- /tmp is purged by macOS on its own schedule, which quietly loses undo
-- history. stdpath("state") persists.
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undofile = true
