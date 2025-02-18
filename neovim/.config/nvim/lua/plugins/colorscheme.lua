return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
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
		opts = {
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
			colors = {
				palette = {
					sumiInk3 = "#000000",
					sumiInk4 = "#000000",
					dragonBlack3 = "#000000",
					dragonBlack4 = "#000000",
				},
			},
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
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		config = function()
			require("nightfox").setup({
				palettes = {
					nightfox = {
						bg1 = "#000000",
					},
					carbonfox = {
						bg1 = "#000000",
					},
				},
			})
		end,
	},
}
