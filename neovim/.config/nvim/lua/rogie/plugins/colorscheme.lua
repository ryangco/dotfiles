return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("kanagawa").setup({
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
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = {
			style = "night",
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
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
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
}
