return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
		vim.g.db_ui_show_database_icon = true
		vim.g.db_ui_use_nvim_notify = true
		vim.g.db_ui_execute_on_save = false
		vim.g.dbs = {
			{ name = "rgs_system_local", url = "postgresql://localhost:5432/rgs_system_local?sslmode=disable" },
		}

		vim.keymap.set("n", "<leader>Du", "<cmd>DBUIToggle<cr>", { desc = "Toggle DBUI" })
		vim.keymap.set("n", "<leader>Dt", "<cmd>tab DBUI<cr>", { desc = "Open DBUI in new tab" })
		vim.keymap.set("n", "<leader>Df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find Buffer in DBUI" })
		vim.keymap.set("n", "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Rename Buffer in DBUI" })
		vim.keymap.set("n", "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", { desc = "Last Query Info" })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				require("cmp").setup.buffer({
					sources = {
						{ name = "vim-dadbod-completion" },
						{ name = "buffer" },
					},
				})
			end,
		})
	end,
}
