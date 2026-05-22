require("ex-colors").setup({
	included_patterns = require("ex-colors.presets").recommended.included_patterns + {
		"^Cmp%u", -- hrsh7th/nvim-cmp
		"^GitSigns%u", -- lewis6991/gitsigns.nvim
		"^RainbowDelimiter%u", -- HiPhish/rainbow-delimiters.nvim
	},
	autocmd_patterns = {
		CmdlineEnter = {
			["*"] = {
				"^debug%u",
				"^health%u",
			},
		},
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
