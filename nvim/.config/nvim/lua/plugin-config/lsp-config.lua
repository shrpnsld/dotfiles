local lspconfig = require("lspconfig")

lspconfig.bashls.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

lspconfig.clangd.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

lspconfig.cmake.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

lspconfig.hls.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

lspconfig.lua_ls.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

lspconfig.sourcekit.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

lspconfig.pylsp.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

lspconfig.vimls.setup {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end
}

require('lspconfig.ui.windows').default_options.border = "rounded"

