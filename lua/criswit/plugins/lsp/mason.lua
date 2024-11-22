local config = function()
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")
	mason.setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	mason_lspconfig.setup({
		ensure_installed = {
			"ts_ls",
			"gopls",
			"lua_ls",
			"jdtls",
			"nil_ls",
		},
	})
end
return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = config,
}
