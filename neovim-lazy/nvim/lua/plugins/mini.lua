return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.bracketed").setup()
		require("mini.icons").setup()
		require("mini.snippets").setup()
		require("mini.move").setup()
	end,
}
