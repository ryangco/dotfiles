require("obsidian").setup({
	workspaces = {
		{
			name = "ObsidianVault",
			path = "~/Obsidian/Vault/",
		},
	},
	notes_subdir = "notes",
	new_notes_location = "notes",
	daily_notes = {
		folder = "daily_notes",
	},
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	disable_frontmatter = true,
	templates = {
		subdir = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M:%S",
	},
	wiki_link_func = function(opts)
		if opts.id == nil then
			return string.format("[[%s]]", opts.label)
		elseif opts.label ~= opts.id then
			return string.format("[[%s|%s]]", opts.id, opts.label)
		else
			return string.format("[[%s]]", opts.id)
		end
	end,
	mappings = {
		["<leader>ch"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
		["<cr>"] = {
			action = function()
				return require("obsidian").util.smart_action()
			end,
			opts = { buffer = true, expr = true },
		},
		["<leader>ont"] = {
			action = function()
				return require("obsidian").util.insert_template("Newsletter-Issue")
			end,
			opts = { buffer = true },
		},
	},
})

-- keymaps
vim.keymap.set("n", "gf", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })

vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New Obsidian note" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian notes" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick Switch" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show location list of backlinks" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Templates" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Todays daily note" })
vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Yesterdays daily note" })
