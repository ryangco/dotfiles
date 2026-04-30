vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require("auto-session").setup({
	session_lens = {
		mappings = {
			delete_session = { "i", "<C-D>" },
			alternate_session = { "i", "<C-S>" },
			copy_session = { "i", "<C-Y>" },
		},
	},
})
vim.keymap.set("n", "<leader>lc", "<CMD>SessionDelete<CR>", { desc = "[C]lose Current Session" })
vim.keymap.set("n", "<leader>wr", "<cmd>SessionSearch<CR>", { desc = "Session search" })
vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", { desc = "Toggle autosave" })
