---@diagnostic disable: undefined-field
-- vim.deprecate = function() end
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.diagnostic.config({ underline = false })

require("lazy").setup({ import = "plugins" })
require("autocmds")
require("options")
require("terminal")
require("keymaps")
