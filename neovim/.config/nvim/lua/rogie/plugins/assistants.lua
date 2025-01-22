return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
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
			"nvim-telescope/telescope.nvim",
		},
	},
	{
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
					gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
				end,

				-- example of adding command which explains the selected code
				Explain = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please respond by explaining the code above."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
				end,

				-- example of usig enew as a function specifying type for the new buffer
				CodeReview = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Please analyze for code smells and suggest improvements."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.enew("markdown"), nil, agent.model, template, agent.system_prompt)
				end,

				-- example of making :%GpChatNew a dedicated command which
				-- opens new chat with the entire current buffer as a context
				BufferChatNew = function(gp, _)
					-- call GpChatNew command in range mode on whole buffer
					vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
				end,
			},
		},
	},
}
