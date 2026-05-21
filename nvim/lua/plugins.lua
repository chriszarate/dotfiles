-- Plugins

local map = vim.keymap.set

-- Boostrap lazy.nvim automatically if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"ellisonleao/gruvbox.nvim",
		init = function()
			vim.cmd.colorscheme("gruvbox")
		end,
		opts = {
			contrast = "hard",
			italic = {
				comments = false,
				folds = false,
				keywords = false,
				operators = false,
				strings = false,
			},
			overrides = {
				ErrorMsg = { link = "GruvboxRedBold" },
				SignColumn = { bg = "#1d2021" },
				Visual = { bg = "#282828", reverse = false },
				WarningMsg = { link = "GruvboxOrangeBold" },
				Whitespace = { fg = "#282828" },
			},
			palette_overrides = {
				dark0_hard = "#0d1011",
			},
		},
	},
	{
		"github/copilot.vim",
		init = function()
			local node_cmd = vim.fn.trim(vim.fn.system("fnm exec --using 22 which node"))
			vim.g.copilot_node_command = vim.fn.fnameescape(node_cmd)

			map("i", "<c-s-]>", "<plug>(copilot-previous)", { silent = true })
			map("i", "<c-]>", "<plug>(copilot-next)", { silent = true })
		end,
	},
	{
		"junegunn/fzf.vim",
		dependencies = { 'junegunn/fzf' },
		init = function()
			map("n", "<leader>b", "<cmd>Buffers!<cr>", { silent = true })
			map("n", "<leader>c", "<cmd>Commands!<cr>", { silent = true })
			map("n", "<leader>f", "<cmd>GFiles!?<cr>", { silent = true })
			map("n", "<leader>h", "<cmd>History!<cr>", { silent = true })
			map("n", "<leader>l", "<cmd>BCommits!<cr>", { silent = true })
			map("n", "<leader>m", "<cmd>Marks!<cr>", { silent = true })
			map("n", "<leader>p", "<cmd>Files!<cr>", { silent = true })
			map("n", "<leader>/", "<cmd>RG!<cr>", { silent = true })
			map("n", "<leader>#", ":Rg! <c-r><c-w><cr>", { silent = true })
		end,
	},
	"junegunn/vim-peekaboo",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require('gitsigns')

					local function bmap(mode, l, r, opts)
						opts = opts or { silent = true }
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					bmap("n", "<leader>gh", gitsigns.preview_hunk_inline)
					bmap("n", "<leader>gl", gitsigns.blame_line)
					bmap('n', '<leader>gr', gitsigns.reset_hunk)
				end,
			})
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		keys = {
			{
				"-",
				mode = { "n" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"_",
				mode = { "n" },
				"<cmd>Yazi cwd<cr>",
				desc = "Open yazi in nvim's working directory",
			},
		},
		init = function()
			-- mark netrw as loaded so it's not loaded at all.
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = {
			floating_window_scaling_factor = 1,
			open_for_directories = true,
			keymaps = {
				open_file_in_vertical_split = "<c-v>",
				open_file_in_horizontal_split = "<c-x>",
				send_to_quickfix_list = "<c-q>",
			},
			yazi_floating_window_border = "none",
			yazi_floating_window_zindex = 200,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		opts = {
			ensure_installed = {
				"bash",
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"rust",
				"typescript",
				"yaml",
			},
			highlight = { enable = true },
		},
	},
	{
		"ruifm/gitlinker.nvim",
		keys = {
			{
				"<leader>gy",
				mode = { "n" },
				function() require("gitlinker").get_buf_range_url("n") end,
				desc = "Copy the GitHub URL of the current line",
			},
		},
	},
	{
		"tpope/vim-fugitive",
		init = function()
			map("n", "<leader>gb", "<cmd>Git blame<cr>", { silent = true })
			map("n", "<leader>gd", "<cmd>Git diff<cr>", { silent = true })
			map("n", "<leader>gs", "<cmd>Git status<cr>", { silent = true })
		end,
	},
	"tpope/vim-repeat",
	"tpope/vim-unimpaired",

	-- LSP plugins, order here matters:
	"williamboman/mason.nvim",
	"neovim/nvim-lspconfig",
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer",
})
