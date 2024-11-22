local config = function()
	local cmp = require("cmp")
	local lspkind = require("lspkind")

	local function select_next_item(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		else
			fallback()
		end
	end

	local function confirm_completion(fallback)
		if cmp.visible() then
			cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
		else
			fallback()
		end
	end

	cmp.setup({
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "path" },
		},
		preselect = "item",
		mode = "symbol",
		mapping = cmp.mapping.preset.insert({
			["<Tab>"] = function(fallback)
				select_next_item(fallback)
			end,
			["<CR>"] = function(fallback)
				confirm_completion(fallback)
			end,
		}),
	})
end

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"onsails/lspkind.nvim",
	},
	config = config,
}
