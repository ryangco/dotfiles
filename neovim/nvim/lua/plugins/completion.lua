--[[ return {
	"saghen/blink.cmp",
	enabled = true,
	version = "*",
	dependencies = {
		{
			"saghen/blink.compat",
			version = "*",
			lazy = false,
			-- event = "InsertEnter",
			-- opts = { impersonate_nvim_cmp = true, enable_events = true, debug = true },
			init = function()
				require("blink.compat").setup({
					impersonate_nvim_cmp = true,
					enable_events = true,
					debug = true,
				})
			end,
		},
		{
			"L3MON4D3/LuaSnip",
			lazy = true,
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						require("luasnip.loaders.from_vscode").lazy_load({
							paths = { vim.fn.stdpath("config") .. "/snippets" },
						})
					end,
				},
			},
			opts = { history = true, delete_check_events = "TextChanged" },
		},
		{ "dmitmel/cmp-digraphs" },
		{
			"Kaiser-Yang/blink-cmp-dictionary",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "moyiz/blink-emoji.nvim" },
		{
			"supermaven-inc/supermaven-nvim",
		},
		{
			"Exafunction/codeium.nvim",
			event = "BufEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				enable_chat = false,
			},
		},
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},
		snippets = {
			preset = "luasnip",
			-- This comes from the luasnip extra, if you don't add it, won't be able to jump forward or backward in luasnip snippets
			-- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		sources = {
			default = {
				"digraphs",
				"lazydev",
				"codeium",
				"dictionary",
				"lsp",
				"path",
				"snippets",
				"buffer",
				"emoji",
				"supermaven",
			},
			providers = {
				snippets = {
					name = "snippets",
					module = "blink.cmp.sources.snippets",
					opts = {
						use_show_condition = false,
					},
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				buffer = {
					opts = {
						get_bufnrs = vim.api.nvim_list_bufs,
					},
				},
				dictionary = {
					module = "blink-cmp-dictionary",
					name = "Dict",
					min_keyword_length = 3,
					opts = {},
				},
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
					score_offset = 15,
					opts = { insert = true },
				},
				supermaven = {
					name = "supermaven",
					module = "blink.compat.source",
					score_offset = 20,
					opts = {
						disable_inline_completion = true,
						disable_keymaps = true,
					},
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Supermaven"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
				codeium = {
					name = "codeium",
					module = "blink.compat.source",
					score_offset = 20,
					transform_items = function(_, items)
						local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
						local kind_idx = #CompletionItemKind + 1
						CompletionItemKind[kind_idx] = "Codeium"
						for _, item in ipairs(items) do
							item.kind = kind_idx
						end
						return items
					end,
				},
				digraphs = {
					name = "digraphs",
					module = "blink.compat.source",
					score_offset = 2,
					opts = {
						cache_digraphs_on_start = true,
					},
					enabled = function()
						return true
					end,
				},
			},
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			-- trigger = { show_in_snippet = false },
			ghost_text = { enabled = false },
			list = { selection = { auto_insert = false } },
			documentation = { auto_show = true, window = { border = "single" } },
			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
								return kind_icon
							end,
							-- Optionally, you may also use the highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
								return hl
							end,
						},
					},
				},
			},
		},
		appearance = {
			kind_icons = {
				Supermaven = "",
				Codeium = "",
				Text = "󰉿",
				Method = "󰊕",
				Function = "󰊕",
				Constructor = "󰒓",

				Field = "󰜢",
				Variable = "󰆦",
				Property = "󰖷",

				Class = "󱡠",
				Interface = "󱡠",
				Struct = "󱡠",
				Module = "󰅩",

				Unit = "󰪚",
				Value = "󰦨",
				Enum = "󰦨",
				EnumMember = "󰦨",

				Keyword = "󰻾",
				Constant = "󰏿",

				Snippet = "󱄽",
				Color = "󰏘",
				File = "󰈔",
				Reference = "󰬲",
				Folder = "󰉋",
				Event = "󱐋",
				Operator = "󰪚",
				TypeParameter = "󰬛",
			},
		},
		signature = { enabled = true, window = { border = "single" } },
	},
	opts_extend = { "sources.default" },
} ]]

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						require("luasnip").filetype_extend("elixir", { "eelixir" })
						require("luasnip").filetype_extend("ruby", { "rails" })
						require("luasnip").filetype_extend("javascriptreact", { "html" })
						require("luasnip").filetype_extend("typescriptreact", { "html" })
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"uga-rosa/cmp-dictionary",
		"dmitmel/cmp-digraphs",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "codeium" },
				{ name = "supermaven" },
				{ name = "emoji" },
				{ name = "digraphs" },
				{ name = "dictionary", keyword_length = 3 },
				{ name = "lazydev", group_index = 0 },
			},
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<TAB>"] = {
					c = false,
				},
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline", max_item_count = 10 },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline({
				["<TAB>"] = {
					c = false,
				},
			}),
			sources = {
				{ name = "buffer", max_item_count = 10 },
			},
		})
	end,
}
