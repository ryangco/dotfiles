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

-- require("vim-sleuth").setup({})

require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

require("todo-comments").setup({
	signs = true,
})
vim.keymap.set("n", "<leader>st", function()
	Snacks.picker.todo_comments()
end, { desc = "Todo" })
vim.keymap.set("n", "<leader>sT", function()
	Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
end, { desc = "Todo/Fix/Fixme" })

require("nvim-ts-autotag").setup({})

require("screenkey").setup({
	disable = { buftypes = { "terminal" } },
})
vim.keymap.set("n", "<leader>uk", function()
	vim.cmd("Screenkey toggle")
end, { desc = "Toggle Screen[K]ey" })

require("hardtime").setup({
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
})
