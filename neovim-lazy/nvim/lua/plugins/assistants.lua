vim.cmd([[cab cc CodeCompanion]])
return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"ravitemer/codecompanion-history.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<C-a>",
				"<cmd>CodeCompanionActions<cr>",
				desc = "Code Compaion Actions",
				nowait = true,
				remap = false,
				mode = { "n", "v" },
			},
			{
				"<LocalLeader>aa",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "Code Companion Toggle Chat",
				nowait = true,
				remap = false,
				mode = { "n", "v" },
			},
			{
				"<LocalLeader>ac",
				"<cmd>CodeCompanionActions<cr>",
				desc = "Code Companion Actions",
				nowait = true,
				remap = false,
				mode = { "n", "v" },
			},
			{
				"ga",
				"<cmd>CodeCompanionChat Add<cr>",
				desc = "Code Companion Toggle Chat",
				nowait = true,
				remap = false,
				mode = { "v" },
			},
			{
				"<leader>sa",
				function()
					require("codecompanion").extensions.history.browse_chats()
				end,
				desc = "CodeCompanion History",
			},
			{
				"<leader>ah",
				function()
					require("codecompanion").extensions.history.browse_chats()
				end,
				desc = "CodeCompanion History",
			},
		},
		opts = {
			interactions = {
				inline = { adapter = { name = "opencode_zen", model = "kimi-k2.6" } },
				cmd = { adapter = { name = "opencode_zen", model = "kimi-k2.6" } },
				chat = { adapter = { name = "opencode_zen", model = "kimi-k2.6" } },
				cli = {
					agent = "claude_code",
					agents = {
						claude_code = {
							cmd = "sh",
							args = {
								"-c",
								"ANTHROPIC_API_KEY=$(cat /home/myuser/secrets/ANT_API_KEY.txt) claude",
							},
							description = "Claude Code CLI",
							provider = "terminal",
						},
					},
				},
			},
			display = {
				action_palette = {
					provider = "snacks",
				},
			},
			adapters = {
				acp = {
					opts = { show_presets = false },
					opencode = function()
						return require("codecompanion.adapters").extend("opencode", {})
					end,
				},
				http = {
					opts = { show_presets = false },
					opencode_zen = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							name = "opencode_zen",
							env = {
								api_key = "cmd:cat /home/myuser/secrets/ZEN_API_KEY.txt",
								url = "https://opencode.ai/zen",
								chat_url = "/v1/chat/completions",
								models_endpoint = "/v1/models",
							},
							schema = {
								model = {
									default = "kimi-k2.6",
								},
							},
						})
					end,
					myAnthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "cmd:cat ~/secrets/ANT_API_KEY.txt",
							},
							schema = {
								model = {
									default = "claude-sonnet-4-6",
								},
							},
						})
					end,
				},
			},
			extensions = {
				history = {
					enabled = true,
					opts = {
						chat_filter = function(chat_data)
							return chat_data.cwd == vim.fn.getcwd()
						end,
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
						title_generation_opts = {
							adapter = "opencode_zen",
							model = "big-pickle",
							refresh_every_n_prompts = 5,
							-- max_refreshes = 3,
							format_title = function(original_title)
								local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
								local prefix
								if git_root and git_root ~= "" and not git_root:match("^fatal") then
									prefix = vim.fn.fnamemodify(git_root, ":t")
								else
									prefix = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
								end
								return "[" .. prefix .. "] " .. original_title
							end,
						},
						continue_last_chat = true,
						delete_on_clearing_chat = true,
						summary = {
							generation_opts = {
								adapter = "opencode_zen",
								model = "big-pickle",
							},
						},
					},
				},
			},
		},
		config = true,
	},
	{
		"sudo-tee/opencode.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					anti_conceal = { enabled = false },
					file_types = { "markdown", "opencode_output" },
				},
				ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
			},
			"hrsh7th/nvim-cmp",
			"folke/snacks.nvim",
		},
		config = function()
			require("opencode").setup({
				preferred_picker = snacks,
				default_mode = "plan",
				keymap = {
					input_window = {
						["<C-a>"] = { "toggle_pane", mode = { "n", "i" }, defer_to_completion = true },
						["<tab>"] = { "switch_mode", defer_to_completion = true },
						["<M-m>"] = false,
					},
					output_window = {
						["<C-a>"] = { "toggle_pane", mode = { "n", "i" } },
						["<tab>"] = false,
					},
				},
				ui = {
					input = {
						text = {
							wrap = true,
						},
					},
				},
			})
		end,
	},
}
