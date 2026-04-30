local ts = require("nvim-treesitter")

-- Install parsers
local parsers = {
	"bash",
	"c",
	"html",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"vim",
	"vimdoc",
	"javascript",
	"typescript",
	"tsx",
	"css",
	"go",
	"regex",
}

pcall(ts.install, parsers)

-- Auto-enable treesitter highlighting per filetype
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Re-run installs after vim.pack updates
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" then
			pcall(ts.install, parsers)
		end
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v",
			["@function.outer"] = "V",
			["@class.outer"] = "V",
		},
		include_surrounding_whitespace = false,
	},
})

-- Select keymaps
local sel = require("nvim-treesitter-textobjects.select")
local sel_map = function(key, query)
	vim.keymap.set({ "x", "o" }, key, function()
		sel.select_textobject(query, "textobjects")
	end)
end

sel_map("aa", "@parameter.outer")
sel_map("ia", "@parameter.inner")
sel_map("af", "@function.outer")
sel_map("if", "@function.inner")
sel_map("ac", "@class.outer")
sel_map("ic", "@class.inner")
sel_map("ai", "@conditional.outer")
sel_map("ii", "@conditional.inner")
sel_map("al", "@loop.outer")
sel_map("il", "@loop.inner")
sel_map("at", "@comment.outer")

-- Move keymaps
local move = require("nvim-treesitter-textobjects.move")
local move_map = function(key, fn, query)
	vim.keymap.set({ "n", "x", "o" }, key, function()
		move[fn](query, "textobjects")
	end)
end

move_map("]m", "goto_next_start", "@function.outer")
move_map("]M", "goto_next_end", "@function.outer")
move_map("][", "goto_next_end", "@class.outer")
move_map("[m", "goto_previous_start", "@function.outer")
move_map("[M", "goto_previous_end", "@function.outer")
move_map("[]", "goto_previous_end", "@class.outer")
move_map("]i", "goto_next", "@conditional.inner")
move_map("[i", "goto_previous", "@conditional.inner")

-- Swap keymaps
local swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "<leader>na", function()
	swap.swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>nf", function()
	swap.swap_next("@function.outer")
end)
vim.keymap.set("n", "<leader>pa", function()
	swap.swap_previous("@parameter.inner")
end)
vim.keymap.set("n", "<leader>pf", function()
	swap.swap_previous("@function.outer")
end)
