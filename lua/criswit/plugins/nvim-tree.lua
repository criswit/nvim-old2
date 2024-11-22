local keymaps = function()
	vim.api.nvim_set_keymap("n", "<leader>ee", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
end
local config = function()
	require("nvim-tree").setup({
		-- General settings
		disable_netrw = true, -- Disable Neovim's built-in file explorer
		hijack_netrw = true, -- Replace netrw with nvim-tree
		auto_reload_on_write = true, -- Automatically reload tree when file changes
		hijack_cursor = true, -- Keep the cursor on the first item
		hijack_unnamed_buffer_when_opening = false,

		-- Update behavior
		update_focused_file = {
			enable = true, -- Highlight file in the tree when it's open in a buffer
			update_root = true, -- Update root directory when changing files
		},

		-- Git integration
		git = {
			enable = true, -- Enable Git status icons
			ignore = false, -- Show .gitignored files
			timeout = 500,
		},

		-- View settings
		view = {
			width = 30, -- Default width of the tree
			side = "left", -- Open tree on the left side
			adaptive_size = false, -- Disable dynamic resizing
		},

		-- Renderer settings
		renderer = {
			highlight_git = true, -- Highlight Git status in the tree
			highlight_opened_files = "all", -- Highlight all opened files
			indent_markers = {
				enable = true, -- Show indent markers
			},
			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
				},
			},
		},

		-- Filters
		filters = {
			dotfiles = false, -- Show hidden files
			custom = { ".DS_Store" }, -- Exclude specific files
		},

		-- Actions
		actions = {
			open_file = {
				resize_window = true, -- Resize tree window when opening files
				quit_on_open = true, -- Close tree when opening a file
			},
		},

		-- Diagnostics
		diagnostics = {
			enable = true, -- Show LSP diagnostics in the tree
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},

		keymaps(),
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = config,
}
