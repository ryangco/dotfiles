local set = vim.keymap.set

set("i", "jj", "<ESC>", { silent = true })
set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })
set("n", "<leader>y", '"+y')
set("v", "<leader>y", '"+y')
set("n", "<leader>Y", '"+Y')
set("v", "<S-up>", ":m '<-2<CR>gv=gv")
set("v", "<S-down>", ":m '>+1<CR>gv=gv")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzz")
set("n", "N", "Nzz")

-- osc52 working with stock wezterm
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

-- Colorscheme
set("n", "<leader>ol", function()
	if vim.o.background == "dark" then
		return "<cmd>set background=light<cr>"
	else
		return "<cmd>set background=dark<cr>"
	end
end, { desc = "Togg[l]e Dark Mode", noremap = false, expr = true })
set("n", "<leader>op", function()
	if vim.g.colors_name == "tokyonight" then
		return "<cmd>colorscheme kanagawa<cr>"
	elseif vim.g.colors_name == "kanagawa" then
		return "<cmd>colorscheme catppuccin<cr>"
	elseif vim.g.colors_name == "catppuccin-mocha" then
		return "<cmd>colorscheme github_dark<cr>"
	elseif vim.g.colorscheme == "github_dark" then
		return "<cmd>colorscheme tokyonight<cr>"
	end
end, { desc = "Toggle [P]reSelected Theme", noremap = false, expr = true })

-- Diagnostic keymap
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
set("n", "<C-left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-j>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-k>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-l>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<c-w>+")
set("n", "<M-s>", "<c-w>-")
