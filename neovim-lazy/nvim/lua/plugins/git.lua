return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		-- Only one of these is needed.
		"sindrets/diffview.nvim", -- optional
		-- "esmuellert/codediff.nvim", -- optional

		"m00qek/baleia.nvim", -- optional
	},
	opts = {
		kind = "split",
		mappings = {
			status = { ["<c-s>"] = "StageUnstaged", ["S"] = "StageAll" },
		},
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
	},
}
