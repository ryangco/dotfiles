return {
	"nvim-neo-tree/neo-tree.nvim",
	event = "VeryLazy",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "=", "<cmd>Neotree reveal<CR>", { desc = "NeoTree reveal" } },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["="] = "close_window",
					["<esc><esc>"] = "close_window",
				},
				position = "right",
			},
			filtered_items = {
				visible = true,
				show_hidden_count = true,
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = {
					-- '.git',
					-- '.DS_Store',
					-- 'thumbs.db',
				},
				never_show = {},
			},
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					-- vimc.cmd("Neotree close")
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
	},
}
