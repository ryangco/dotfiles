require("lsp-progress").setup({})
require("lualine").setup({
	options = {
		refresh = { statusline = 230 },
		theme = "auto",
		always_divide_middle = false,
	},
	sections = {
		lualine_a = {},
		lualine_b = {
			"branch",
			{
				"diff",
				diff_color = {
					added = { fg = "lime" },
					modified = { fg = "orange" },
					removed = { fg = "fuchsia" },
				},
			},
		},
		lualine_c = {
			{
				function()
					local progress = require("lsp-progress").progress({
						format = function(client_messages)
							local sign = ""
							if #client_messages > 0 then
								return sign .. " " .. table.concat(client_messages, " ")
							end
							return ""
						end,
					})
					if progress == "" then
						return vim.fn.expand("%:t")
					else
						return progress
					end
				end,
			},
			{
				function()
					local recording_register = vim.fn.reg_recording()
					if recording_register == "" then
						return ""
					else
						return "@" .. recording_register
					end
				end,
			},
		},
		lualine_x = {
			{
				"buffers",
				icons_enabled = false,
				show_filename_only = true,
				hide_filename_extension = true,
				show_modified_status = true,
				max_length = vim.o.columns * 45 / 100,
				symbols = {
					modified = "●",
					alternate_file = "󰓢",
					directory = "",
				},
				buffers_color = {
					active = { fg = "cyan" },
					inactive = { fg = "#808080" },
				},
				cond = function()
					return vim.api.nvim_win_get_width(0) > 80
				end,
			},
			{
				"diagnostics",
				sources = {
					"nvim_diagnostic",
					"nvim_lsp",
				},
				sections = { "error", "warn", "info", "hint" },
				diagnostics_color = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
				},
				symbols = { error = "E", warn = "W", info = "I", hint = "H" },
				colored = true,
				update_in_insert = false,
				always_visible = false,
			},
		},
		lualine_z = {
			{
				"location",
				cond = function()
					if vim.fn.mode() == "n" then
						return true
					end
				end,
			},
			{
				"mode",
				fmt = function(str)
					if str == "NORMAL" then
						return {}
					elseif str == "V-BLOCK" then
						return "VB"
					elseif str == "V-LINE" then
						return "VL"
					else
						return str:sub(1, 1)
					end
				end,
			},
		},
	},
	winbar = {
		lualine_c = {
			{
				"buffers",
				icons_enabled = false,
				show_filename_only = true,
				hide_filename_extension = false,
				show_modified_status = true,
				max_length = vim.o.columns * 100 / 100,
				symbols = {
					modified = "●",
					alternate_file = "󰓢",
					directory = "",
				},
				buffers_color = {
					active = { fg = "cyan", bg = "#000000" },
					inactive = { fg = "#808080", bg = "#000000" },
				},
				cond = function()
					return vim.api.nvim_win_get_width(0) < 80
				end,
			},
		},
	},
})
if vim.env.TMUX then
	vim.api.nvim_create_autocmd({ "FocusGained", "ColorScheme" }, {
		callback = function()
			vim.defer_fn(function()
				vim.opt.laststatus = 0
			end, 100)
		end,
	})

	vim.o.laststatus = 0
end
