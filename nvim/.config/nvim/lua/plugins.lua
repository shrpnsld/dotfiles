local lazy = require("lazy")

lazy.setup {
	-- Utility
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", } },
	"nvim-tree/nvim-web-devicons",
	"neovim/nvim-lspconfig",
	{ "williamboman/mason.nvim", dependencies = "williamboman/mason-lspconfig.nvim" },
	"mhinz/vim-signify",
	"shrpnsld/ocd-save.vim",
	"shrpnsld/trailing-shade.vim",

	-- Color schemes
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	"rebelot/kanagawa.nvim",
	"ghifarit53/tokyonight-vim",
	"tiagovla/tokyodark.nvim",
	"folke/tokyonight.nvim",
	"shrikecode/kyotonight.vim",
	"franbach/miramare"

	-- Color schemes "notermguicolors"
	-- { "dracula/vim", name = "dracula" }
	-- "rakr/vim-one"
	-- "nanotech/jellybeans.vim"
	-- "wadackel/vim-dogrun"
	-- "sainnhe/edge"

	-- Acrhive
	-- "godlygeek/csapprox"
}

