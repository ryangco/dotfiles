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
			"stevearc/conform.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		opts = {
			servers = {
				lua_ls = {},
				ts_ls = {},
				volar = {},
				tailwindcss = {},
				cssls = {},
				bashls = {},
				jsonls = {},
				gopls = {},
				pyright = {},
			},
		},
		config = function()
			--[[ local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					require("blink.cmp").get_lsp_capabilities(config.capabilities)
				)
				lspconfig[server].setup(config)
			end ]]

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, { desc = "Help Guide" })
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					-- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					-- map("gR", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					-- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					-- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					-- map(
					-- 	"<leader>ws",
					-- 	require("telescope.builtin").lsp_dynamic_workspace_symbols,
					-- 	"[W]orkspace [S]ymbols"
					-- )
					-- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
				end,
			})
			local servers = {
				-- clangd = {},
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				pyright = {},
				ts_ls = {},
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				ensure_installed = {
					"volar",
					"ts_ls",
					"tailwindcss",
					"cssls",
					"bashls",
					"jsonls",
					-- 'markdownlint',
				},
				-- automatic_installation = { exclude = "lua_ls" },
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
					["ts_ls"] = function()
						require("lspconfig").ts_ls.setup({
							settings = {
								typescript = {
									inlayHints = {
										-- You can set this to 'all' or 'literals' to enable more hints
										includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
										includeInlayParameterNameHintsWhenArgumentMatchesName = true,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = true,
										includeInlayVariableTypeHintsWhenTypeMatchesName = true,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
								javascript = {
									inlayHints = {
										-- You can set this to 'all' or 'literals' to enable more hints
										includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all'
										includeInlayParameterNameHintsWhenArgumentMatchesName = true,
										includeInlayVariableTypeHints = true,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHintsWhenTypeMatchesName = true,
										includeInlayPropertyDeclarationTypeHints = true,
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
		end,
	},
}
