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
			vim.keymap.set("n", "<leader>uk", function()
				vim.cmd("Screenkey toggle")
			end, { desc = "Toggle Screen[K]ey" })
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			restrict_mode = "hint",
			restricted_keys = {
				["<Up>"] = { "n", "x" },
				["<Down>"] = { "n", "x" },
				["<Left>"] = { "n", "x" },
				["<Right>"] = { "n", "x" },
				h = false,
				j = false,
				k = false,
				l = false,
			},
			disabled_keys = {
				["<Up>"] = false,
				["<Down>"] = false,
				["<Left>"] = false,
				["<Right>"] = false,
			},
			-- hints = {
			-- 	["<Up>"] = {
			-- 		message = function()
			-- 			return "Use [count]k or CTRL-U to scroll up."
			-- 		end,
			-- 		length = 2,
			-- 	},
			-- 	["<Down>"] = {
			-- 		message = function()
			-- 			return "Use [count]j or CTRL-D to scroll down."
			-- 		end,
			-- 		length = 2,
			-- 	},
			-- 	["<Left>"] = {
			-- 		message = function()
			-- 			return "Use b/B/ge/gE/F/T/0 to move left."
			-- 		end,
			-- 		length = 2,
			-- 	},
			-- 	["<Right>"] = {
			-- 		message = function()
			-- 			return "Use w/W/e/E/f/t/$ to move right."
			-- 		end,
			-- 		length = 2,
			-- 	},
			-- }
		}

	},
}
