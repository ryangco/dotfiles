vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/olimorris/codecompanion.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	-- cmp sources
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/hrsh7th/cmp-emoji" },
	{ src = "https://github.com/uga-rosa/cmp-dictionary" },
	{ src = "https://github.com/dmitmel/cmp-digraphs" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	-- cmp snippets
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	-- cmp engine (last)
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/kawre/leetcode.nvim" },
	{ src = "https://github.com/linrongbin16/lsp-progress.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/aileot/ex-colors.nvim" },
	{ src = "https://github.com/tpope/vim-sleuth" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/NStefan002/screenkey.nvim" },
	{ src = "https://github.com/m4xshen/hardtime.nvim" },
	{ src = "https://github.com/rmagatti/auto-session" },
	{ src = "https://github.com/kevinhwang91/nvim-ufo" },
	{ src = "https://github.com/kevinhwang91/promise-async" },
	{ src = "https://github.com/olrtg/nvim-emmet" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/NvChad/nvim-colorizer.lua" },
})

require("plugins.colorscheme")
require("plugins.snacks")
require("plugins.which-key")
require("plugins.assistants")
require("plugins.lspconfig")
require("plugins.mason-lsp")
require("plugins.completion")
require("plugins.autopairs")
require("plugins.conform")
require("plugins.flash")
require("plugins.gitsigns")
require("plugins.treesitter")
require("plugins.leetcode")
require("plugins.lualine")
require("plugins.mini")
require("plugins.others")
require("plugins.sessions")
require("plugins.ufo")
require("plugins.emmet")
require("plugins.render-markdown")
require("plugins.colorizer")

-- Custom packer commands
-- NOTE: pack add
vim.api.nvim_create_user_command("PackAdd", function(opts)
	vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (PackAdd user/repo)" })

-- NOTE: pack update
vim.api.nvim_create_user_command("PackUpdate", function(opts)
	if opts.args ~= "" then
		-- update specific plugins
		local plugins = vim.split(opts.args, "%s+", { trimempty = true })
		vim.pack.update(plugins)
	else
		-- update all
		vim.pack.update()
	end
end, { desc = "Update all plugins or specific ones", nargs = "*" })

-- NOTE: pack del
vim.api.nvim_create_user_command("PackDel", function(opts)
	vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (space separated)" })

-- NOTE: pack nonactive - show all non active plugins on disk but removed from pack.lua
vim.api.nvim_create_user_command("PackCheck", function()
	local non_active = vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable()

	if #non_active == 0 then
		vim.notify("🆗 No non-active plugins found!", vim.log.levels.INFO)
		return
	end

	vim.print("😴 Non-active plugins :")
	print(" ")
	-- vim.print(non_active)
	for _, name in ipairs(non_active) do
		print(name)
	end

	print(" ")

	local choice = vim.fn.confirm(
		"Delete ALL non-active plugins from disk?",
		"&Yes\n&No",
		2 -- default = No
	)

	if choice == 1 then
		vim.pack.del(non_active)
		vim.notify("🗑️  Deleted " .. #non_active .. " non-active plugin(s)", vim.log.levels.INFO)
		print("Non-active plugins deleted!")
		vim.api.nvim_exec_autocmds("User", { pattern = "PackChanged" })
	else
		vim.notify("Cancelled. No plugins were deleted!", vim.log.levels.INFO)
	end
end, { desc = "List non active plugins and select to delete" })
