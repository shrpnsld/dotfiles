local lazy = require("lazy")

lazy.setup({
		-- Utility
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		"nvim-treesitter/nvim-treesitter-textobjects",
		{ "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", } },
		"nvim-tree/nvim-web-devicons",
		-- "neovim/nvim-lspconfig",
		-- "gorbit99/codewindow.nvim",
		-- { "williamboman/mason.nvim", dependencies = "williamboman/mason-lspconfig.nvim" },
		{ "mhinz/vim-signify",
			init = function()
				vim.g.signify_update_on_bufenter = 1
				vim.g.signify_update_on_focusgained = 1
				vim.g.signify_sign_add               = "┃"
				vim.g.signify_sign_delete            = "┃"
				vim.g.signify_sign_delete_first_line = "┃"
				vim.g.signify_sign_change            = "┃"
				vim.g.signify_sign_change_delete     = "┃"

				local augroup = vim.api.nvim_create_augroup("refresh_signify", { clear = true })
				vim.api.nvim_create_autocmd("TextChanged", { pattern = "*", group = augroup, callback = vim.fn["sy#start"] } )
				vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", group = augroup, callback = vim.fn["sy#start"] } )
			end },
		{ "shrpnsld/ocd-save.vim",
			init = function()
				vim.opt.swapfile = false
				vim.g.ocd_save_message = vim.v.null
			end },
		"shrpnsld/trailing-shade.vim",

		-- Color schemes
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		"rebelot/kanagawa.nvim",
		"thesimonho/kanagawa-paper.nvim",
		"vague2k/vague.nvim",
		"ghifarit53/tokyonight-vim",
		"tiagovla/tokyodark.nvim",
		"folke/tokyonight.nvim",
		"shrikecode/kyotonight.vim",
		"franbach/miramare",
		"shaunsingh/moonlight.nvim",
		"marko-cerovac/material.nvim",
		"mellow-theme/mellow.nvim",
		"Chromosore/vim-inkpot-refilled"

		-- "rktjmp/lush.nvim",
		-- "ntk148v/habamax.nvim",

		-- Color schemes "notermguicolors"
		-- { "dracula/vim", name = "dracula" }
		-- "rakr/vim-one"
		-- "nanotech/jellybeans.vim"
		-- "wadackel/vim-dogrun"
		-- "sainnhe/edge"

		-- Acrhive
		-- "godlygeek/csapprox"
	},

	{
		ui = {
			border = "rounded",
		},
	}
)

