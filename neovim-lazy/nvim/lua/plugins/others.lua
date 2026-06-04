return {
	{
		"aileot/ex-colors.nvim",
		lazy = true,
		cmd = "ExColors",
		---@type ExColors.Config
		opts = {
			autocmd_patterns = {
				CmdlineEnter = {
					["*"] = {
						"^debug%u",
						"^health%u",
					},
				},
			},
		},
	},
	-- { "tpope/vim-sleuth" },
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		event = "BufReadPost",
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
			vim.keymap.set("n", "<leader>uk", function()
				vim.cmd("Screenkey toggle")
			end, { desc = "Toggle Screen[K]ey" })
		end,
	},
	{ "vimpostor/vim-tpipeline" },
}
