vim.cmd([[cab cc CodeCompanion]])
return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
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
		},
		opts = {
			display = {
				action_palette = {
					provider = "snacks",
				},
			},
			adapters = {
				-- Gemini
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = {
							api_key = "cmd:cat ~/secrets/GEMINI_API_KEY.txt",
						},
						schema = {
							model = {
								default = "gemini-2.5-flash-preview-04-17",
							},
						},
					})
				end,
				-- OpenAI
				openai = function()
					return require("codecompanion.adapters").extend("openai", {
						env = {
							api_key = "cmd:cat ~/secrets/OAI_API_KEY.txt",
						},
						schema = {
							model = {
								default = "gpt-4o",
							},
						},
					})
				end,
				-- Llama3
				llama3 = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = "deepseek-r1", -- Give this adapter a different name to differentiate it from the default ollama adapter
						schema = {
							model = {
								default = "deepseek-r1",
							},
						},
					})
				end,
				lmsDevstral = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "http://127.0.0.1:1234", -- optional: default value is ollama url http://127.0.0.1:11434
							api_key = "lm-studio", -- optional: if your endpoint is authenticated
							chat_url = "/v1/chat/completions", -- optional: default value, override if different
							models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
						},
						schema = {
							model = {
								default = "mistralai/devstral-small-2505", -- define llm model to be used
							},
							temperature = {
								order = 2,
								mapping = "parameters",
								type = "number",
								optional = true,
								default = 0.8,
								desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
								validate = function(n)
									return n >= 0 and n <= 2, "Must be between 0 and 2"
								end,
							},
						},
					})
				end,
				lmsQwenCoder = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "http://127.0.0.1:1234", -- optional: default value is ollama url http://127.0.0.1:11434
							api_key = "lm-studio", -- optional: if your endpoint is authenticated
							chat_url = "/v1/chat/completions", -- optional: default value, override if different
							models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
						},
						schema = {
							model = {
								default = "qwen/qwen2.5-coder-14b", -- define llm model to be used
							},
							temperature = {
								order = 2,
								mapping = "parameters",
								type = "number",
								optional = true,
								default = 0.8,
								desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
								validate = function(n)
									return n >= 0 and n <= 2, "Must be between 0 and 2"
								end,
							},
						},
					})
				end,
				lmsCoder = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "http://127.0.0.1:1234", -- optional: default value is ollama url http://127.0.0.1:11434
							api_key = "lm-studio", -- optional: if your endpoint is authenticated
							chat_url = "/v1/chat/completions", -- optional: default value, override if different
							models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
						},
						schema = {
							model = {
								default = "deepseek-coder-v2-lite-instruct-mlx", -- define llm model to be used
							},
							temperature = {
								order = 2,
								mapping = "parameters",
								type = "number",
								optional = true,
								default = 0.8,
								desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
								validate = function(n)
									return n >= 0 and n <= 2, "Must be between 0 and 2"
								end,
							},
						},
					})
				end,
			},
			strategies = {
				--[[ chat = {
					adapter = "ollama",
					keymaps = {
						send = {
							modes = { n = "<C-g>", i = "<C-g>" },
						},
						close = {
							modes = { n = "<C-c>", i = "<C-c>" },
						},
						-- Add further custom keymaps here
					},
				}, ]]
				chat = { adapter = "openai" },
				inline = { adapter = "openai" },
				cmd = { adapter = "openai" },
			},
		},
		config = true,
	},
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("codeium").setup({
				enable_cmp_source = true,
			})
		end,
		event = "BufEnter",
	},
	{
		"monkoose/neocodeium",
		opts = {
			manual = true,
		},
		init = function()
			vim.keymap.set("i", "<A-f>", require("neocodeium").accept)
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		opts = {
			disable_inline_completion = true,
		},
	},
	--[[ {
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>c", group = "ChatGPT", mode = { "n", "v" } },
			{ "<leader>cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT", mode = { "n", "v" } },
			{
				"<leader>ce",
				"<cmd>ChatGPTEditWithInstruction<CR>",
				desc = "ChatGPT Edit with instruction",
				mode = { "n", "v" },
			},
			{
				"<leader>cl",
				"<cmd>ChatGPTCompleteCode<CR>",
				desc = "ChatGPT Comp[l]ete Code",
				mode = { "n", "v" },
			},
			{ "<leader>cr", group = "Run", mode = { "n", "v" } },
			{ "<leader>cra", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
			{ "<leader>crd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
			{ "<leader>crf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
			{
				"<leader>crg",
				"<cmd>ChatGPTRun grammar_correction<CR>",
				desc = "Grammar Correction",
				mode = { "n", "v" },
			},
			{ "<leader>crk", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
			{
				"<leader>crl",
				"<cmd>ChatGPTRun code_readability_analysis<CR>",
				desc = "Code Readability Analysis",
				mode = { "n", "v" },
			},
			{ "<leader>cro", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
			{ "<leader>crr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
			{ "<leader>crs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
			{ "<leader>crt", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
			{ "<leader>crx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
			{ "<leader>cs", "<cmd>ChatGPTActAs<CR>", desc = "ChatGPT Act A[s]", mode = { "n", "v" } },
		},
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "cat " .. vim.fn.expand("$HOME") .. "/secrets/OAI_API_KEY.txt",
				openai_params = {
					model = "gpt-4o",
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			-- "nvim-telescope/telescope.nvim",
		},
	}, ]]
	--[[ {
		"robitx/gp.nvim",
		event = "VeryLazy",
		opts = {
			openai_api_key = { "cat", vim.fn.expand("$HOME") .. "/secrets/OAI_API_KEY.txt" },
			agents = {
				{
					name = "ChatGPT4",
					chat = true,
					command = false,
					model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "Answer any query with just: Sure thing..",
				},
				{
					name = "ChatGPT3-5",
					chat = true,
					command = false,
					model = { model = "gpt-3.5-turbo", temperature = 1.1, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "Answer any query with just: Sure thing..",
				},
				{
					name = "CodeGPT4",
					chat = false,
					command = true,
					model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are an AI working as a code editor.\n\n"
						.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
						.. "START AND END YOUR ANSWER WITH:\n\n```",
				},
				{
					name = "CodeGPT3-5",
					chat = false,
					command = true,
					model = { model = "gpt-3.5-turbo", temperature = 0.8, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are an AI working as a code editor.\n\n"
						.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
						.. "START AND END YOUR ANSWER WITH:\n\n```",
				},
			},
			chat_topic_gen_model = "gpt-4o",
			hooks = {
				-- example of adding command which writes unit tests for the selected code
				UnitTests = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please respond by writing table driven unit tests for the code above."
					local agent = gp.get_command_agent()
					gp.Prompt(params, gp.Target.vnew, agent, template)
				end,
				-- example of adding command which explains the selected code
				Explain = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please respond by explaining the code above."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.popup, agent, template)
				end,
				-- example of usig enew as a function specifying type for the new buffer
				CodeReview = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please analyze for code smells and suggest improvements."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
				end,
			},
		},
	}, ]]
}
