local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"haskell",
		"ini",
		"json",
		"lua",
		"markdown",
		"vim",
		"vimdoc",
		"xml",
		"yaml"
	},

	highlight = {
		enable = true
	}
}

