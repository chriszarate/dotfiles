-- Custom leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Load plugins first
require('plugins')

require('autocmds')
require('lsp')
require('maps')
require('options')
require('statusline')
require('theme')
