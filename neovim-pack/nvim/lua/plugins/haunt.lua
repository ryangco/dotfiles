local ok, haunt = pcall(require, "haunt.api")
if not ok then
	return
end

local haunt_picker = require("haunt.picker")

require("haunt").setup({
	sign = "󱙝",
	sign_hl = "DiagnosticInfo",
	virt_text_hl = "HauntAnnotation",
	annotation_prefix = " 󰆉 ",
	annotation_suffix = "",
	line_hl = nil,
	virt_text_pos = "right_align",
	data_dir = vim.fn.expand("~/haunt-bookmarks/"),
	per_branch_bookmarks = true,
	picker = "snacks",
	picker_keys = {
		delete = { key = "d", mode = { "n" } },
		edit_annotation = { key = "a", mode = { "n" } },
	},
})

local haunt_sync_timer = vim.uv.new_timer()
haunt_sync_timer:start(10 * 60 * 1000, 10 * 60 * 1000, function()
	local dir = vim.fn.expand("~/haunt-bookmarks")
	vim.system({
		"bash",
		"-c",
		string.format(
			"cd %s && git pull --rebase && git add -A && git diff --cached --quiet || git commit -m 'sync' && git push",
			dir
		),
	}, { text = true }, function(result)
		vim.schedule(function()
			if result.code ~= 0 then
				vim.notify("Haunt auto-sync failed:\n" .. result.stderr, vim.log.levels.WARN)
			end
		end)
	end)
end)

local map = vim.keymap.set
local p = "<leader>h"

-- annotations
map("n", p .. "s", function()
	local dir = vim.fn.expand("~/haunt-bookmarks")
	vim.notify("Haunt syncing...", vim.log.levels.INFO)
	vim.system({
		"bash",
		"-c",
		string.format("cd %s && git add -A && git diff --cached --quiet || git commit -m 'sync' && git push", dir),
	}, { text = true }, function(result)
		vim.schedule(function()
			if result.code == 0 then
				vim.notify("Haunt synced", vim.log.levels.INFO)
			else
				vim.notify("Haunt sync failed:\n" .. result.stderr, vim.log.levels.ERROR)
			end
		end)
	end)
end, { desc = "Haunt: Sync" })
map("n", p .. "a", haunt.annotate, { desc = "Haunt: Annotate" })
map("n", p .. "t", haunt.toggle_annotation, { desc = "Haunt: Toggle annotation" })
map("n", p .. "T", haunt.toggle_all_lines, { desc = "Haunt: Toggle all annotations" })
map("n", p .. "d", haunt.delete, { desc = "Haunt: Delete bookmark" })
map("n", p .. "C", haunt.clear_all, { desc = "Haunt: Delete all bookmarks" })

-- move
map("n", p .. "p", haunt.prev, { desc = "Haunt: Previous bookmark" })
map("n", p .. "n", haunt.next, { desc = "Haunt: Next bookmark" })

-- picker
map("n", p .. "l", haunt_picker.show, { desc = "Haunt: Show picker" })
map("n", "<leader>sh", haunt_picker.show, { desc = "Haunt: Show picker" })

-- quickfix
map("n", p .. "q", haunt.to_quickfix, { desc = "Haunt: QF list (all)" })
map("n", p .. "Q", function()
	haunt.to_quickfix({ current_buffer = true })
end, { desc = "Haunt: QF list (buffer)" })

-- yank
map("n", p .. "y", function()
	haunt.yank_locations({ current_buffer = true })
end, { desc = "Haunt: Yank (buffer)" })
map("n", p .. "Y", haunt.yank_locations, { desc = "Haunt: Yank (all)" })
