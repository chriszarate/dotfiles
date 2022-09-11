local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

return require('packer').startup(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	-- End whitespace wars
	use "editorconfig/editorconfig-vim"

	-- -- Fuzzy finding
	use "junegunn/fzf"
	use { "junegunn/fzf.vim", config = "require('plugins.fzf')" }

	-- Sidebar to preview registers
	use "junegunn/vim-peekaboo"

	-- File browser
	use { "mcchrish/nnn.vim", config = "require('plugins.nnn')" }

	-- Colorscheme
	use { "ellisonleao/gruvbox.nvim", config = "require('plugins.gruvbox')" }

	-- Language server config
	use {
		'VonHeikemen/lsp-zero.nvim',
		config = "require('plugins.lsp')",
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},
		}
	}

	-- Treesitter
	use { "nvim-treesitter/nvim-treesitter", config = "require('plugins.treesitter')" }

	-- Commenting / uncommenting
	use "tpope/vim-commentary"

	use { "tpope/vim-fugitive", config = "require('plugins.fugitive')" }

	-- Repeat more actions with .
	use "tpope/vim-repeat"

	-- More previous / next commands with []
	use "tpope/vim-unimpaired"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
