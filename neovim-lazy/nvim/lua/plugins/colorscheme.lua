return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		-- priority = 1000,
		opts = {
			on_colors = function(colors)
				colors.bg = "#000000"
				colors.bg_dark = "#000000"
			end,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				functions = { italic = false },
				variables = { italic = false },
			},
		},
	},
	{
		"rose-pine/neovim",
		lazy = true,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				disable_float_background = true,
				styles = {
					bold = false,
					italic = false,
				},
			})
		end,
	},
	{
		"ryangco/github-nvim-theme",
		lazy = true,
		config = function()
			require("github-theme").setup({})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			palette = {
				sumiInk0 = "#000000",
			},
			transparent = true,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			commentStyle = { italic = false },
			statementStyle = { bold = false },
			keywordStyle = { italic = false },
			functionStyle = { bold = false },
			typeStyle = { bold = false },
			booleans = { bold = true },
			semanticFunctions = { bold = true },
			stringEscapes = { bold = true },
			overrides = function()
				return {
					Boolean = { bold = false },
					["@lsp.typemod.function.readonly"] = { bold = false },
				}
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {
			no_italic = true,
			no_bold = true,
			color_overrides = {
				mocha = {
					base = "#000000",
				},
			},
		},
		init = function()
			vim.cmd("colorscheme catppuccin")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		opts = {
			palettes = {
				nightfox = { bg1 = "#000000" },
				carbonfox = { bg1 = "#000000" },
				duskfox = { bg1 = "#000000" },
				nordfox = { bg1 = "#000000" },
				terafox = { bg1 = "#000000" },
			},
			groups = {
				all = {
					["@markup.link.url"] = { style = "underline" },
					["@markup.raw"] = { style = "NONE" },
					["@string.special.url"] = { style = "underline" },
					["@tag.attribute"] = { style = "NONE" },
				},
			},
		},
	},
}
