vim.g.material_style = "darker"
return {
	"marko-cerovac/material.nvim",
	config = function()
		require("material").setup({
			contrast = {
				sidebars = false,
				floating_windows = false,
			},

			plugins = {},

			high_visibility = {
				darker = true,
			},

			disable_background = false,
			lualine_style = "stealth",
			--custom_highlights = {
			--	CursorLine = { fg = colors.editor.constrast, underline = true },
			--},
		})
	end,
}
