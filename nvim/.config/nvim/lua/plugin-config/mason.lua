local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup {
}

mason_lspconfig.setup {
	ensure_installed = {
		"bashls",
		"clangd",
		"cmake",
		"hls",
		"lua_ls",
		"pylsp",
		"vimls"
	}
}

