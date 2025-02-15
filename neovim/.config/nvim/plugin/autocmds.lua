local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
	desc = "LSP options and keymaps",
	group = vim.api.nvim_create_augroup("UserLspHighlight", { clear = true }),
	callback = function(event)
		-- local id = vim.tbl_get(event, "data", "client_id")
		local id = event.data.client_id
		local client = id and vim.lsp.get_client_by_id(id)

		if not client then
			return
		end

		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end

		-- if client.supports_method("textDocument/codeLens", event.buf) then
		if client.server_capabilities.documentHighlightProvider then
			autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = event.buf,
				callback = function(ev)
					vim.lsp.codelens.refresh({ bufnr = ev.buf })
				end,
			})
		end

		-- if client.supports_method("textDocument/documentHighlight") then
		if client.server_capabilities.documentHighlightProvider then
			autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = vim.api.nvim_create_augroup("UserLspHighlight", { clear = true }),
				callback = vim.lsp.buf.document_highlight,
			})

			autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = vim.api.nvim_create_augroup("UserLspHighlight", { clear = true }),
				callback = vim.lsp.buf.clear_references,
			})

			autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("UserLspHighlight", { clear = true }),
				buffer = event.buf,
				callback = function(ev)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "UserLspHighlight", buffer = ev.buf })
				end,
			})
		end

		--[[ if client.supports_method("textDocument/formatting") then
			autocmd("BufWritePre", {
				buffer = event.buf,
				group = vim.api.nvim_create_augroup("UserLspEfm", { clear = true }),
				callback = function(ev)
					vim.lsp.buf.format({
						async = false,
						bufnr = ev.buf,
						timeout_ms = 10000,
						filter = function(c)
							return c.name == "efm"
						end,
					})
				end,
			})
		end ]]
	end,
})

autocmd("WinEnter", {
	desc = "Automatically close Vim if the quickfix window is the only one open",
	group = vim.api.nvim_create_augroup("UserWindows", { clear = true }),
	callback = function()
		if vim.fn.winnr("$") == 1 and vim.fn.win_gettype() == "quickfix" then
			vim.cmd.q()
		end
	end,
})

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("UserHighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

autocmd("FileType", {
	desc = "Close with <q>",
	group = vim.api.nvim_create_augroup("UserFileType", { clear = true }),
	pattern = { "dap-float", "diff", "git", "help", "man", "qf", "query" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = event.buf })
	end,
})
