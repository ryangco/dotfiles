require("noice").setup({
	messages = {
		enabled = true,
	},
	popupmenu = {
		enabled = true,
	},
	notify = {
		enabled = true,
	},
	routes = {
		{
			filter = { event = "msg_show" },
			opts = { skip = false },
		},
		{
			filter = {
				event = "lsp",
				kind = "progress",
				cond = function(message)
					local client = vim.tbl_get(message.opts, "progress", "client")
					return client == "lua_ls"
				end,
			},
			opts = { skip = true },
		},
	},
	cmdline = {
		enabled = true,
		view = "cmdline",
	},
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		progress = {
			enabled = true,
		},
		hover = {
			enabled = true,
		},
		signature = {
			enabled = true,
		},
		message = {
			enabled = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
})
