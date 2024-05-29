return {
	"robitx/gp.nvim",
	event = "VeryLazy",
	opts = {
		openai_api_key = { "cat", "/home/gie/secrets/OAI_API_KEY.txt" },
		agents = {
			{
				name = "ChatGPT4",
				chat = true,
				command = false,
				-- string with model name or table with model name and parameters
				model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
				-- system prompt (use this to specify the persona/role of the AI)
				system_prompt = "You are a general AI assistant.\n\n"
					.. "The user provided the additional info about how they would like you to respond:\n\n"
					-- .. "- If you're unsure don't guess and say you don't know instead.\n"
					-- .. "- Ask question if you need clarification to provide better answer.\n"
					.. "- Think deeply and carefully from first principles step by step.\n"
					.. "- Zoom out first to see the big picture and then zoom in to details.\n"
					.. "- Use Socratic method to improve your thinking and coding skills.\n"
					.. "- Don't elide any code from your output if the answer requires coding.\n"
					.. "- Take a deep breath; You've got this!\n",
			},
			{
				name = "ChatGPT3-5",
				chat = true,
				command = false,
				-- string with model name or table with model name and parameters
				model = { model = "gpt-3.5-turbo", temperature = 1.1, top_p = 1 },
				-- system prompt (use this to specify the persona/role of the AI)
				system_prompt = "You are a general AI assistant.\n\n"
					.. "The user provided the additional info about how they would like you to respond:\n\n"
					-- .. "- If you're unsure don't guess and say you don't know instead.\n"
					-- .. "- Ask question if you need clarification to provide better answer.\n"
					.. "- Think deeply and carefully from first principles step by step.\n"
					.. "- Zoom out first to see the big picture and then zoom in to details.\n"
					.. "- Use Socratic method to improve your thinking and coding skills.\n"
					.. "- Don't elide any code from your output if the answer requires coding.\n"
					.. "- Take a deep breath; You've got this!\n",
			},
			{
				name = "CodeGPT4",
				chat = false,
				command = true,
				-- string with model name or table with model name and parameters
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
				-- string with model name or table with model name and parameters
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
}
