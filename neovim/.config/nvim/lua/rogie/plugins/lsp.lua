return {
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "folke/neodev.nvim", opts = {} },
			"stevearc/conform.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						-- vim.lsp.inlay_hint.enable()
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local servers = {
				-- clangd = {},
				gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				tsserver = {},
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- "stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {
					"volar",
					"tsserver",
					"tailwindcss",
					"cssls",
					"bashls",
					"jsonls",
					-- 'markdownlint',
				},
				automatic_installation = { exclude = "lua_ls" },
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({})
					end,
					-- Next, you can provide a dedicated handler for specific servers.
					-- For example, a handler override for the `rust_analyzer`:
					-- ["rust_analyzer"] = function ()
					--     require("rust-tools").setup {}
					-- end
					-- ["volar"] = function()
					-- 	require("lspconfig").volar.setup({
					-- 		filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
					-- 		init_options = {
					-- 			typescript = {
					-- 				tsdk = vim.fn.getcwd() .. "node_modules/typescript/lib",
					-- 			},
					-- 		},
					-- 	})
					-- end,
					["tsserver"] = function()
						require("lspconfig").tsserver.setup({
							settings = {
								typescript = {
									inlayHints = {
										-- You can set this to 'all' or 'literals' to enable more hints
										includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
										includeInlayParameterNameHintsWhenArgumentMatchesName = false,
										includeInlayFunctionParameterTypeHints = false,
										includeInlayVariableTypeHints = false,
										includeInlayVariableTypeHintsWhenTypeMatchesName = false,
										includeInlayPropertyDeclarationTypeHints = false,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
								javascript = {
									inlayHints = {
										-- You can set this to 'all' or 'literals' to enable more hints
										includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
										includeInlayParameterNameHintsWhenArgumentMatchesName = false,
										includeInlayVariableTypeHints = false,
										includeInlayFunctionParameterTypeHints = false,
										includeInlayVariableTypeHintsWhenTypeMatchesName = false,
										includeInlayPropertyDeclarationTypeHints = false,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
							},
						})
					end,
				},
			})
			-- Servers that are not installed by mason.
			require("lspconfig").lua_ls.setup({
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if
						not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
					then
						client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
							Lua = {
								runtime = {
									-- Tell the language server which version of Lua you're using
									-- (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										"${3rd}/luv/library",
										-- "${3rd}/busted/library",
									},
									-- or pull in all of "runtimepath". NOTE: this is a lot slower
									-- library = vim.api.nvim_get_runtime_file("", true)
								},
								completion = {
									callSnippet = "Replace",
								},
								diagnostics = {
									disable = { "missing-fields" },
									globals = { "vim" },
								},
							},
						})

						client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
					end
					return true
				end,
			})
			-- Conform Formatter!
			require("conform").setup({
				notify_on_error = false,
				format_on_save = function(bufnr)
					local disable_filetypes = { c = true, cpp = true, markdown = true }
					return {
						timeout_ms = 500,
						lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					}
				end,
				formatters_by_ft = {
					go = { { "goimports-reviser", "golines", "gofumpt" } },
					lua = { "stylua" },
					javascript = { { "prettierd", "prettier" } },
					javascriptreact = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					typescriptreact = { { "prettierd", "prettier" } },
					vue = { { "prettierd", "prettier" } },
					css = { { "prettierd", "prettier" } },
					scss = { { "prettierd", "prettier" } },
					less = { { "prettierd", "prettier" } },
					html = { { "prettierd", "prettier" } },
					json = { { "prettierd", "prettier" } },
					jsonc = { { "prettierd", "prettier" } },
					yaml = { { "prettierd", "prettier" } },
					markdown = {},
					["markdown.mdx"] = { { "prettierd", "prettier" } },
					graphql = { { "prettierd", "prettier" } },
					handlebars = { { "prettierd", "prettier" } },
					["_"] = { { "prettierd", "prettier" } },
				},
			})
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ async = true })
			end, { desc = "[F]ormat buffer" })
		end,
	},
}
