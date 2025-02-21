vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
return {
	"kevinhwang91/nvim-ufo",
	event = "VeryLazy",
	dependencies = "kevinhwang91/promise-async",
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
	},
	config = function(_, opts)
		local ufo = require("ufo")
		ufo.setup(opts)

		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
		-- vim.keymap.set('n', 'K', function()
		--   local winid = ufo.peekFoldedLinesUnderCursor(true)
		--   if not winid then
		--     vim.lsp.buf.hover()
		--   end
		-- end, { desc = 'LSP: Show hover documentation and folded code' })
	end,
}
