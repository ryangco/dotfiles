return {
	{ "tpope/vim-sleuth" },
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
		keys = {
			{
				"<leader>st",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Todo",
			},
			{
				"<leader>sT",
				function()
					Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
				end,
				desc = "Todo/Fix/Fixme",
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"NStefan002/screenkey.nvim",
		-- lazy = false,
		version = "*",
		opts = { disable = { buftypes = { "terminal" } } },
		init = function()
			vim.api.nvim_create_autocmd("VimEnter", {
				group = vim.api.nvim_create_augroup("AutostartScreenkey", {}),
				command = "Screenkey toggle",
				desc = "Autostart Screenkey on VimEnter",
			})
		end,
	},
}
