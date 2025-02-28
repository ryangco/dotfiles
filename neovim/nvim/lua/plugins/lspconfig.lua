return {
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
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
				ft = "lua",
				opts = {
					library = {
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
			},
		},
		config = function(_, opts)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local lspconfig = require("lspconfig")

			for server, config in pairs(opts.servers) do
				-- blink
				-- config.capabilities = vim.tbl_deep_extend(
				-- 	"force",
				-- 	capabilities,
				-- 	require("blink.cmp").get_lsp_capabilities(config.capabilities)
				-- )

				-- nvim-cmp
				config.capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
				lspconfig[server].setup(config)
			end

			require("mason").setup()
			local ensure_installed = vim.tbl_keys(opts.servers or {})
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
						local server = opts.servers[server_name] or {}
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
