return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			-- ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
			["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
		})
		-- visual mode
		require("which-key").register({
			["<leader>h"] = { "Git [H]unk" },
		}, { mode = "v" })

		-- NOTE: ChatGPT.nvim
		require("which-key").register({
			["<leader>c"] = {
				name = "ChatGPT",
				c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
				e = { "<cmd>ChatGPTEditWithInstruction<CR>", "ChatGPT Edit with instruction" },
				s = { "<cmd>ChatGPTActAs<CR>", "ChatGPT Act A[s]" },
				l = { "<cmd>ChatGPTCompleteCode<CR>", "ChatGPT Comp[l]ete Code" },
				r = {
					name = "Run",
					r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
					g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
					t = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
					k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
					d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
					a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
					o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
					s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
					f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
					x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
					l = {
						"<cmd>ChatGPTRun code_readability_analysis<CR>",
						"Code Readability Analysis",
					},
				},
			},
		}, { mode = { "n", "v" } })

		-- NOTE: GP.nvim
		-- VISUAL mode mappings
		-- s, x, v modes are handled the same way by which_key
		require("which-key").register({
			["<leader>g"] = {
				h = {
					name = "Custom [H]ooks",
					u = { ":<C-u>'<,'>GpUnitTests<cr>", "Visual Unit Tests" },
					e = { ":<C-u>'<,'>GpExplain<cr>", "Visual Explain" },
					r = { ":<C-u>'<,'>GpCodeReview<cr>", "Visual Code Review" },
				},
				c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
				p = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
				t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },

				["<C-x>"] = { ":<C-u>'<,'>GpChatNew split<cr>", "Visual Chat New split" },
				["<C-v>"] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", "Visual Chat New vsplit" },
				["<C-t>"] = { ":<C-u>'<,'>GpChatNew tabnew<cr>", "Visual Chat New tabnew" },

				r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
				a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append (after)" },
				b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend (before)" },
				i = { ":<C-u>'<,'>GpImplement<cr>", "Implement selection" },

				g = {
					name = "generate into new ..",
					p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
					e = { ":<C-u>'<,'>GpEnew<cr>", "Visual GpEnew" },
					n = { ":<C-u>'<,'>GpNew<cr>", "Visual GpNew" },
					v = { ":<C-u>'<,'>GpVnew<cr>", "Visual GpVnew" },
					t = { ":<C-u>'<,'>GpTabnew<cr>", "Visual GpTabnew" },
				},

				n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
				s = { "<cmd>GpStop<cr>", "GpStop" },
				x = { ":<C-u>'<,'>GpContext<cr>", "Visual GpContext" },

				w = {
					name = "Whisper",
					w = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
					r = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Rewrite" },
					a = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Append (after)" },
					b = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
					p = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Popup" },
					e = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Enew" },
					n = { ":<C-u>'<,'>GpWhisperNew<cr>", "Whisper New" },
					v = { ":<C-u>'<,'>GpWhisperVnew<cr>", "Whisper Vnew" },
					t = { ":<C-u>'<,'>GpWhisperTabnew<cr>", "Whisper Tabnew" },
				},
			},
		}, {
			mode = "v",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})

		-- NORMAL mode mappings
		require("which-key").register({
			["<leader>g"] = {
				h = {
					name = "Custom [H]ooks",
					u = { "<cmd>GpUnitTests<cr>", "Unit Tests" },
					e = { "<cmd>GpExplain<cr>", "Explain" },
					r = { "<cmd>GpCodeReview<cr>", "Code Review" },
					w = { "<cmd>GpBufferChatNew<cr>", "[W]hole Buffer Context" },
				},
				c = { "<cmd>GpChatNew<cr>", "New Chat" },
				t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
				f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

				["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
				["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
				["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

				r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
				a = { "<cmd>GpAppend<cr>", "Append (after)" },
				b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

				g = {
					name = "generate into new ..",
					p = { "<cmd>GpPopup<cr>", "Popup" },
					e = { "<cmd>GpEnew<cr>", "GpEnew" },
					n = { "<cmd>GpNew<cr>", "GpNew" },
					v = { "<cmd>GpVnew<cr>", "GpVnew" },
					t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
				},

				n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
				s = { "<cmd>GpStop<cr>", "GpStop" },
				x = { "<cmd>GpContext<cr>", "Toggle GpContext" },

				w = {
					name = "Whisper",
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
					b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
					p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
					e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
					v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
					t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
				},
			},
		}, {
			mode = "n",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})

		-- INSERT mode mappings
		require("which-key").register({
			["<C-g>"] = {
				h = {
					name = "Custom [H]ooks",
					u = { "<cmd>GpUnitTests<cr>", "Unit Tests" },
					e = { "<cmd>GpExplain<cr>", "Explain" },
					r = { "<cmd>GpCodeReview<cr>", "Code Review" },
					w = { "<cmd>GpBufferChatNew<cr>", "[W]hole Buffer Context" },
				},
				c = { "<cmd>GpChatNew<cr>", "New Chat" },
				t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
				f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

				["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
				["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
				["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

				r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
				a = { "<cmd>GpAppend<cr>", "Append (after)" },
				b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

				g = {
					name = "generate into new ..",
					p = { "<cmd>GpPopup<cr>", "Popup" },
					e = { "<cmd>GpEnew<cr>", "GpEnew" },
					n = { "<cmd>GpNew<cr>", "GpNew" },
					v = { "<cmd>GpVnew<cr>", "GpVnew" },
					t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
				},

				x = { "<cmd>GpContext<cr>", "Toggle GpContext" },
				s = { "<cmd>GpStop<cr>", "GpStop" },
				n = { "<cmd>GpNextAgent<cr>", "Next Agent" },

				w = {
					name = "Whisper",
					w = { "<cmd>GpWhisper<cr>", "Whisper" },
					r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
					a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
					b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
					p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
					e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
					n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
					v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
					t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
				},
			},
		}, {
			mode = "i",
			prefix = "",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})
	end,
}
