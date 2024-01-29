vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')
" Utility
	Plug 'mhinz/vim-signify'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'shrpnsld/trailing-shade.vim'
	Plug 'shrpnsld/ocd-save.vim'

" Color schemes
	" 'termguicolors'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin', 'branch': 'main' }
	Plug 'rebelot/kanagawa.nvim'
	Plug 'ghifarit53/tokyonight-vim'
	Plug 'tiagovla/tokyodark.nvim'
	Plug 'folke/tokyonight.nvim'
	Plug 'shrikecode/kyotonight.vim'
	Plug 'franbach/miramare'

	" giving a try
	Plug 'rose-pine/neovim'
	Plug 'EdenEast/nightfox.nvim' " duskfox flavor
	Plug 'cryptomilk/nightcity.nvim' " afterlife flavor
	Plug 'bluz71/vim-moonfly-colors'
	Plug 'miikanissi/modus-themes.nvim'
	Plug 'zootedb0t/citruszest.nvim'
	Plug 'nyngwang/nvimgelion'
	Plug 'olimorris/onedarkpro.nvim'

	" color schemes 'notermguicolors'
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'rakr/vim-one'
	Plug 'nanotech/jellybeans.vim'
	Plug 'wadackel/vim-dogrun'
	Plug 'sainnhe/edge'

" Archive
	"Plug 'godlygeek/csapprox'
call plug#end()
]]

