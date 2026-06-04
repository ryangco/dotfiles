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
			["@variable.builtin"] = { italic = false },
			["@lsp.mod.defaultLibrary"] = { italic = false },
			["@lsp.typemod.variable.defaultLibrary"] = { italic = false },
		}
	end,
})

require("nightfox").setup({
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
})

vim.cmd("colorscheme ex-carbonfox")
