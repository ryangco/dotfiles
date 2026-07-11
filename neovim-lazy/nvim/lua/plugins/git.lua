return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"sindrets/diffview.nvim",
			"m00qek/baleia.nvim",
		},
		opts = {
			kind = "replace",
			commit_editor = { kind = "replace" },
			commit_select_view = { kind = "replace" },
			log_view = { kind = "replace" },
			reflog_view = { kind = "replace" },
			stash = { kind = "replace" },
			refs_view = { kind = "replace" },
			mappings = {
				status = { ["<c-s>"] = "StageUnstaged", ["S"] = "StageAll" },
			},
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			numhl = true,
			word_diff = true,
			current_line_blame_opts = {
				virt_text_pos = "overlay",
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "  Jump to next [g]it change" })

				map("n", "[g", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "  Jump to previous [g]it change" })

				-- Visual mode
				map("v", "<leader>ga", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "  Stage git hunk" })
				map("v", "<leader>gx", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "  Reset git hunk" })

				-- Normal mode
				map("n", "<leader>ga", gitsigns.stage_hunk, { desc = "  Stage Hunk" })
				map("n", "<leader>gx", gitsigns.reset_hunk, { desc = "  Reset Hunk" })
				map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "  Stage Buffer" })
				map("n", "<leader>gX", gitsigns.reset_buffer, { desc = "  Reset Buffer" })
				map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "  Preview Hunk" })
				map("n", "<leader>gP", gitsigns.preview_hunk_inline, { desc = "  Preview Hunk Inline" })
				map("n", "<leader>gi", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "  Blame Line" })
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "  Diff Index" })
				map("n", "<leader>gD", function()
					gitsigns.diffthis("~")
				end, { desc = "  Diff Index" })

				map("n", "<leader>ge", function()
					gitsigns.diffthis("@")
				end, { desc = "  Diff Last Commit" })

				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
				map("n", "<leader>tw", gitsigns.toggle_word_diff)
				-- Text object
				map({ "o", "x" }, "ih", gitsigns.select_hunk)
			end,
		},
	},
}
