local config = function()
	local term = require("FTerm")
	term.border = "double"
	vim.keymap.set("n", "<C-i>", '<CMD>lua require("FTerm").toggle()<CR>')
	vim.keymap.set("t", "<C-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
end

return {
	"numToStr/FTerm.nvim",
	config = config,
}
