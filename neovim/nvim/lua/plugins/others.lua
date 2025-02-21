return {
	{
		"aileot/ex-colors.nvim",
		lazy = true,
		cmd = "ExColors",
		---@type ExColors.Config
		opts = {},
		config = function()
			-- Please arrange the patterns for your favorite plugins by yourself.
			require("ex-colors").setup({
				-- included_patterns = require("ex-colors.presets").recommended.included_patterns + {
				--   "^Cmp%u", -- hrsh7th/nvim-cmp
				--   '^GitSigns%u', -- lewis6991/gitsigns.nvim
				--   '^RainbowDelimiter%u', -- HiPhish/rainbow-delimiters.nvim
				-- },
				autocmd_patterns = {
					CmdlineEnter = {
						["*"] = {
							"^debug%u",
							"^health%u",
						},
					},
					-- FileType = {
					--   ['Telescope*'] = {
					--     '^Telescope%u', -- nvim-telescope/telescope.nvim
					--   },
					-- },
				},
			})
		end,
	},
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
			vim.keymap.set("n", "<leader>tsk", function()
				vim.cmd("Screenkey toggle")
			end, { desc = "[T]oggle [S]creen[K]ey" })
		end,
	},
}
