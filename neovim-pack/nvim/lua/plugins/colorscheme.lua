require("kanagawa").setup({
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
})

vim.cmd("colorscheme kanagawa")
