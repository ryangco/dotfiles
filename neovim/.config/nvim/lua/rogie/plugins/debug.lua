return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		require("mason-nvim-dap").setup({
			automatic_setup = true,
			handlers = {},
			ensure_installed = {
				"delve",
			},
		})
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<leader>dus", function()
			local widgets = require("dap.ui.widgets")
			local sidebar = widgets.sidebar(widgets.scopes)
			sidebar.open()
		end, { desc = "Open debug sidebar" })
		vim.keymap.set("n", "<leader>dlp", function()
			require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "Debug Log Point" })
		vim.keymap.set("n", "<leader>ddr", function()
			require("dap").repl.open()
		end, { desc = "Debug REPL Open" })
		vim.keymap.set("n", "<leader>ddl", function()
			require("dap").run_last()
		end, { desc = "Debug Debug Last" })
		vim.keymap.set({ "n", "v" }, "<leader>ddh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "Hover Widget" })
		vim.keymap.set({ "n", "v" }, "<leader>ddp", function()
			require("dap.ui.widgets").preview()
		end, { desc = "Preview Widget" })
		vim.keymap.set("n", "<leader>ddf", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.frames)
		end, { desc = "Frames Float" })
		vim.keymap.set("n", "<leader>dds", function()
			local widgets = require("dap.ui.widgets")
			widgets.centered_float(widgets.scopes)
		end, { desc = "Scopes Widget" })

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
		vim.keymap.set("n", "<space>?", function()
			dapui.eval(nil, { enter = true })
		end)

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		require("nvim-dap-virtual-text").setup({
			display_callback = function(variable)
				local name = string.lower(variable.name)
				local value = string.lower(variable.value)
				if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
					return "*****"
				end
				if #variable.value > 15 then
					return " " .. string.sub(variable.value, 1, 15) .. "... "
				end
				return " " .. variable.value
			end,
		})

		local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
		if elixir_ls_debugger ~= "" then
			dap.adapters.mix_task = {
				type = "executable",
				command = elixir_ls_debugger,
			}
			dap.configurations.elixir = {
				{
					type = "mix_task",
					name = "phoenix server",
					task = "phx.server",
					request = "launch",
					projectDir = "${workspaceFolder}",
					exitAfterTaskReturns = false,
					debugAutoInterpretAllModules = false,
				},
			}
		end

		require("dap-go").setup()
	end,
}
