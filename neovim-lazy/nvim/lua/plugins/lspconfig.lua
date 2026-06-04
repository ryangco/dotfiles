return {
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})
			require("go").setup()
		end,
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"stevearc/conform.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		opts = {
			-- inlay_hints = { enable = false },
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							codeLens = { enable = false },
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
							workspace = {
								checkThirdParty = false,
								maxPreload = 100,
								preloadFileSize = 50,
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				marksman = {
					root_markers = { ".git", ".marksman.toml" },
					single_file_support = true,
				},
				emmet_language_server = {
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
				},
				ts_ls = {
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
				},
				gopls = {
					settings = {
						gopls = {
							analyses = {
								unusedparams = true,
							},
							staticcheck = true,
							gofumpt = true,
						},
					},
				},
				cssls = {
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
				},
				tailwindcss = {
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
				},
				bashls = {},
				jsonls = {},
				pyright = {},
			},
		},
		config = function(_, opts)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("*", { capabilities = capabilities })

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(opts.servers or {})
			vim.list_extend(ensure_installed, {
				-- "stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				automatic_installation = { exclude = "lua_ls" },
			})
		end,
	},
}
