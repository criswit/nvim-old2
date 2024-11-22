local language_parsers = function()
	return {
		"json",
		"javascript",
		"typescript",
		"tsx",
		"jsx",
		"yaml",
		"html",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"vim",
		"vimdocs",
		"java",
		"go",
	}
end

local config = function()
	local treesitter = require("nvim-treesitter.configs")
	treesitter.setup({
		highlight = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"prisma",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"java",
			"go",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = config,
}
