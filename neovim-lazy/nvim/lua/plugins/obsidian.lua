return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = "VeryLazy",
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		init = function()
			-- Obsidian
			vim.keymap.set("n", "gf", function()
				if require("obsidian").util.cursor_on_markdown_link() then
					return "<cmd>ObsidianFollowLink<CR>"
				else
					return "gf"
				end
			end, { noremap = false, expr = true })
		end,
		keys = {
			{ "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New Obsidian note", mode = "n" },
			-- { "<leader>oo", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian notes", mode = "n" },
			{
				"<leader>no",
				function()
					Snacks.picker.pick("grep", {
						cwd = "~/Obsidian/",
						actions = {
							create_note = function(picker, item)
								picker:close()
								vim.cmd("ObsidianNew " .. picker.finder.filter.search)
							end,
						},
						win = {
							input = {
								keys = {
									["<c-x>"] = { "create_note", desc = "Create new note", mode = { "i", "n" } },
								},
							},
						},
					})
				end,
				desc = "Search Obsidian notes",
				mode = "n",
			},
			{ "<leader>ns", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch", mode = "n" },
			{ "<leader>nb", "<cmd>ObsidianBacklinks<cr>", desc = "Show location list of backlinks", mode = "n" },
			{ "<leader>nt", "<cmd>ObsidianTemplate<cr>", desc = "Templates", mode = "n" },
			{ "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Todays daily note", mode = "n" },
			{ "<leader>ny", "<cmd>ObsidianYesterday<cr>", desc = "Yesterdays daily note", mode = "n" },
		},
		opts = {
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

			--[[ note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end, ]]

			mappings = {
				-- Toggle check-boxes.
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
				["<leader>nat"] = {
					action = function()
						return require("obsidian").util.insert_template("Newsletter-Issue")
					end,
					opts = { buffer = true },
				},
			},
		},
	},
}
