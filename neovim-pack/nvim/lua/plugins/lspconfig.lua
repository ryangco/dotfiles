-- NOTE: LSP Keybinds
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Helper function to quickly generate fresh options for each keymap
		local function make_opts(desc)
			return { buffer = ev.buf, silent = true, desc = desc }
		end

		vim.keymap.set("n", "gR", function()
			Snacks.picker.lsp_references()
		end, make_opts("Show LSP references"))

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, make_opts("Go to declaration"))

		vim.keymap.set("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, make_opts("Show LSP definitions"))

		vim.keymap.set("n", "gi", function()
			Snacks.picker.lsp_implementations()
		end, make_opts("Show LSP implementations"))

		vim.keymap.set("n", "gt", function()
			Snacks.picker.lsp_type_definitions()
		end, make_opts("Show LSP type definitions"))

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, make_opts("Smart rename"))

		vim.keymap.set("n", "K", vim.lsp.buf.hover, make_opts("Show documentation"))

		vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", make_opts("Restart LSP"))

		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, make_opts("Signature help"))
	end,
})

-- <leader>lx toggle for virtual text (no hover changes)
vim.keymap.set("n", "<leader>lx", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle LSP virtual text" })

-- NOTE: Setup servers
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Global LSP settings (applied to all servers)
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Configure and enable LSP servers
-- lua_ls
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			codeLens = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			},
			-- workspace = {
			--     library = {
			--         [vim.fn.expand("$VIMRUNTIME/lua")] = true,
			--         [vim.fn.stdpath("config") .. "/lua"] = true,
			--     },
			-- },
		},
	},
})

-- marksman (Markdown LSP)
-- vim.lsp.config("marksman", {
-- 	root_markers = { ".git", ".marksman.toml" },
-- 	single_file_support = true,
-- })

-- emmet_language_server
vim.lsp.config("emmet_language_server", {
	filetypes = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"typescriptreact",
	},
	init_options = {
		includeLanguages = {},
		excludeLanguages = {},
		extensionsPath = {},
		preferences = {},
		showAbbreviationSuggestions = true,
		showExpandedAbbreviation = "always",
		showSuggestionsAsSnippets = false,
		syntaxProfiles = {},
		variables = {},
	},
})

-- ts_ls (TypeScript/JavaScript)
vim.lsp.config("ts_ls", {
	workspace_required = false,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	single_file_support = true,
	init_options = {
		preferences = {
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
		},
	},
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayVariableTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "none",
				includeInlayVariableTypeHints = false,
				includeInlayFunctionParameterTypeHints = false,
			},
		},
	},
})

-- gopls
vim.lsp.config("gopls", {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

-- css
vim.lsp.config("cssls", {
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true },
	single_file_support = true,
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
			validate = true,
		},
		scss = {
			lint = {
				unknownAtRules = "ignore",
			},
			validate = true,
		},
		less = {
			lint = {
				unknownAtRules = "ignore",
			},
			validate = true,
		},
	},
})

-- tailwind
vim.lsp.config("tailwindcss", {
	filetypes = {
		"html",
		"css",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"svelte",
		"vue",
		"astro",
	},
	init_options = {
		userLanguages = {
			astro = "html",
		},
	},
})

vim.lsp.config("astro", {
	filetypes = { "astro" },
	init_options = {
		typescript = {
			tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
		},
	},
})
